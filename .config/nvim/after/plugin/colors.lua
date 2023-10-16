local background = "#121212"
local highlight = "#353535"

G.sonokai_style = "default"
G.sonokai_better_performance = 1
G.sonokai_enable_italic = 1
G.sonokai_transparent_background = 1
G.sonokai_diagnostic_virtual_text = "colored"

Cmd("colorscheme sonokai")

-- Set overrides
local hl = function(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

hl("@text.note", {
	bold = true,
	standout = true,
})
hl("WinSeparator", {
	fg = highlight,
})
hl("QuickScopePrimary", {
	bold = true,
	bg = "#6dcccc",
	fg = background,
})
hl("QuickScopeSecondary", {
	bold = true,
	bg = "#888888",
	fg = background,
})
hl("SignColumn", {
	bg = "None",
})
hl("IndentBlankLineChar", {
	fg = highlight,
	nocombine = true,
})
hl("IndentBlankLineContextChar", {
	fg = "#888888",
	nocombine = true,
})
hl("IndentBlankLineSpaceChar", {
	fg = highlight,
	nocombine = true,
})

-- Set gitsigns gutter styles
local reverse_group = function(group)
	local get_color = function(attr)
		return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
	end

	local fg = get_color("fg")

	Cmd("highlight " .. group .. " gui=bold guifg=" .. fg .. " guibg=NONE")
end

reverse_group("GitSignsAdd")
reverse_group("GitSignsChange")
reverse_group("GitSignsDelete")
