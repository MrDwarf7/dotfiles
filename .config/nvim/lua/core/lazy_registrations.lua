return {

	{
		{ "tpope/vim-fugitive", event = "VeryLazy" }, -- Automatic setup
		-- { "tpope/vim-surround", event = "BufEnter" }, -- Automatic setup
	},

	{ "nvim-neotest/nvim-nio" },
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
		"nvim-lua/plenary.nvim",
	},

	-- {
	-- 	-- Standalone of it, so can use it non-laizly
	-- 	"echasnovski/mini.files",
	-- 	-- priority = 1000,
	-- 	lazy = false,
	-- 	version = false,
	-- 	config = function()
	-- 		require("mini.files").setup({
	-- 			mappings = {
	-- 				close = "q",
	-- 				go_in = "l",
	-- 				go_in_plus = "L",
	-- 				go_out = "h",
	-- 				go_out_plus = "H",
	-- 				reset = "<BS>",
	-- 				reveal_cwd = "@",
	-- 				show_help = "g?",
	-- 				synchronize = "=",
	-- 				trim_left = "<",
	-- 				trim_right = ">",
	-- 			},
	-- 			options = {
	-- 				use_as_default_explorer = false,
	-- 			},
	-- 			windows = {
	-- 				-- max_number = 5,
	-- 				preview = false,
	-- 				width_focus = 30,
	-- 				width_nofocus = 25,
	-- 				width_preview = 60,
	-- 			},
	-- 		})
	-- 	end,
	-- },

	{
		"stevearc/oil.nvim",
		lazy = false,
		-- event = "InsertEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("configs.oil")
		end,
	},

	-- {
	-- 	"prichrd/netrw.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = true,
	-- },

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
		event = "BufReadPre",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			local map = vim.keymap.set
			require("trouble").setup({})

			map("n", "]]", function()
				require("trouble").next({ skip_groups = true, jump = true })
			end, { silent = true, desc = "[p]robem NEXT" })

			map("n", "[[", function()
				require("trouble").previous({ skip_groups = true, jump = true })
			end, { silent = true, desc = "[p]robem PREV" })
		end,
	},

	-- {
	-- 	"ggandor/leap.nvim",
	-- 	lazy = false,
	-- 	dependencies = {
	-- 		"tpope/vim-repeat",
	-- 	},
	-- 	config = function()
	-- 		require("configs.leap")
	-- 	end,
	-- },

	-- Testing having telescope load really early
	{
		"nvim-telescope/telescope-fzy-native.nvim",
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		lazy = false,
		-- event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",

			{
				"ThePrimeagen/harpoon",
				lazy = true,
				branch = "harpoon2",
				dependencies = {
					"nvim-lua/plenary.nvim",
				},
				-- Config file is required from WITHIN telescope.lua
			},

			{
				"nvim-telescope/telescope-fzy-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			"AckslD/nvim-neoclip.lua", -- Telescope
			"nvim-telescope/telescope-live-grep-args.nvim", -- Telescope
			"cljoly/telescope-repo.nvim", -- Telescope
		},
		config = function()
			require("configs.telescope")
		end,
	},

	{ "nvim-telescope/telescope-dap.nvim", event = "VeryLazy" }, -- Automatic setup

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		lazy = false,
		config = function()
			require("configs.toggleterm")
		end,
	},

	-- Testing having telescope load really early

	--------------------- END BASICS
	--------------------- BASICS TWO

	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufEnter",
		build = ":TSUpdate",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
			"windwp/nvim-ts-autotag",
		},
		config = function()
			require("nvim-treesitter.install").compilers = { "gcc" } --NOTE: currently points to scoop/msys2/current/clang64/bin/gcc.exe
			require("configs.treesitter").setup()
		end,
	},

	{
		"numToStr/Comment.nvim",
		event = "BufReadPost",
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
			-- "kyazdani42/nvim-web-devicons",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			-- Move to extn if wanting to customize it at some point
			require("lualine").setup({
				theme = "tokyonight",
			})
		end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		event = "VeryLazy",
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
			require("colorizer").setup({
				user_default_options = {
					tailwind = "both",
					css = true,
					css_fn = true,
					names = false,
				},
			})
		end,
	},

	{
		"folke/todo-comments.nvim",
		event = "BufReadPost",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("configs.todo-comments")
			-- .setup()
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

	-- {
	-- 	"ThePrimeagen/harpoon",
	-- 	event = "VeryLazy",
	-- 	branch = "harpoon2",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("configs.harpoon")
	-- 	end,
	-- },

	---- END TELESCOPE PLUGINS
	--------------------- END BASICS TWO
	------------ LSP stuff

	{
		"neovim/nvim-lspconfig",
		event = {
			-- "VeryLazy",
			"BufReadPost",
			-- "BufWritePre",
			-- "InsertEnter", -- These ones I've added recently due to AU command issue?
		},
		dependencies = {
			"nvim-telescope/telescope.nvim",
			{
				"folke/neoconf.nvim",
				cmd = "Neoconf",
				config = false,
			},
			{ "folke/neodev.nvim", opts = {} },
			{
				"j-hui/fidget.nvim",
				lazy = false,
				opts = {},
			},
			{
				"williamboman/mason.nvim",
				lazy = false,
				event = "BufEnter",
			},
			{ "williamboman/mason-lspconfig.nvim", lazy = false },
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				lazy = false,
				event = "BufEnter",
			},
		},
		config = function()
			require("configs.lsp")
		end,
	},

	-- {
	-- 	"nvimdev/lspsaga.nvim", -- Okay this one is a BANGERRRRRRRRRRRR
	-- 	event = "BufReadPost",
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	config = function()
	-- 		require("configs.lsp_related.lspsaga")
	-- 	end,
	-- },

	---- LSP specific plugins

	{
		"mrcjkb/rustaceanvim",
		-- lazy = false,
		version = "^4",
		ft = { "rust" },
		config = function()
			require("configs.rustaceanvim").rustaceanvim_setup()
		end,
	},
	--
	{
		"pmizio/typescript-tools.nvim",
		ft = {
			"css",
			"html",
			"javascript",
			-- "lua",
			-- "markdown",
			"scss",
			"txt",
			"vim",
			"yaml",
			"json",
			"typescript",
			"typescriptreact",
			"javascriptreact",
			-- "norg",
			-- "org",
			"pandoc",
			"markdown",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},
	--
	{
		"ray-x/go.nvim",
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
		dependencies = { -- optional packages
			{ "ray-x/guihua.lua", lazy = true },
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		event = { "CmdlineEnter" },
		config = function()
			require("go").setup()
		end,
	},
	--
	{
		"Civitasv/cmake-tools.nvim",
		ft = { "cmake", "cpp", "h", "hpp" },
		config = function()
			require("cmake-tools").setup({})
		end,
	},

	---- END LSP specific plugins

	{
		"j-hui/fidget.nvim",
		event = "VeryLazy",
		opts = {},
	},

	------------ END LSP stuff
	--------------------- DAP (kinda)

	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
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
		event = "BufReadPost",
		config = function()
			require("configs.lint")
		end,
	},

	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
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
			"L3MON4D3/LuaSnip",

			"zbirenbaum/copilot-cmp",
			"hrsh7th/cmp-nvim-lsp",

			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",

			"saadparwaiz1/cmp_luasnip",
			"saecki/crates.nvim",
			"vrslev/cmp-pypi",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("configs.cmp").cmp_full_setup()
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp.event"):on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			})
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
		ft = { "python" },
		-- event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = false },
		},
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
		-- lazy = false,
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		-- opts = {},
		-- config = function()
		-- 	require("configs.lazygit")
		-- end,
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
		event = { "VeryLazy" },
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
			require("configs.copilot")
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
			require("copilot_cmp").setup({
				suggestion = { enabled = true },
				panel = { enabled = false },
			})
		end,
	},

	{
		"echasnovski/mini.nvim",
		event = "BufReadPost",
		config = function()
			require("mini.ai").setup({
				n_lines = 100,
			})
			require("mini.surround").setup()
		end,
	},

	{
		"stevearc/dressing.nvim",
		event = "BufReadPost",
		config = function()
			require("dressing").setup({
				input = {
					insert_only = false,
					border = "rounded",
				},
				mappings = {
					n = {
						["q"] = "Close",
					},
				},
			})
			-- require("configs.dressing")
		end,
	},

	{
		"chentoast/marks.nvim",
		event = "BufReadPost",
		config = function()
			require("configs.marks")
		end,
	},

	{
		"rmagatti/goto-preview",
		lazy = false,
		config = function()
			require("configs.goto_preview")
		end,
	},

	--------------------- END MISC
	-------------------------- PLUGIN SETUP ENDS --------------------------
}
