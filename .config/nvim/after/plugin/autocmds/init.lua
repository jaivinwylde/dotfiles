local highlight = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight,
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
	desc = "Highlight a yank",
})

local format = vim.api.nvim_create_augroup("Formating", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = format,
	command = "setlocal formatoptions-=cro",
	desc = "Remove auto comment formatting",
})
