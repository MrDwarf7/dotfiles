return {

	--#region Disabled
	{
		"folke/flash.nvim",
		enabled = false,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		keys = { { "<Leader>ug", false } },
		enabled = false,
	},

	{
		"MunifTanjim/nui.nvim",
		-- enabled = false,
	},

	{
		"rcarriga/nvim-notify",
		-- enabled = false,
		keys = function()
			return {
				{
					"<leader>nn",
					function()
						require("notify").dismiss({ silent = true, pending = true })
					end,
					desc = "dismiss [n]otice",
				},
			}
		end,
		opts = {
			stages = "static",
		},
	},

	--#endregion Disabled

	--#region Default_keymap_changes
	{
		"stevearc/conform.nvim",
		keys = { { "<Leader>cF", false } },
	},
	{
		"williamboman/mason.nvim",
		keys = { { "<Leader>cm", false } },
	},
	{
		"folke/trouble.nvim",
		keys = {
			{ "<Leader>cs", false },
			{ "<Leader>cS", false },
		},
	},

	{
		"echasnovski/mini.pairs",
		keys = {},
		enabled = false,
	},

	--#endregion Default_keymap_changes

	{
		"tpope/vim-fugitive",
		event = "BufRead",
		keys = {
			{ "<Leader>gg", "<cmd>Git<CR>", mode = "n", desc = "[g]it" },

			{ "<Leader>gf", "<cmd>Git fetch<CR>", mode = "n", desc = "fetch" },
			{ "<Leader>gF", "<cmd>Git fetch --all<CR>", mode = "n", desc = "fetch --all" },

			{ "<Leader>gp", "<cmd>Git pull<CR>", mode = "n", desc = "pull" },
			{ "<Leader>gP", "<cmd>Git push<CR>", mode = "n", desc = "push" },

			{ "<Leader>gl", "<cmd>Gclog<CR>", mode = "n", desc = "log [quickfix]" },
			{ "<Leader>gL", "<cmd>Gllog<CR>", mode = "n", desc = "log [location]" },

			{ "<Leader>gb", "<cmd>Git branch --all<CR>", mode = "n", desc = "branch" },
			{ "<Leader>gs", "<cmd>Git status<CR>", mode = "n", desc = "status" },

			{ "<Leader>gm", "<cmd>Git mergetool<CR>", mode = "n", desc = "mergetool" },
		},
	},

	{
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		keys = {

			{ "<Leader>gR", "<cmd>Flog<CR>", mode = "n", desc = "Flog [tab]" },
			{ "<Leader>gr", "<cmd>Flogsplit<CR>", mode = "n", desc = "Flog [split_list]" },
		},
		dependencies = {
			"tpope/vim-fugitive",
		},
	},

	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = function()
				require("colorschemes")
			end,
			defaults = {
				autocmds = false, -- lazyvim.config.autocmds
				keymaps = false, -- lazyvim.config.keymaps
				options = true, -- lazyvim.config.options
			},
		},
	},

	{
		"folke/noice.nvim",
		opts = {
			presets = {
				lsp_doc_border = true,
			},
		},
	},

	--#region
	{
		"stevearc/oil.nvim",
		lazy = false,
		-- dependencies = { "nvim-tree/nvim-web-devicons", lazy = false },
		priority = 1000,
		keys = {
			{ "<C-w><Leader>", "<cmd>lua =require('oil').open_float()<CR>", silent = true, desc = "oil" },
		},
		opts = {
			columns = {
				"icon", -- default
				-- "permissions",
				-- "size",
				-- "mtime",
			},
			default_file_explorer = true,
			skip_confirm_for_simple_edits = true, -- default: false
			win_options = {
				wrap = false,
				signcolumn = "yes:2",
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

	{ "AndreM222/copilot-lualine" },

	{

		"echasnovski/mini.surround",
		opts = {
			mappings = {
				add = "sa", -- Add surrounding in Normal and Visual modes
				delete = "sd", -- Delete surrounding
				find = "sf", -- Find surrounding (to the right)
				find_left = "sF", -- Find surrounding (to the left)
				highlight = "sh", -- Highlight surrounding
				replace = "sr", -- Replace surrounding
				update_n_lines = "sn", -- Update `n_lines`

				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},
		},
	},

	--#endregion
}
