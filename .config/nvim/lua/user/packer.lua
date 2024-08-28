Cmd("packadd packer.nvim")

return require("packer").startup(function()
	-- shovels
	use("~/Desktop/Projects/100x.nvim")
	use("MunifTanjim/nui.nvim")

	-- llm
	use("yetone/avante.nvim", {
		event = "VeryLazy",
		run = "make",
		requires = {
			"nvim-tree/nvim-web-devicons",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			{
				"MeanderingProgrammer/render-markdown.nvim",
				config = function()
					require("render-markdown").setup({
						file_types = { "markdown", "Avante" },
					})
				end,
				ft = { "markdown", "Avante" },
			},
		},
	})

	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Colorscheme
	use("sainnhe/sonokai")
	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	-- Single line navigation
	use("unblevable/quick-scope")
	-- Better buffer closing
	use("moll/vim-bbye")
	-- Better quickfix
	use("kevinhwang91/nvim-bqf")
	-- Indent guides
	use("lukas-reineke/indent-blankline.nvim")

	-- Inputs & selects
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("stevearc/dressing.nvim")
	-- File browser
	use("stevearc/oil.nvim")
	use({
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				default = true,
			})
		end,
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
	use("neovim/nvim-lspconfig")
	use({
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	})
	use("williamboman/mason-lspconfig.nvim")
	use("stevearc/conform.nvim")
	use("mfussenegger/nvim-lint")
	use({ "elixir-tools/elixir-tools.nvim", tag = "stable", requires = { "nvim-lua/plenary.nvim" } })
	-- Completion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")
	use("onsails/lspkind.nvim")
	use("Exafunction/codeium.vim")
	-- Syntax highlighting
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Terminals
	use("voldikss/vim-floaterm")

	-- Undo helper
	use("mbbill/undotree")

	-- Git integration
	use("lewis6991/gitsigns.nvim")
end)
