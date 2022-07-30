-- Create a rounded cell theme
local theme = require("lualine.themes.gruvbox")

theme.normal.c.fg = "1c1c1c"
theme.normal.c.bg = "1c1c1c"
theme.insert.c.bg = "1c1c1c"
theme.visual.c.bg = "1c1c1c"
theme.replace.c.bg = "1c1c1c"
theme.command.c.bg = "1c1c1c"

require("lualine").setup {
  refresh = {
    statusline = 100,
  },
  options = {
    theme = theme,
    component_separators = "|",
    section_separators = {},
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {{"filename", path = 1}, "branch"},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {"filetype", "progress", "filesize"},
    lualine_z = {"location"},
  },
  tabline = {},
  extensions = {},
}
