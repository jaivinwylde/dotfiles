Cmd("packadd packer.nvim")

return require("packer").startup(function()
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Markdown view
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- Colorscheme
	use("sainnhe/sonokai")
	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	-- Smooth scrolling
	use("karb94/neoscroll.nvim")
	-- Single line navigation
	use("unblevable/quick-scope")
	-- File icons
	use({
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				default = true,
			})
		end,
	})
	-- Better buffer closing
	use("moll/vim-bbye")
	-- Indent guides
	use("lukas-reineke/indent-blankline.nvim")

	-- Inputs & selects
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("stevearc/dressing.nvim")
	-- File browser
	use({
		"kyazdani42/nvim-tree.lua",
	})
	-- File jump
	use("ThePrimeagen/harpoon")
	-- Incremental line number searching
	use({
		"nacro90/numb.nvim",
		config = function()
			require("numb").setup()
		end,
	})

	-- Complete pairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	})
	-- Lord tpope
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("tpope/vim-commentary")

	-- Language server
	-- use({
	-- 	"VonHeikemen/lsp-zero.nvim",
	-- 	branch = "v3.x",
	-- 	requires = {
	-- 		{ "williamboman/mason.nvim" },
	-- 		{ "williamboman/mason-lspconfig.nvim" },
	-- 		-- LSP Support
	-- 		{ "neovim/nvim-lspconfig" },
	-- 		-- Autocompletion
	-- 		{ "hrsh7th/nvim-cmp" },
	-- 		{ "hrsh7th/cmp-nvim-lsp" },
	-- 		{ "L3MON4D3/LuaSnip" },
	-- 	},
	-- })
	use("neovim/nvim-lspconfig")
	use({
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	})
	use({
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig")
		end,
	})
	-- Completion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")
	use("onsails/lspkind.nvim")
	use("jose-elias-alvarez/null-ls.nvim")
	-- Syntax highlighting
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("nvim-treesitter/nvim-treesitter-context")

	-- Terminals
	use("voldikss/vim-floaterm")

	-- Undo helper
	use("mbbill/undotree")

	-- Git integration
	use("lewis6991/gitsigns.nvim")
end)
