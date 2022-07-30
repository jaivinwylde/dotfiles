-- Help with spelling errors
Nn("<leader>sp", "<cmd>set spell!<cr>")
-- Split line
Nn("<cr>", "i<cr><esc>l")
-- Easier fold toggle
Nn("zo", "za")
-- Close buffers
Nn("<leader>x", "<cmd>Bdelete!<cr>")
Nn("<leader>cl", function()
  -- Close all hidden buffers
  for _, v in pairs(vim.api.nvim_list_bufs()) do
    if vim.fn.bufloaded(v) and vim.fn.bufwinnr(v) < 0 then
      Cmd("Bwipeout " .. v)
    end
  end
end)

-- Move blocks of lines like vscode
V("J", ":m '>+1<cr>gv=gv")
V("K", ":m '>-2<cr>gv=gv")

-- Search mutations
C(";c", "<cr><cmd>t''<cr>") -- Copy searched line to BELOW current location
C(";C", "<cr><cmd>t''-1<cr>") -- Copy searched line to ABOVE current location
C(";m", "<cr><cmd>m''<cr>") -- Move searched line to ABOVE current location
C(";M", "<cr><cmd>m''-1<cr>") -- Move searched line to BELOW current location
C(";d", "<cr>dd<cr>''") -- Delete searched line
