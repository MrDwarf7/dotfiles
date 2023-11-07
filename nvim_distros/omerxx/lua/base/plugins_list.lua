return {
	"tpope/vim-dadbod",
	"kristijanhusak/vim-dadbod-ui",
	"kristijanhusak/vim-dadbod-completion",
	-- Database
	{
		"tpope/vim-dadbod",
		opt = true,
		requires = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		config = function()
			require("config.dadbod").setup()
		end,
	},

	"ThePrimeagen/git-worktree.nvim",
	"tpope/vim-surround",
	"xiyaowong/nvim-transparent",

	{
		"akinsho/toggleterm.nvim",
	},

	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({
				width = 120, -- Width of the floating window
				height = 15, -- Height of the floating window
				border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
				default_mappings = true,
				debug = false, -- Print debug information
				opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
				resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
				post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
				references = { -- Configure the telescope UI for slowing the references cycling window.
					telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
				},
				-- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
				focus_on_open = true,                                    -- Focus the floating window when opening it.
				dismiss_on_move = false,                                 -- Dismiss the floating window when moving the cursor.
				force_close = true,                                      -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
				bufhidden = "wipe",                                      -- the bufhidden option to set on the floating window. See :h bufhidden
				stack_floating_preview_windows = true,                   -- Whether to nest floating windows
				preview_window_title = { enable = true, position = "left" }, -- Whether
			})
		end,
	},

	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},

	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
			})
		end,
	},

	{
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				-- add any options here
				-- routes = {
				--   {
				--     view = "notify",
				--     filter = { event = "msg_showmode" },
				--   },
				-- },
			})
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},

	"ray-x/go.nvim",
	"ray-x/guihua.lua",
	{ "catppuccin/nvim",      as = "catppuccin" },
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

	{
		"pmizio/typescript-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
	},

	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			"j-hui/fidget.nvim",
		},
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre", "BufNewFile" },
	},

	{
		"mfussenegger/nvim-lint",
	},

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	},

	{
		'zbirenbaum/copilot.lua',
		enabled = true,
		--lazy = false,
		cmd = 'Copilot',
		event = 'InsertEnter',
	},

	{
		'zbirenbaum/copilot-cmp',
		depencencies = {
			'zbirenbaum/copilot.lua',
		},
		lazy = false,
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},

	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	"theHamsta/nvim-dap-virtual-text",
	"leoluz/nvim-dap-go",

	-- Git related plugins
	"tpope/vim-fugitive",
	"lewis6991/gitsigns.nvim",

	"navarasu/onedark.nvim",    -- Theme inspired by Atom
	"nvim-lualine/lualine.nvim", -- Fancier statusline
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "UIEnter",
		enabled = true,
		opts = {
			exclude = {
				-- stylua: ignore
				filetypes = {
					'dbout', 'neo-tree-popup', 'log', 'gitcommit',
					'txt', 'help', 'NvimTree', 'git', 'flutterToolsOutline',
					'undotree', 'markdown', 'norg', 'org', 'orgagenda', "Diffview", "Neogit",
				},
			},
			indent = {
				char = "│", -- ▏┆ ┊ 
				tab_char = "│",
			},
			scope = {
				char = "▎",
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
				show_start = true,
			},
		},
		config = function(_, opts)
			require("ibl").setup(opts)
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
		end,
	},

	{
		"linux-cultist/venv-selector.nvim",
		event = "VeryLazy",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-telescope/telescope.nvim",
			"mfussenegger/nvim-dap-python",
		},
	},
	"numToStr/Comment.nvim", -- "gc" to comment visual regions/lines
	"tpope/vim-sleuth",     -- Detect tabstop and shiftwidth automatically
	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzy-native.nvim" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
	},
	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup()
		end,
	},

	"nvim-telescope/telescope-symbols.nvim",
	"ThePrimeagen/harpoon",

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	--	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
	{ "nvim-telescope/telescope-fzy-native.nvim" },
	{
		"folke/twilight.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
}
