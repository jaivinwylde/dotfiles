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

local quickfix = vim.api.nvim_create_augroup("QuickFixList", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = quickfix,
	pattern = "quickfix",
	callback = function()
		-- Set keymaps in the quickfix buffer
		local buf = { buffer = vim.fn.bufnr("%") }

		Nn("j", "<cmd>cn<cr><c-w>p", buf)
		Nn("k", "<cmd>cp<cr><c-w>p", buf)
		Nn("o", "<c-w>p", buf)
		Nn("<cr>", "<cmd>cexpr []<cr><cmd>cclose<cr>", buf)
	end,
	desc = "Add easy quickfix list commands on list open",
})
