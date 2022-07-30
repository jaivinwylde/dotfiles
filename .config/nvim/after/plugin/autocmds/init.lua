local highlight = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
  desc = "Highlight a yank"
})

local format = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = format,
  callback = vim.lsp.buf.formatting,
  desc = "Auto format on buffer save",
})
vim.api.nvim_create_autocmd("FileType", {
  group = format,
  command = "setlocal formatoptions-=cro",
  desc = "Remove auto comment formatting"
})
