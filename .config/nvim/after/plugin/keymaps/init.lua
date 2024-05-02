-- gF instead of gf
Nn("gf", "gF")
-- Remap <c-a> to <c-i>, default is taken
Nn("<c-c>", "<c-a>")
-- Help with spelling errors
Nn("<leader>sp", "<cmd>set spell!<cr>")
-- Split line
Nn("<cr>", "i<cr><esc>l")
-- Easier fold toggle
Nn("zo", "za")
-- Close buffers
Nn("<c-w>x", "<cmd>Bdelete!<cr>")
Nn("<leader>cl", function()
  -- Close all hidden buffers
  for _, v in pairs(vim.api.nvim_list_bufs()) do
    if vim.fn.bufloaded(v) and vim.fn.bufwinnr(v) < 0 then
      Cmd("Bdelete " .. v)
    end
  end
end)
-- Lazygit
Nn("<leader>g", "<cmd>FloatermNew lazygit<cr>")
-- Navigate tabs
Nn("<leader>t", "<cmd>tabnew<cr>")
Nn("<c-h>", "<cmd>tabp<cr>")
Nn("<c-l>", "<cmd>tabn<cr>")
Nn("<leader><", "<cmd>tabm -1<cr>")
Nn("<leader>>", "<cmd>tabm +1<cr>")
-- Replace entered text with text
Nn("<leader>rs", function()
  vim.ui.input({ prompt = "Replace: " }, function(replace)
    if replace then
      vim.ui.input({ prompt = "With: " }, function(with)
        Feed("m`:%s/" .. replace .. "/" .. with .. "/g<cr>``")
      end)
    end
  end)
end)
-- Replace word under cursor with text
Nn("<leader>rw", function()
  vim.ui.input({ prompt = "Replace with: " }, function(input)
    if input then
      Feed("m`:%s/<c-r><c-w>/" .. input .. "/g<cr>``")
    end
  end)
end)
-- Print last yank, not last delete
Nn(",p", '"0p')
Nn(",P", '"0P')
-- Create new relative file
Nn("<leader>f", function()
  vim.ui.input({ prompt = "Filename: " }, function(input)
    if input then
      Cmd("vsplit %:h/" .. input)
      Cmd("w")
    end
  end)
end)
-- Delete current file
Nn("<leader>df", '<cmd>call delete(expand("%")) | Bdelete!<cr>')

-- Move blocks of lines like vscode
V("J", ":m'>+<cr>gv=gv")
V("K", ":m-2<cr>gv=gv")
-- Multi cursor block select change
V("C", "xgvI")

-- Search mutations
C(";c", "<cr><cmd>t''<cr>")   -- Copy searched line to BELOW current location
C(";C", "<cr><cmd>t''-1<cr>") -- Copy searched line to ABOVE current location
C(";m", "<cr><cmd>m''<cr>")   -- Move searched line to ABOVE current location
C(";M", "<cr><cmd>m''-1<cr>") -- Move searched line to BELOW current location
C(";d", "<cr>dd<cr>''")       -- Delete searched line
-- Remove highlight on esc
Nn("<esc>", "<cmd>noh<cr><esc>")

-- Codeium
I("<c-j>", function() return vim.fn['codeium#Accept']() end, { expr = true, replace_keycodes = false })
