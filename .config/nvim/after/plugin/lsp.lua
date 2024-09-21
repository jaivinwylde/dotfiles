-- Setup LSP
local servers = {
	zls = {},
	svelte = {},
	rust_analyzer = {},
	tailwindcss = {
		filetypes = {
			"css",
			"scss",
			"sass",
			"html",
			"heex",
			"elixir",
			"eruby",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"rust",
			"svelte",
		},
		settings = {
			experimental = {
				classRegex = {
					[[class= "([^"]*)]],
					[[class: "([^"]*)]],
					'~H""".*class="([^"]*)".*"""',
					'~F""".*class="([^"]*)".*"""',
				},
			},
			includeLanguages = {
				typescript = "javascript",
				typescriptreact = "javascript",
				["html-eex"] = "html",
				["phoenix-heex"] = "html",
				heex = "html",
				eelixir = "html",
				elixir = "html",
				elm = "html",
				erb = "html",
				svelte = "html",
				rust = "html",
			},
			tailwindCSS = {
				validate = true,
				lint = {
					cssConflict = "error",
					invalidApply = "error",
					invalidConfigPath = "error",
					invalidScreen = "error",
					invalidTailwindDirective = "error",
					invalidVariant = "error",
					recommendedVariantOrder = "error",
				},
			},
		},
		init_options = {
			userLanguages = {
				elixir = "phoenix-heex",
				eelixir = "phoenix-heex",
				heex = "phoenix-heex",
			},
		},
	},
	terraformls = {},
	ruff = {},
	pyright = {},
	prismals = {},
	jsonls = {},
	elixirls = { settings = { elixirLS = { dialyzerEnabled = true } } },
	eslint = {},
	ts_ls = {},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "use" },
				},
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
			settings = servers[server_name]["settings"],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
})

-- Setup Elixir
-- require("elixir").setup({
--   nextls = { enable = false },
--   credo = { enable = true },
--   elixirls = { enable = false },
-- })

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

-- Setup extra linting
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

-- Setup extra formatting
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black", "flake8" },
		json = { "fixjson" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
	},
	format_on_save = { timeout_ms = 500, lsp_fallback = true },
	notify_on_error = false,
})
