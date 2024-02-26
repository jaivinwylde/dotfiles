-- Default options
O.termguicolors = true
O.cursorline = true
O.wrap = true
O.colorcolumn = "80"
O.guicursor = "a:blinkon0"
O.scrolloff = 999
O.diffopt:append("vertical")
O.errorbells = false
O.background = "dark"
-- Splits
O.winfixwidth = false
O.winfixheight = false
O.winwidth = 10
O.winheight = 10
O.equalalways = true
-- Indents
O.autoindent = true
-- No weird file stuff
O.backup = false
O.swapfile = false
-- Really fast updates
O.updatetime = 20
-- One status bar
O.laststatus = 3
-- Emojis are broken
O.emoji = false
-- Command line
O.wildmode = { "longest", "full" }
O.wildignorecase = true
O.fileignorecase = true
O.ls = 0
O.ch = 1
-- O.cmdheight = 1
-- Enable hidden buffers
O.hidden = true
-- Disable "Enter to continue" messages
O.shortmess:append("c")
-- Persist the undo tree
O.undofile = true
-- Better autocomplete options
O.completeopt = { "menu", "menuone", "noselect" }
O.pumheight = 5
-- Mouse support
O.mouse = "a"
-- Tabs
O.expandtab = true
O.tabstop = 2
O.shiftwidth = 2
-- Number line
O.number = true
O.relativenumber = true
O.signcolumn = "yes"
-- Search
O.hlsearch = true
O.incsearch = true
O.ignorecase = true
O.smartcase = true

-- Make space the leader key
G.mapleader = " "

-- Quickscope options
G.qs_highlight_on_keys = { "f", "F", "t", "T" }
G.qs_ignorecase = 0
G.qs_delay = 1

-- Floaterm options
G.floaterm_width = 0.95
G.floaterm_height = 0.95
