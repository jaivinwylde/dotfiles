local lsp = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Create mappings
Nn("gp", vim.diagnostic.goto_prev)
Nn("gn", vim.diagnostic.goto_next)
Nn("gl", "<cmd>Telescope diagnostics<cr>")

local on_attach = function(_, bufnr)
  local buf = { buffer = bufnr }

  Nn("gd", vim.lsp.buf.definition, buf)
  Nn("gr", vim.lsp.buf.references, buf)
  Nn("K", vim.lsp.buf.hover, buf)
  Nn("<leader>r", vim.lsp.buf.rename, buf)
  Nn("<leader>a", vim.lsp.buf.code_action, buf)
end

-- Setup language servers
local languages = {
  "tsserver",
  {
    "sumneko_lua",
    {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "use" }
          }
        }
      }
    }
  }
}

for _, v in pairs(languages) do
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
    capabilities = capabilities
  }, settings))
end
