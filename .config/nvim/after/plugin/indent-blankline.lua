O.list = true
O.listchars:append("space:⋅")

require("indent_blankline").setup({
	space_char_blankline = " ",
	show_end_of_line = true,
	show_current_context = true,
	viewport_buffer = 512,
	use_treesitter = true,
	context_patterns = {
		"arrow_function",
		"comment",
		"class",
		"^func",
		"method",
		"^if",
		"while",
		"for",
		"with",
		"try",
		"except",
		"arguments",
		"argument_list",
		"object",
		"dictionary",
		"element",
		"table",
		"tuple",
		"do_block",
	},
})
