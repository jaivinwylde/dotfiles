local custom_theme = {
  normal = {
    a = { fg = '#666666', bg = '#1a1a1a' },
    b = { fg = '#666666', bg = '#1a1a1a' },
    c = { fg = '#666666', bg = '#1a1a1a' },
  },
  inactive = {
    a = { fg = '#444444', bg = '#1a1a1a' },
    b = { fg = '#444444', bg = '#1a1a1a' },
    c = { fg = '#444444', bg = '#1a1a1a' },
  },
}
custom_theme.insert = custom_theme.normal
custom_theme.visual = custom_theme.normal
custom_theme.replace = custom_theme.normal
custom_theme.command = custom_theme.normal

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = custom_theme,
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}
