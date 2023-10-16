local M = {}

local bind = function(op, outer_opts)
	outer_opts = outer_opts or { noremap = true }

	return function(lhs, rhs, opts)
		opts = vim.tbl_extend("force", outer_opts, { silent = true }, opts or {})

		vim.keymap.set(op, lhs, rhs, opts)
	end
end

M.n = bind("n", { noremap = false })
M.nn = bind("n")
M.v = bind("v")
M.x = bind("x")
M.i = bind("i")
M.c = bind("c")

return M
