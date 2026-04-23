local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup {
  { 'https://github.com/kylechui/nvim-surround' },
  {
    'karb94/neoscroll.nvim',
    opts = { duration_multiplier = 0.5 },
  },
  {
    'https://github.com/voldikss/vim-floaterm',
  },
  {
    'https://github.com/junegunn/fzf.vim',
    dependencies = {
      'https://github.com/junegunn/fzf',
    },
    keys = {
      { '<Leader>ps', '<Cmd>Files<CR>', desc = 'Find files' },
      { '<Leader>,', '<Cmd>Buffers<CR>', desc = 'Find buffers' },
      { '<Leader>pg', '<Cmd>Rg<CR>', desc = 'Search project' },
    },
  },
  {
    'https://github.com/stevearc/oil.nvim',
    config = function() require('oil').setup() end,
    keys = {
      { '-', '<Cmd>Oil<CR>', desc = 'Browse files from here' },
    },
  },
  {
    'https://github.com/windwp/nvim-autopairs',
    event = 'InsertEnter', -- Only load when you enter Insert mode
    config = function() require('nvim-autopairs').setup() end,
  },
  {
    'https://github.com/numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()

      -- Explicitly set Rust commentstring for Comment.nvim
      local ft = require 'Comment.ft'
      ft.set('rust', { '//%s', '/*%s*/' })
    end,
  },
  {
    'https://github.com/tpope/vim-sleuth',
    event = { 'BufReadPost', 'BufNewFile' }, -- Load after your file content
  },
  {
    'https://github.com/williamboman/mason.nvim',
    dependencies = {
      'https://github.com/williamboman/mason-lspconfig.nvim',
      'https://github.com/neovim/nvim-lspconfig',
      'https://github.com/hrsh7th/nvim-cmp',
      'https://github.com/hrsh7th/cmp-nvim-lsp',
      'https://github.com/L3MON4D3/LuaSnip',
    },
    config = function()
      -- Mason handles binary installation
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = { 'lua_ls', 'pyright', 'rust_analyzer' },
      }

      -- Configure LSP capabilities for nvim-cmp
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Configure lua_ls for Neovim development
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Configure rust_analyzer
      vim.lsp.config('rust_analyzer', {
        capabilities = capabilities,
        settings = {
          ['rust-analyzer'] = {
            cargo = { allFeatures = true },
            checkOnSave = true,
          },
        },
      })

      -- Configure pyright
      vim.lsp.config('pyright', {
        capabilities = capabilities,
      })

      -- Enable all servers
      vim.lsp.enable { 'lua_ls', 'pyright', 'rust_analyzer' }

      -- LSP keybindings via LspAttach autocmd
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
        callback = function(ev)
          -- Set buffer-local keymaps
          local opts = { buffer = ev.buf, silent = true }

          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format { async = false } end, opts)
          vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '[g', function() vim.diagnostic.jump { count = -1, float = true } end, opts)
          vim.keymap.set('n', ']g', function() vim.diagnostic.jump { count = 1, float = true } end, opts)
        end,
      })

      -- Completion setup
      local cmp = require 'cmp'
      cmp.setup {
        preselect = cmp.PreselectMode.None,
        formatting = {
          format = function(entry, vim_item)
            local MAX_ABBR_WIDTH = 50
            local MAX_MENU_WIDTH = 30

            -- Truncate abbr (the actual completion text)
            if string.len(vim_item.abbr) > MAX_ABBR_WIDTH then vim_item.abbr = string.sub(vim_item.abbr, 1, MAX_ABBR_WIDTH - 1) .. '…' end

            -- Truncate menu (the type/source info)
            if vim_item.menu and string.len(vim_item.menu) > MAX_MENU_WIDTH then vim_item.menu = string.sub(vim_item.menu, 1, MAX_MENU_WIDTH - 1) .. '…' end

            return vim_item
          end,
        },
        window = {
          completion = {
            max_height = 15,
          },
        },
        sources = {
          {
            name = 'nvim_lsp',
            entry_filter = function(entry)
              -- Filter out snippet completions
              return require('cmp').lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            end,
          },
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm { select = false },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        snippet = {
          expand = function(args) require('luasnip').lsp_expand(args.body) end,
        },
      }

      -- Diagnostic config
      vim.diagnostic.config {
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
      }

      -- Format on save
      vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function() vim.lsp.buf.format { async = false } end,
      })
    end,
  },
  {
    -- smart open files at last position
    'https://github.com/farmergreg/vim-lastplace',
    event = 'BufReadPost',
  },
  {
    'https://github.com/unblevable/quick-scope',
  },
  {
    'https://github.com/lukas-reineke/indent-blankline.nvim',
    event = { 'VeryLazy' },
    config = function() require('ibl').setup() end,
  },
  {
    'https://github.com/NeogitOrg/neogit',
    cmd = 'Neogit', -- Only load when you run the Neogit command
    config = function() require('neogit').setup() end,
  },
}
