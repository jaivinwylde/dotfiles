local background = '#101010'
local highlight = '#353535'

-- Cmd 'colorscheme koehler'
-- Cmd 'colorscheme lunaperche'
-- Cmd 'colorscheme slate'
Cmd 'colorscheme elflord'

-- Set overrides
local hl = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end

-- Background
hl('Normal', { bg = background })
hl('NonText', { bg = background })
hl('EndOfBuffer', { bg = background })

-- Line numbers
hl('LineNr', { fg = '#666666' })
hl('CursorLineNr', { fg = '#aaaaaa', bold = true })

hl('@text.note', {
  bold = true,
  standout = true,
})
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

-- Legacy indent-blankline (if still used)
hl('IndentBlankLineChar', {
  fg = '#666666',
  nocombine = true,
})
hl('IndentBlankLineContextChar', {
  fg = '#888888',
  nocombine = true,
})
hl('IndentBlankLineSpaceChar', {
  fg = highlight,
  nocombine = true,
})

-- Set gitsigns gutter styles
local reverse_group = function(group)
  local get_color = function(attr) return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr) end

  local fg = get_color 'fg'

  Cmd('highlight ' .. group .. ' gui=bold guifg=' .. fg .. ' guibg=NONE')
end

reverse_group 'GitSignsAdd'
reverse_group 'GitSignsChange'
reverse_group 'GitSignsDelete'

-- Dimmed lualine
local dimmed_bg = '#1a1a1a'
hl('StatusLine', { fg = '#666666', bg = dimmed_bg })
hl('StatusLineNC', { fg = '#444444', bg = dimmed_bg })
