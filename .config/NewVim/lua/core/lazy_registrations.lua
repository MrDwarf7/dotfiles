return {

	{
		{ "tpope/vim-fugitive", event = "VeryLazy" }, -- Automatic setup
		{ "nvim-telescope/telescope-dap.nvim", event = "BufReadPost" }, -- Automatic setup
		{ "tpope/vim-surround", event = "BufEnter" }, -- Automatic setup
	},

	-------------------------- PLUGIN SETUP BEGINS --------------------------
	--------------------- BASICS

	{
		"folke/tokyonight.nvim",
		lazy = false,
		enabled = true,
		priority = 1000,
		config = function()
			require("colorschemes.tokyonight")
		end,
	},

	{
		"prichrd/netrw.nvim",
		lazy = false,
		priority = 1000,
		opts = true,
	},

	{
		"folke/neodev.nvim",
		event = "BufReadPost",
		config = function()
			require("configs.neodev")
		end,
	}, -- Before lspconfig

	{
		"folke/which-key.nvim", -- config call
		event = "VeryLazy",
		opts = function()
			require("configs.which_key")
		end,
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			require("configs.trouble")
		end,
	},

	{
		"ggandor/leap.nvim",
		lazy = false,
		dependencies = {
			"tpope/vim-repeat",
		},
		config = function()
			require("configs.leap")
		end,
	},

	--------------------- END BASICS
	--------------------- BASICS TWO

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		event = { "VeryLazy", "BufReadPre" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "ThePrimeagen/harpoon", branch = "harpoon2" }, -- Telescope
			{ "nvim-telescope/telescope-fzy-native.nvim", build = "make" }, -- Telescope
			"AckslD/nvim-neoclip.lua", -- Telescope
			"nvim-telescope/telescope-live-grep-args.nvim", -- Telescope
			"cljoly/telescope-repo.nvim", -- Telescope
		},
		config = function()
			require("configs.telescope")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPost",
		build = ":TSUpdate",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			"windwp/nvim-ts-autotag",
		},
		config = function()
			require("configs.treesitter")
		end,
	},

	{
		"numToStr/Comment.nvim",
		event = "BufReadPre",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("configs.comment")
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("configs.lualine")
		end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		-- event = "BufReadPost",
		ft = {
			"css",
			"html",
			"javascript",
			"lua",
			"markdown",
			"scss",
			"txt",
			"vim",
			"yaml",
			"json",
			"typescript",
			"typescriptreact",
			"javascriptreact",
			"norg",
			"org",
			"pandoc",
			"markdown",
		},
		config = function()
			require("colorizer").setup()
		end,
	},

	{
		"folke/todo-comments.nvim",
		event = "BufReadPost",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},

	{
		"mbbill/undotree",
		event = "VeryLazy",
		config = function()
			require("configs.undotree")
		end,
	},

	{
		"RRethy/vim-illuminate",
		event = "BufReadPost",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("configs.illuminate")
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		main = "ibl",
		config = function()
			require("configs.blankline")
		end,
	},

	---- TELESCOPE PLUGINS

	{
		"ThePrimeagen/harpoon",
		event = "VeryLazy",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("configs.local_telescope_plugins.harpoon")
		end,
	},

	---- END TELESCOPE PLUGINS
	--------------------- END BASICS TWO
	------------ LSP stuff

	{
		"lvimuser/lsp-inlayhints.nvim",
		event = "LspAttach",
		config = function()
			require("lsp-inlayhints").setup({})
		end,
	},

	{
		"williamboman/mason.nvim", -- KEEP ORDER (Mason, Mason-Lspconfig, nvim-lspconfig)
		event = "BufEnter",
		config = function()
			require("configs.lsp_related.mason")
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim", -- KEEP ORDER (Mason, Mason-Lspconfig, nvim-lspconfig)
		event = "BufEnter",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("configs.lsp_related.mason-lspconfig")
		end,
	},

	{
		"neovim/nvim-lspconfig", -- KEEP ORDER (Mason, Mason-Lspconfig, nvim-lspconfig) -- nvim-cmp requires this
		event = {
			"VeryLazy",
			"BufReadPost",
			"BufWritePre",
			"BufReadPre",
			"InsertEnter", -- These ones I've added recently due to AU command issue?
		},
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("configs.lsp_related.nvim-lspconfig")
		end,
	},

	{
		"nvimdev/lspsaga.nvim", -- Okay this one is a BANGERRRRRRRRRRRR
		event = "BufReadPost",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("configs.lsp_related.lspsaga")
		end,
	},

	---- LSP specific plugins

	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		ft = { "rust" },
		event = "VeryLazy",
		config = function()
			require("configs.lsp_related.rustaceanvim").rustaceanvim_setup()
		end,
	},

	{
		"pmizio/typescript-tools.nvim",
		ft = {
			"css",
			"html",
			"javascript",
			"lua",
			"markdown",
			"scss",
			"txt",
			"vim",
			"yaml",
			"json",
			"typescript",
			"typescriptreact",
			"javascriptreact",
			"norg",
			"org",
			"pandoc",
			"markdown",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},

	{
		"ray-x/go.nvim",
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("configs.lsp_related.go")
		end,
	},

	{
		"Civitasv/cmake-tools.nvim",
		ft = { "cmake", "cpp", "h", "hpp" },
		config = function()
			require("configs.lsp_related.cmake")
		end,
	},

	---- END LSP specific plugins

	{
		"j-hui/fidget.nvim",
		lazy = false,
		-- event = "BufReadPre",
		opts = {},
	},

	------------ END LSP stuff
	--------------------- DAP (kinda)

	{
		"mfussenegger/nvim-dap",
		event = { "BufReadPost", "BufWritePre" },
		dependencies = {
			-- "rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			require("configs.dap_related.nvim_dap")
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("configs.dap_related.nvim_dap_ui")
		end,
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("configs.dap_related.mason_dap")
		end,
	},

	--------------------- END DAP
	--------------------- FORMATTING/LINTING

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufWritePre" },
		config = function()
			require("configs.lint")
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufReadPost", "BufWritePre" },
		config = function()
			require("configs.conform")
		end,
	},

	--------------------- END FORMATTING/LINTING
	--------------------- COMPLETION

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"petertriho/cmp-git",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",

			"L3MON4D3/LuaSnip",

			"saadparwaiz1/cmp_luasnip",
			"zbirenbaum/copilot-cmp",
			-- "zbirenbaum/copilot.lua",

			"saecki/crates.nvim",
			"vrslev/cmp-pypi",

			"onsails/lspkind.nvim",
		},
		config = function()
			local full_setup = require("configs.cmp_related.cmp")
			full_setup.cmp_full_setup()
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("configs.cmp_related.autopairs")
		end,
	},

	{
		"saecki/crates.nvim",
		ft = { "toml", "rust" },
		-- event = "VeryLazy",
		tag = "stable",
		config = function()
			require("crates").setup()
		end,
	},

	{
		"vrslev/cmp-pypi",
		ft = { "toml", "python" },
		-- event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	--------------------- END COMPLETION
	--------------------- MISC

	{
		"linux-cultist/venv-selector.nvim",
		event = "LspAttach",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-telescope/telescope.nvim",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			require("configs.venv-selector")
		end,
	},

	{
		"kdheepak/lazygit.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("configs.lazygit")
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("configs.gitsigns")
		end,
	},

	{
		"sindrets/diffview.nvim",
		event = { "VeryLazy", "BufReadPost" },
		config = function()
			require("configs.diffview")
		end,
	},

	{
		"kevinhwang91/nvim-ufo",
		event = "BufReadPost",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			require("configs.ufo")
		end,
	},

	{
		"sindrets/winshift.nvim",
		event = "BufReadPost",
		config = function()
			require("configs.winshift")
		end,
	},

	{
		"gelguy/wilder.nvim",
		event = "CmdlineEnter",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{ "romgrk/fzy-lua-native", build = "make" },
			"nixprime/cpsm",
		},
		config = function()
			require("configs.wilder")
		end,
	},

	{
		"zbirenbaum/copilot.lua",
		event = "BufReadPost",
		config = function()
			require("configs.cmp_related.copilot")
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		event = "InsertEnter",
		dependencies = {
			"zbirenbaum/copilot.lua",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("configs.cmp_related.copilot_cmp")
		end,
	},

	--------------------- END MISC
	-------------------------- PLUGIN SETUP ENDS --------------------------
}
