local lsp = require("lspconfig")
local lsp_util = require("lspconfig.util")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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

-- Setup null-ls
local null = require("null-ls")

local f = null.builtins.formatting
local d = null.builtins.diagnostics
-- local a = null.builtins.code_actions

null.setup({
	logging = false,
	debug = true,
	sources = {
		f.eslint_d,
		f.stylua,
		f.fixjson,
		f.prismaFmt,
		f.black,
		f.terraform_fmt,
		f.markdownlint,
		d.markdownlint,
	},
	on_attach = on_attach,
})

-- Setup language servers
local servers = {
	"terraformls",
	"pyright",
	"prismals",
	"jsonls",
	{
		"eslint",
		{
			root_dir = lsp_util.root_pattern(".git"),
		},
	},
	{
		"tsserver",
		{
			root_dir = lsp_util.root_pattern(".git"),
		},
	},
	{
		"lua_ls",
		{
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "use" },
					},
				},
			},
		},
	},
}

for _, v in pairs(servers) do
	local language = nil
	local settings = {}

	if v[1] then
		language = v[1]
		settings = v[2]
	else
		language = v
	end

	lsp[language].setup(vim.tbl_extend("force", {
		on_attach = on_attach,
		capabilities = capabilities,
	}, settings))
end
