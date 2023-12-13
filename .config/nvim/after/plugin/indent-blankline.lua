O.list = true
O.listchars:append("space:⋅")

require("ibl").setup({
	indent = {
		char = "▏",
		tab_char = "→",
	},
	scope = { enabled = true, char = "▎", show_end = false, show_start = false },
	viewport_buffer = { min = 100, max = 512 },
	-- use_treesitter = true,
	-- context_patterns = {
	-- 	"arrow_function",
	-- 	"comment",
	-- 	"class",
	-- 	"^func",
	-- 	"method",
	-- 	"^if",
	-- 	"while",
	-- 	"for",
	-- 	"with",
	-- 	"try",
	-- 	"except",
	-- 	"arguments",
	-- 	"argument_list",
	-- 	"object",
	-- 	"dictionary",
	-- 	"element",
	-- 	"table",
	-- 	"tuple",
	-- 	"do_block",
	-- },
})
