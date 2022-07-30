require("neoscroll").setup {
  easing_function = "quadratic"
}

local m = {}

m["<C-u>"] = {"scroll", {"-vim.wo.scroll", "true", "150"}}
m["<C-d>"] = {"scroll", { "vim.wo.scroll", "true", "150"}}
m["<C-b>"] = {"scroll", {"-vim.api.nvim_win_get_height(0)", "true", "150"}}
m["<C-f>"] = {"scroll", { "vim.api.nvim_win_get_height(0)", "true", "150"}}
m["zt"]    = {"zt", {"150"}}
m["zz"]    = {"zz", {"150"}}
m["zb"]    = {"zb", {"150"}}

require('neoscroll.config').set_mappings(m)
