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
  -- {
  --   'folke/tokyonight.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  -- },
  -- { 'ellisonleao/gruvbox.nvim', priority = 1000, opts = ... },
  -- { 'bluz71/vim-moonfly-colors', name = 'moonfly', lazy = false, priority = 1000 },
  {
    'navarasu/onedark.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        style = 'deep',
      }
      require('onedark').load()
    end,
  },
  -- {
  --   'sphamba/smear-cursor.nvim',
  --   config = function()
  --     require('smear_cursor').setup {
  --       stiffness = 0.8,
  --       trailing_stiffness = 0.8,
  --       distance_stop_animating = 0.5,
  --     }
  --   end,

  --   opts = {
  --     -- Smear cursor when switching buffers or windows.
  --     smear_between_buffers = true,
  --     -- Smear cursor when moving within line or to neighbor lines.
  --     -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
  --     smear_between_neighbor_lines = true,
  --     -- Draw the smear in buffer space instead of screen space when scrolling
  --     scroll_buffer_space = true,
  --     -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
  --     -- Smears and particles will look a lot less blocky.
  --     legacy_computing_symbols_support = false,
  --     -- Smear cursor in insert mode.
  --     -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
  --     smear_insert_mode = true,
  --   },
  -- },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      max_lines = 3, -- Limit the context window size
      trim_scope = 'outer',
    },
  },
  { 'https://github.com/kylechui/nvim-surround' },
  { 'https://github.com/moll/vim-bbye' },
  -- {
  --   'karb94/neoscroll.nvim',
  --   opts = { duration_multiplier = 0.5 },
  -- },
  {
    'https://github.com/voldikss/vim-floaterm',
  },
  {
    'https://github.com/junegunn/fzf.vim',
    dependencies = {
      'https://github.com/junegunn/fzf',
    },
    init = function()
      -- Configure fzf actions: ctrl-s for horizontal split, ctrl-v for vertical split
      vim.g.fzf_action = {
        ['ctrl-s'] = 'split',
        ['ctrl-v'] = 'vsplit',
        ['ctrl-t'] = 'tab split',
      }
    end,
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
  { 'tpope/vim-commentary' },
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
            cargo = {
              features = 'all', -- Enable all features
            },
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
          vim.keymap.set('n', 'gr', function()
            vim.lsp.buf.references()
            vim.defer_fn(function()
              local qf_buf = nil
              local qf_win = nil
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == 'qf' then
                  qf_win = win
                  qf_buf = vim.api.nvim_win_get_buf(win)
                  break
                end
              end
              if qf_win then
                vim.api.nvim_set_current_win(qf_win)
                -- j/k: navigate, trigger <CR> via feedkeys, refocus after it fires
                local qf_opts = { buffer = qf_buf, noremap = true, silent = true }
                local function qf_jump(dir)
                  vim.cmd('normal! ' .. dir)
                  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'n', false)
                  vim.schedule(function()
                    if vim.api.nvim_win_is_valid(qf_win) then vim.api.nvim_set_current_win(qf_win) end
                  end)
                end
                vim.keymap.set('n', 'j', function() qf_jump 'j' end, qf_opts)
                vim.keymap.set('n', 'k', function() qf_jump 'k' end, qf_opts)
                -- <CR> or q to close the quickfix window
                vim.keymap.set('n', '<CR>', function() vim.api.nvim_win_close(qf_win, true) end, qf_opts)
                vim.keymap.set('n', 'q', function() vim.api.nvim_win_close(qf_win, true) end, qf_opts)
              end
            end, 50)
          end, opts)
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

      -- Format on save (handled by conform.nvim, see plugin definition above)
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
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      ensure_installed = { 'lua', 'python', 'rust', 'elixir', 'heex' },
      highlight = { enable = true },
    },
  },
  {
    'elixir-editors/vim-elixir',
  },
  {
    'elixir-tools/elixir-tools.nvim',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local elixir = require 'elixir'
      local elixirls = require 'elixir.elixirls'

      elixir.setup {
        nextls = { enable = true },
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = false,
            enableTestLenses = false,
          },
        },
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        rust = { 'dx_fmt', 'leptosfmt', 'rust_analyzer' },
        lua = { 'stylua' },
        python = { 'ruff_format' },
        zig = { 'zigfmt' },
      },
      formatters = {
        leptosfmt = {
          command = 'leptosfmt',
          args = { '--stdin' },
          range_args = function(ctx) return { '--stdin', '--line-start', ctx.start_line, '--line-end', ctx.end_line } end,
          stdin = true,
        },
        dx_fmt = {
          command = 'dx',
          args = { 'fmt', '--file', '$FILENAME' },
          stdin = false,
        },
      },
      format_on_save = {
        lsp_format = 'fallback', -- Use LSP formatter if no conform formatter matches
        timeout_ms = 2000,
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
  },
  {
    'https://github.com/NeogitOrg/neogit',
    cmd = 'Neogit', -- Only load when you run the Neogit command
    config = function() require('neogit').setup() end,
  },
}
