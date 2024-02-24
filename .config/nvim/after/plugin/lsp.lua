-- Setup LSP
local servers = {
	terraformls = {},
	pyright = {},
	prismals = {},
	jsonls = {},
	elixirls = {},
	tsserver = {
		root_dir = require("lspconfig.util").root_pattern(".git"),
	},
	lua_ls = {
		Lua = {
			diagnostics = {
				globals = { "vim", "use" },
			},
		},
	},
}

local on_attach = function(_, bufnr)
	local buf = { buffer = bufnr }

	-- Keymaps
	Nn("[g", vim.diagnostic.goto_prev, buf)
	Nn("]g", vim.diagnostic.goto_next, buf)
	Nn("gl", vim.diagnostic.open_float, buf)
	Nn("gr", vim.lsp.buf.references, buf)
	Nn("gD", vim.lsp.buf.declaration, buf)
	Nn("gd", vim.lsp.buf.definition, buf)
	Nn("gt", vim.lsp.buf.type_definition, buf)
	Nn("K", vim.lsp.buf.hover, buf)
	Nn("<c-K>", vim.lsp.buf.signature_help, buf)
	Nn("<leader>rn", vim.lsp.buf.rename, buf)
	Nn("<leader>a", vim.lsp.buf.code_action, buf)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
})

-- Change diagnostic symbols
local lspSymbol = function(name, icon)
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, texthl = hl })
end
lspSymbol("Error", "")
lspSymbol("Information", "")
lspSymbol("Hint", "")
lspSymbol("Info", "")
lspSymbol("Warn", "")

-- Setup linting
local lint = require("lint")

lint.linters_by_ft = {
	elixir = { "credo" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})

-- Setup formatting
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		json = { "fixjson" },
		javascript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
		typescript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

-- Setup null-ls
-- local null = require("null-ls")

-- local f = null.builtins.formatting
-- local d = null.builtins.diagnostics
-- local a = null.builtins.code_actions

-- null.setup({
-- 	logging = false,
-- 	debug = true,
-- 	sources = {
-- 		f.eslint_d,
-- 		f.stylua,
-- 		f.fixjson,
-- 		f.prismaFmt,
-- 		f.black,
-- 		f.terraform_fmt,
-- 		f.markdownlint,
-- 		d.markdownlint,
-- 	},
-- 	on_attach = on_attach,
-- })

-- Setup language servers
-- local servers = {
-- 	"terraformls",
-- 	"pyright",
-- 	"prismals",
-- 	"jsonls",
-- 	{
-- 		"eslint",
-- 		{
-- 			root_dir = lsp_util.root_pattern(".git"),
-- 		},
-- 	},
-- 	{
-- 		"tsserver",
-- 		{
-- 			root_dir = lsp_util.root_pattern(".git"),
-- 		},
-- 	},
-- 	{
-- 		"lua_ls",
-- 		{
-- 			settings = {
-- 				lua = {
-- 					diagnostics = {
-- 						globals = { "vim", "use" },
-- 					},
-- 				},
-- 			},
-- 		},
-- 	},
-- }

-- for _, v in pairs(servers) do
-- 	local language = nil
-- 	local settings = {}

-- 	if v[1] then
-- 		language = v[1]
-- 		settings = v[2]
-- 	else
-- 		language = v
-- 	end

-- 	lsp[language].setup(vim.tbl_extend("force", {
-- 		on_attach = on_attach,
-- 		capabilities = capabilities,
-- 	}, settings))
-- end
