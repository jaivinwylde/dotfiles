-- TODO: Create luasnip mappings

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
