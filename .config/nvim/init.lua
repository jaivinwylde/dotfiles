-- FIXME: ctrl+w= does not work sometimes
-- TODO: Create luasnip mappings
-- TODO: Get refactoring (primeagen)
-- TODO: Get nvim-dap
-- TODO: Figure out lsp move files -> update imports

local Remap = require("user.utils.keymap")
local Feedkeys = require("user.utils.feedkeys")

Nn = Remap.nn
V = Remap.v
C = Remap.c
I = Remap.i

Feed = Feedkeys.feedkeys

O = vim.opt
Cmd = vim.cmd
G = vim.g

require("user")
