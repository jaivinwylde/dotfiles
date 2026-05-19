local M = {}

-- Per-tab-per-file sessions: "filepath::tab_handle" -> { buf, win, tab, job_id, context_file }
M.sessions = {}
M.context_dir = nil
M._debounce_timer = nil

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

function M.session_key(filepath)
  return filepath .. "::" .. vim.api.nvim_get_current_tabpage()
end

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

function M.setup()
  M.context_dir = vim.fn.stdpath("cache") .. "/pi-context"
  vim.fn.mkdir(M.context_dir, "p")

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("PiContext", { clear = true }),
    callback = M.on_cursor_moved,
  })
end

--------------------------------------------------------------------------------
-- Context file path (SHA256 of absolute filepath)
--------------------------------------------------------------------------------

function M.get_context_file(filepath)
  local hash = vim.fn.sha256(filepath)
  return M.context_dir .. "/" .. hash .. ".json"
end

function M.get_state_file(context_file)
  return context_file:gsub("%.json$", ".state.json")
end

--------------------------------------------------------------------------------
-- Write current editor position to context file
--------------------------------------------------------------------------------

function M.write_context()
  local filepath = vim.fn.expand("%:p")
  if filepath == "" then
    return
  end

  local context_file = M.get_context_file(filepath)
  local data = vim.json.encode({
    file = filepath,
    line = vim.fn.line("."),
    column = vim.fn.col("."),
  })

  vim.fn.mkdir(M.context_dir, "p")
  vim.fn.writefile({ data }, context_file)
end

--------------------------------------------------------------------------------
-- Debounced CursorMoved handler
--------------------------------------------------------------------------------

function M.on_cursor_moved()
  if M._debounce_timer then
    M._debounce_timer:stop()
  end
  M._debounce_timer = vim.defer_fn(function()
    M.write_context()
  end, 100)
end

--------------------------------------------------------------------------------
-- Toggle: main entry point for <leader>e
--------------------------------------------------------------------------------

function M.toggle()
  local current_win = vim.api.nvim_get_current_win()
  local current_tab = vim.api.nvim_get_current_tabpage()

  -- 1. If focused on a pi window: close it
  for key, session in pairs(M.sessions) do
    if session.win == current_win and vim.api.nvim_win_is_valid(session.win) then
      M.hide_session(key)
      return
    end
  end

  -- 2. If any pi session is visible in the current tab: refocus it
  for key, session in pairs(M.sessions) do
    if session.win and vim.api.nvim_win_is_valid(session.win) and session.tab == current_tab then
      vim.api.nvim_set_current_win(session.win)
      return
    end
  end

  -- 3. No visible pi in this tab: open or create for the current file
  local filepath = vim.fn.expand("%:p")
  if filepath == "" then
    vim.notify("[pi] No file open", vim.log.levels.WARN)
    return
  end

  local key = M.session_key(filepath)
  local session = M.sessions[key]

  if session and session.buf and vim.api.nvim_buf_is_valid(session.buf) then
    -- Hidden session: show it
    M.show_session(key)
  else
    -- None or stale: create fresh
    if session then
      M.sessions[key] = nil
    end
    M.create_session(filepath)
  end
end

--------------------------------------------------------------------------------
-- Create a new pi terminal session for the given file
--------------------------------------------------------------------------------

function M.create_session(filepath)
  local current_tab = vim.api.nvim_get_current_tabpage()
  local key = M.session_key(filepath)

  -- Destroy any existing pi session in the current tab (one pi buffer per tab)
  for k, s in pairs(M.sessions) do
    if k ~= key and s.tab == current_tab then
      M.destroy_session(k)
    end
  end

  local cwd = vim.fn.fnamemodify(filepath, ":h")
  local context_file = M.get_context_file(filepath)
  local state_file = M.get_state_file(context_file)

  -- Write initial context before starting pi
  M.write_context()

  -- Open a vertical split on the far right
  vim.cmd("botright vsplit")
  local win = vim.api.nvim_get_current_win()

  -- Create a terminal buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(win, buf)

  -- Set width to 40% of the screen
  vim.api.nvim_win_set_width(win, math.floor(vim.o.columns * 0.4))

  -- Keep the buffer alive when the window is closed
  vim.bo[buf].bufhidden = "hide"

  -- Start pi with the context file path as an environment variable
  local cmd = "PI_NVIM_CONTEXT_FILE=" .. vim.fn.shellescape(context_file) .. " pi"
  local job_id = vim.fn.termopen(cmd, { cwd = cwd })

  -- Store session data
  M.sessions[key] = {
    buf = buf,
    win = win,
    tab = current_tab,
    job_id = job_id,
    context_file = context_file,
  }

  ------------------------------------------------------------------
  -- ESC: always exit terminal mode → normal mode (never abort pi)
  -- Ctrl-C: abort pi when busy, exit terminal mode when idle
  --
  -- The pi extension writes a tiny state file on agent_start/agent_end events.
  -- Reading it is a microsecond C call — no perceptible latency.
  ------------------------------------------------------------------
  vim.keymap.set("t", "<Esc>", function()
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, true, true),
      "n",
      false
    )
  end, { buffer = buf, noremap = true })

  vim.keymap.set("t", "<C-c>", function()
    local busy = false
    local ok, raw = pcall(vim.fn.readfile, state_file)
    if ok and raw and #raw > 0 then
      local ok2, decoded = pcall(vim.json.decode, raw[1])
      if ok2 and decoded then
        busy = decoded.busy
      end
    end

    if busy then
      -- Pi is processing: send Ctrl-C (0x03) to abort the agent
      vim.api.nvim_chan_send(job_id, "\3")
    else
      -- Pi is idle: escape terminal mode to normal mode
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, true, true),
        "n",
        false
      )
    end
  end, { buffer = buf, noremap = true })

  -- Focus the terminal window (stay in normal mode; press i to enter terminal mode)
  vim.api.nvim_set_current_win(win)

  -- Clean up session entry when the buffer is wiped
  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer = buf,
    once = true,
    callback = function()
      M.sessions[key] = nil
    end,
  })
end

--------------------------------------------------------------------------------
-- Destroy a session: close window + wipe buffer + kill process
--------------------------------------------------------------------------------

function M.destroy_session(session_key)
  local session = M.sessions[session_key]
  if not session then
    return
  end

  if session.win and vim.api.nvim_win_is_valid(session.win) then
    vim.api.nvim_win_close(session.win, true)
  end
  if session.buf and vim.api.nvim_buf_is_valid(session.buf) then
    vim.api.nvim_buf_delete(session.buf, { force = true })
  end
  M.sessions[session_key] = nil
end

--------------------------------------------------------------------------------
-- Hide a session: close the window, keep the buffer + process alive
--------------------------------------------------------------------------------

function M.hide_session(session_key)
  local session = M.sessions[session_key]
  if not session then
    return
  end

  -- Find a non-pi window in the same tab to return focus to
  local target_win = nil
  local current_tab = vim.api.nvim_get_current_tabpage()
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_tabpage(w) == current_tab then
      local is_pi = false
      for _, s in pairs(M.sessions) do
        if s.win == w then
          is_pi = true
          break
        end
      end
      if not is_pi then
        target_win = w
        break
      end
    end
  end

  if session.win and vim.api.nvim_win_is_valid(session.win) then
    vim.api.nvim_win_close(session.win, true)
  end
  session.win = nil

  if target_win and vim.api.nvim_win_is_valid(target_win) then
    vim.api.nvim_set_current_win(target_win)
  end
end

--------------------------------------------------------------------------------
-- Show a hidden session: reopen the terminal buffer in a vertical split
--------------------------------------------------------------------------------

function M.show_session(session_key)
  local session = M.sessions[session_key]
  if not session or not vim.api.nvim_buf_is_valid(session.buf) then
    -- Buffer was wiped; start fresh
    M.sessions[session_key] = nil
    -- Extract filepath from the key to recreate
    local filepath = session_key:match("^(.-)::")
    if filepath then
      M.create_session(filepath)
    end
    return
  end

  -- Hide any other visible pi sessions in the current tab only
  local current_tab = vim.api.nvim_get_current_tabpage()
  for k, s in pairs(M.sessions) do
    if k ~= session_key and s.win and vim.api.nvim_win_is_valid(s.win) and s.tab == current_tab then
      M.hide_session(k)
    end
  end

  -- Open vertical split on the far right
  vim.cmd("botright vsplit")
  local win = vim.api.nvim_get_current_win()

  -- Attach the existing terminal buffer
  vim.api.nvim_win_set_buf(win, session.buf)
  vim.api.nvim_win_set_width(win, math.floor(vim.o.columns * 0.4))

  session.win = win

  -- Write fresh context (user may have moved since hiding)
  M.write_context()

  -- Focus the terminal window (stay in normal mode)
  vim.api.nvim_set_current_win(win)
end

return M
