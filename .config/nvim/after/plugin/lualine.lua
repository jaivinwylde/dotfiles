local theme = require("lualine.themes.auto")

theme.normal.c.fg = "None"
theme.normal.c.bg = "None"
theme.insert.c.bg = "None"
theme.visual.c.bg = "None"
theme.replace.c.bg = "None"
theme.command.c.bg = "None"

require("lualine").setup({
	refresh = {
		statusline = 100,
	},
	options = {
		theme = theme,
		component_separators = "|",
		section_separators = {},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { { "filename", path = 1 }, "branch" },
		lualine_c = {},
		lualine_x = {},
		lualine_y = { "filetype", "progress", "filesize" },
		lualine_z = { "location" },
	},
	tabline = {},
	extensions = {},
})
