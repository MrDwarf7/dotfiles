return {
	{
		"nathom/filetype.nvim",
		lazy = false,
		priority = 900,
		init = function()
			require("filetype").setup({
				overrides = {
					extensions = {
						sh = "bash",
					},
					literal = {
						["Dockerfile"] = "docker",
						["docker-compose"] = "docker",
						[".zshrc"] = "zsh",
					},
				}
			})
		end,
	},

	{
		"prichrd/netrw.nvim",
		lazy = false,
		priority = 998,
		opts = {},
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		enabled = true,
		priority = 990,
		config = function()
			require("colorschemes.tokyonight")
		end,
	},

	{
		"dstein64/vim-startuptime",
		lazy = false,
		priority = 1000,
	},

	"nvim-lua/plenary.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",

	{
		"folke/neodev.nvim",
		lazy = false,
		config = function()
			require("neodev").setup({
				library = {
					plugins = {
						"nvim-dap-ui",
					},
					types = true,
				},
			})
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		event = { "VeryLazy", "BufReadPost", "BufRead" },
		opts = {
			"css",
			"html",
			"javascript",
			"typescript",
			"tsx",
			"jsx",
			"kdl",
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 250
		end,
		opts = {},
	},

	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("trouble")
			local tr = package.loaded.trouble

			vim.keymap.set("n", "<Leader>lp", tr.toggle, { silent = true, desc = "[p]roblems" })
			vim.keymap.set("n", "]]", function()
				tr.trouble.next({ skip_groups = true, jump = true })
			end, { silent = true, desc = "[p]robem NEXT" })

			vim.keymap.set("n", "[[", function()
				tr.trouble.previous({ skip_groups = true, jump = true })
			end, { silent = true, desc = "[p]robem PREV" })
		end,
	},

	{
		"folke/todo-comments.nvim",
		event = { "VeryLazy", "BufEnter" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
		-- Couldn't get the actual proper main part working for now
		-- But is working for telescope call so
	},

	"ThePrimeagen/git-worktree.nvim",
	"nvim-telescope/telescope-fzy-native.nvim",
	"AckslD/nvim-neoclip.lua",
	"nvim-telescope/telescope-live-grep-args.nvim",

	{
		"RRethy/vim-illuminate",
		event = "BufWinEnter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
			})
		end,
	},

	{
		"mbbill/undotree",
		event = "VeryLazy",
	},
}
