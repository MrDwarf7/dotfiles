return {
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

	{
		"williamboman/mason.nvim",
		config = function()
			require("configs.lsp_related.mason")
		end
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim"
		},
		config = function()
			require("configs.lsp_related.mason_lspconfig")
		end
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "BufEnter",
		dependencies = {
			"williamboman/mason.nvim"
		},
		config = function()
			require("configs.lsp_related.nvim_dap")
		end
	},

	{
		"neovim/nvim-lspconfig",
		event = "BufEnter",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			{ "j-hui/fidget.nvim",            opts = {} },
			{ "lvimuser/lsp-inlayhints.nvim", opts = {} },
		},
		config = function()
			require("configs.lsp_related.lspconfig")
		end
	},


	{
		"mrded/nvim-lsp-notify",
		dependencies = { "rcarriga/nvim-notify" },
		config = function()
			require("lsp-notify").setup({
				notify = require("notify"),
			})
		end,
	},


	{
		"lvimuser/lsp-inlayhints.nvim",
		config = function()
			require("configs.lsp_related.inlayhints")
		end,
	},

	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-lua/plenary.nvim",
			"lvimuser/lsp-inlayhints.nvim",
		},
		config = function()
			require("configs.lsp_related.rustaceanvim").rustaceanvim_setup()
		end
		-- config = function()
		-- 	print("THIS IS THE RUST IN THE INIT FILE")
		-- 	require("configs.lsp_related.rustaceanvim")
		-- end,
	},


	{
		"folke/zen-mode.nvim",
	},

	{
		"linux-cultist/venv-selector.nvim",
		lazy = false,
		event = "LspAttach",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-telescope/telescope.nvim",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local venv_select = require("venv-selector")
			venv_select.setup({
				name = { ".venv", ".venv/" },
				pdm_path = "pdm",
			})
			local opts = { silent = true, nowait = true }

			vim.api.nvim_create_autocmd("VimEnter", {
				desc = "Auto select virtualenv Nvim open",
				pattern = "*",
				callback = function()
					vim.keymap.set("n", "<Leader>fv", "<cmd>VenvSelect<CR>", opts)
					vim.keymap.set("n", "<Leader>fz", "<cmd>VenvSelectCached<CR>", opts)
					local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ".venv")
					if venv ~= "" then
						require("venv-selector").retrieve_from_cache()
					end
				end,
				once = true,
			})
		end,
	},

	{
		"ggandor/leap.nvim",
		lazy = false,
		config = function()
			require("leap").setup({})
		end,
	},

	{
		"tpope/vim-surround",
		lazy = false,
	},



}
