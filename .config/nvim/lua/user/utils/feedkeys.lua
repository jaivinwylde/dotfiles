local M = {}

local feed = function(keys, mode)
	mode = mode or "n"

	local converted = vim.api.nvim_replace_termcodes(keys, true, true, true)
	vim.api.nvim_feedkeys(converted, mode, false)
end

M.feedkeys = feed

return M
