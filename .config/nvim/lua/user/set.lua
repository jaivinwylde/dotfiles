-- Default options
O.autoindent = true
O.smartindent = true
O.termguicolors = true
O.colorcolumn = "80"
O.guicursor = "a:blinkon0"
O.scrolloff = 15
O.cmdheight = 1
O.backup = false
O.swapfile = false
O.updatetime = 100
O.diffopt:append("vertical")
O.errorbells = false
O.laststatus = 3
O.background = "dark"
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
O.hlsearch = false
O.incsearch = true
O.ignorecase = true
O.smartcase = true
-- Code folding
O.foldmethod = "expr"
O.foldexpr = "nvim_treesitter#foldexpr()"
O.foldenable = false

-- Make space the leader key
G.mapleader = " "

-- Set quickscope options
G.qs_highlight_on_keys = { "f", "F", "t", "T" }
G.qs_ignorecase = 1
G.qs_delay = 1
