return {

	{
		"tpope/vim-fugitive",
		event = "BufRead",
		keys = {
			{ "<Leader>gg", "<cmd>Git<CR>", mode = "n", { desc = "[g]it" } },
		},
	}, -- Automatic setup

	{
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = {
			"tpope/vim-fugitive",
		},
	},

	{ "nvim-neotest/nvim-nio", lazy = false },

	{
		"folke/tokyonight.nvim",
		lazy = false,
		enabled = true,
		priority = 999,
		init = function()
			require("colorschemes.tokyonight")
		end,
	},

	{
		"nvim-lua/plenary.nvim",
		-- lazy = true,
	},

	{
		"stevearc/oil.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		priority = 1000,
		keys = {
			{ "<C-w>'", "<cmd>lua =require('oil').open_float()<CR>", silent = true, desc = "oil" },
		},
		opts = {
			default_file_explorer = true,
			win_options = {
				wrap = false,
				signcolumn = "no",
				cursorcolumn = false,
				foldcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3, -- May want to change this to 0
				concealcursor = "nvic",
			},
			keymaps = {
				["g?"] = "actions.show_help",

				["<CR>"] = "actions.select",
				["<C-]>"] = "actions.select_vsplit",
				["<C-[>"] = "actions.select_split",

				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",

				["@"] = "actions.open_cwd",

				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
			view_options = {
				show_hidden = true,
			},
		},
	},

	{
		"folke/trouble.nvim",
		lazy = false,
		event = "BufReadPre",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Trouble",
		keys = {
			{ "<Leader>tt", "<cmd>Trouble<CR>", desc = "[t]rouble" },

			{ "<Leader>vj", "<cmd>Trouble loclist toggle<CR>", desc = "[j]umplist/loclist" },
			{ "<Leader>vz", "<cmd>Trouble qflist toggle<CR>", desc = "quickfix list" },

			{
				"]]",
				function()
					require("trouble").next({ skip_groups = true, jump = true })
				end,
				mode = "n",
				-- silent = true,
				desc = "[p]robem NEXT",
			},

			{
				"[[",
				function()
					require("trouble").previous({ skip_groups = true, jump = true })
				end,
				mode = "n",
				-- silent = true,
				desc = "[p]robem PREV",
			},
		},

		opts = {},
		-- local map = vim.keymap.set
		-- require("trouble").setup({})

		-- end,
	},

	{
		"nvim-telescope/telescope-fzy-native.nvim",
		build = "make",
		-- NOTE:
		-- cond = function()
		-- 	return vim.fn.executable("make") == 1
		-- end,
	},

	{ "nvim-telescope/telescope-dap.nvim", event = "VeryLazy" }, -- Automatic setup

	{ "AndreM222/copilot-lualine" },

	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			theme = "tokyonight",
			sections = {
				lualine_x = {
					{
						"copilot",
						symbols = {
							status = {
								icons = {
									enabled = " ",
									sleep = " ", -- auto-trigger disabled
									disabled = " ",
									warning = " ",
									unknown = " ",
								},
								hl = {
									enabled = "#50FA7B",
									sleep = "#AEB7D0",
									disabled = "#6272A4",
									warning = "#FFB86C",
									unknown = "#FF5555",
								},
							},
							-- spinners = require("copilot-lualine.spinners").dots,
							spinner_color = "#6272A4",
						},
						show_colors = true,
						show_loading = true,
					},
					"encoding",
					"fileformat",
					"filetype",
				},
			},
		},
	},

	{
		"NvChad/nvim-colorizer.lua",
		lazy = true,
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
		opts = {
			user_default_options = {
				tailwind = "both",
				css = true,
				css_fn = true,
				names = false,
			},
		},
	},

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
		-- lazy = true,
		-- event = "Buf",
		ft = { "go", "gomod" },
		event = { "CmdlineEnter" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
		dependencies = { -- optional packages
			{ "ray-x/guihua.lua" },
			{ "neovim/nvim-lspconfig" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("go").setup()
		end,
	},

	{
		"Civitasv/cmake-tools.nvim",
		ft = { "cmake", "cpp", "h", "hpp" },
		opts = {},
	},

	---- END LSP specific plugins

	{
		"j-hui/fidget.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {},
	},

	-- {
	-- 	"mfussenegger/nvim-dap",
	-- 	event = "VeryLazy",
	-- 	dependencies = {
	-- 		-- "rcarriga/nvim-dap-ui",
	-- 		"theHamsta/nvim-dap-virtual-text",
	-- 	},
	-- 	config = function()
	-- 		require("configs.dap_related.nvim_dap")
	-- 	end,
	-- },
	--
	-- {
	-- 	"rcarriga/nvim-dap-ui",
	-- 	event = "VeryLazy",
	-- 	dependencies = {
	-- 		"theHamsta/nvim-dap-virtual-text",
	-- 		"mfussenegger/nvim-dap",
	-- 	},
	-- 	config = function()
	-- 		require("configs.dap_related.nvim_dap_ui")
	-- 	end,
	-- },
	--
	-- {
	-- 	"jay-babu/mason-nvim-dap.nvim",
	-- 	event = "VeryLazy",
	-- 	dependencies = {
	-- 		"williamboman/mason.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("configs.dap_related.mason_dap")
	-- 	end,
	-- },

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
		tag = "stable",
		opts = {},
	},

	{
		"vrslev/cmp-pypi",
		ft = { "python" },
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = false },
		},
	},

	{
		"zbirenbaum/copilot-cmp",
		event = "InsertEnter",
		dependencies = {
			"zbirenbaum/copilot.lua",
			"hrsh7th/nvim-cmp",
		},
		opts = {
			suggestion = { enabled = true },
			panel = { enabled = false },
		},
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
}
