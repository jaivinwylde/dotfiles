Cmd("packadd packer.nvim")

return require("packer").startup(function()
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Colorscheme
  use "ellisonleao/gruvbox.nvim"
  -- Status line
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true }
  }
  -- Smooth scrolling
  use "karb94/neoscroll.nvim"
  -- Single line navigation
  use "unblevable/quick-scope"
  -- File icons
  use "kyazdani42/nvim-web-devicons"
  -- Better buffer closing
  use "moll/vim-bbye"
  -- Indent guides
  use "lukas-reineke/indent-blankline.nvim"

  -- File searching
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = { { "nvim-lua/plenary.nvim" } }
  }
  -- File browser
  use "kyazdani42/nvim-tree.lua"

  -- Comments
  use "numToStr/Comment.nvim"
  -- Complete pairs
  use "windwp/nvim-autopairs"
  -- Lord tpope
  use "tpope/vim-surround"
  use "tpope/vim-repeat"

  -- Language server
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  -- Completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "saadparwaiz1/cmp_luasnip"
  use "L3MON4D3/LuaSnip"
  use "onsails/lspkind.nvim"
  -- Syntax highlighting
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
end)
