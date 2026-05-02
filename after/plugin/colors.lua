local background = '#080808'
local highlight = '#353535'

-- Cmd 'colorscheme koehler'
-- Cmd 'colorscheme lunaperche'
-- Cmd 'colorscheme slate'
-- Cmd 'colorscheme elflord'
-- Cmd 'colorscheme tokyonight-night'
Cmd 'colorscheme onedark'

-- Set overrides
local hl = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end

-- Background
hl('Normal', { bg = background })
hl('NormalNC', { bg = background })
hl('NonText', { bg = background })
hl('EndOfBuffer', { bg = background })

-- Line numbers
hl('LineNr', { fg = '#666666' })
hl('CursorLineNr', { fg = '#aaaaaa', bold = true })

hl('WinSeparator', {
  fg = highlight,
})
hl('QuickScopePrimary', {
  bold = true,
  bg = '#6dcccc',
  fg = background,
})
hl('QuickScopeSecondary', {
  bold = true,
  bg = '#888888',
  fg = background,
})
hl('SignColumn', {
  bg = 'None',
})
-- Indent lines (new ibl plugin)
hl('IblIndent', { fg = '#666666' })
hl('IblScope', { fg = '#888888' })

-- Dimmed lualine
local dimmed_bg = '#1a1a1a'
hl('StatusLine', { fg = '#666666', bg = dimmed_bg })
hl('StatusLineNC', { fg = '#444444', bg = dimmed_bg })
