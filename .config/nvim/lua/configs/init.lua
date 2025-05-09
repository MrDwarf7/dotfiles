-----@alias snacks.Config table<string, any>

_G.dd = function(...)
	Snacks.debug.inspect(...)
end
_G.bt = function()
	Snacks.debug.backtrace()
end
vim.print = _G.dd

return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			animate = { enabled = true },
			bigfile = { enabled = true },
			bufdelete = {
				enabled = true,
				notify = true,
				size = 1.5 * 1024 * 1024, -- 1.5 MB
			},
			-- dashboard = require("util.snack_dashboard"),
			debug = { enabled = true },
			dim = { enabled = true, animate = { enabled = false } },
			-- git = { enable = true },
			-- gitbrowse = { enable = true },
			indent = {
				enabled = true,

				animate = {
					duration = {
						step = 15,
					},
				},
				-- scope = {
				-- 	char = "▎",
				-- },
				chunk = {
					enabled = true,
					only_current = true,
					char = {
						corner_top = "┌",
						corner_bottom = "└",
						-- corner_top = "╭",
						-- corner_bottom = "╰",
						horizontal = "─",
						vertical = "│",
						arrow = ">",
					},
				},
				blank = {
					char = ">>>",
				},
			},

			-- animate = {
			-- 	enabled = false,
			-- }
			input = { enabled = true },
			lazygit = { enabled = true, configure = true },
			-- notifier = { enabled = true },
			-- notify = { enabled = true },
			-- profiler = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			-- scroll = { enabled = true, animate = { duration = { step = 5, total = 100 } } },
			statuscolumn = { enabled = true },
			-- toggle = {
			-- 	enabled = true,
			-- 	map = vim.keymap.set,
			-- 	which_key = true,
			-- },
			-- words = { enabled = true },
		},
		keys = {
			-- stylua: ignore start
			{ "<Leader>td", function() local dim = require("snacks").dim if dim.enabled ~= nil and dim.enabled == true then dim.disable() else dim.enable() end end },
			{ "<Leader>go", function() local lg = require("snacks").lazygit Snacks.lazygit() end },
			{ "<Leader>t.", function() Snacks.scratch() end, desc = "Toggle Scratch" },
			{ "<Leader>.", function() Snacks.scratch.select() end, desc = "Select Scratch" },
			{ "<Leader>`", function () Snacks.terminal() end, desc = "Open Terminal" },
			{ "<Leader>tn", function ()
				if Snacks.config.picker and Snacks.config.picker.enabled then
					Snacks.picker.notifications()
				else
					Snacks.notifier.show_history()
				end
			end, desc = "Notifications History"},
			-- { "<Leader>pq", function() local prof = require("snacks").profiler Snacks.toggle.profiler():map("<Leader>pq") end },
			-- { "<Leader>pw", function() Snacks.profiler.scratch() end, desc = "Profiler Window" },
			-- stylua: ignore end
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Debugging functions -- can use dd(thing) or bt() for debug print & backtrace
					-- end debugging

					-- end callback
				end,
			})

			-- vim.api.nvim_create_autocmd("LspProgress", {
			-- 	---@param ev { data: {client_id: integer, params: lsp.ProgressParams }}
			-- 	callback = function(ev)
			-- 		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
			-- 		vim.notify(vim.lsp.status(), "info", {
			-- 			id = "lsp_progress",
			-- 			title = "LSP Progress",
			-- 			opts = function(notif)
			-- 				notif.icon = ev.data.params.value.kind == "end" and " "
			-- 					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			-- 			end,
			-- 		})
			-- 	end,
			-- })
		end,
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		enabled = true,
		priority = 999,
		opts = function()
			local opts = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				-- style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				transparent = false, -- Enable this to disable setting the background color
				terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "dark", -- style for sidebars, see below
					floats = "transparent", -- style for floating windows
				},
				sidebars = { "qf", "help", "nvimtree" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
				day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
				hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
				dim_inactive = false, -- dims inactive windows
				lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

				--- You can override specific color groups to use other groups or a hex color
				--- function will be called with a ColorScheme table
				----@param colors ColorScheme
				-- on_colors = function(colors) end,

				--- You can override specific highlights to use other groups or a hex color
				--- function will be called with a Highlights and ColorScheme table
				----@param highlights Highlights
				----@param colors ColorScheme
				-- on_highlights = function(highlights, colors) end,
			}
			vim.cmd.colorscheme("tokyonight-" .. opts.style)
			return opts
		end,
		-- config = function(_, opts)
		-- 	vim.cmd.colorscheme("tokyonight-" .. opts.style)
		-- 	-- require("tokyonight").setup(opts)
		-- 	return opts
		-- end,
	},

	{
		"williamboman/mason.nvim",
		lazy = false,
		event = "UIEnter",
		keys = {
			{
				"<Leader>pm",
				"<cmd>Mason<CR>",
				mode = "n",
				desc = "Mason",
			},
		},

		-- init = function()
		opts = {
			pip = {
				upgrade_pip = true,
			},

			ui = {
				border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
				icons = {
					package_pending = " ",
					package_installed = "󰄳 ",
					package_uninstalled = " 󰚌",
				},
			},
		},
	},

	{
		"tpope/vim-fugitive",
		enabled = false,
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
		enabled = false,
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

	{ "nvim-neotest/nvim-nio", lazy = false },
	{ "folke/neoconf.nvim", lazy = false, cmd = "Neoconf", opts = {} },
	{
		"folke/lazydev.nvim",
		lazy = false,
		ft = "lua",
		opts = {
			library = {
				{ path = "LazyVim", words = { "LazyVim" } },
				{ path = "wezterm-types", words = { "wezterm" } },
				-- { path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		"wsdjeg/vim-fetch",
		lazy = false,
	},

	-- Black and white color scheme, simple & elegant
	-- {
	--    "zenbones-theme/zenbones.nvim",
	--    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
	--    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
	--    -- In Vim, compat mode is turned on as Lush only works in Neovim.
	--    dependencies = "rktjmp/lush.nvim",
	--    lazy = false,
	--    priority = 1000,
	--    opts = {},
	-- },

	{ "nvim-lua/plenary.nvim" },
	{ "romgrk/fzy-lua-native", build = "make" },

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
		"Civitasv/cmake-tools.nvim",
		ft = { "cmake", "cpp", "h", "hpp" },
		-- previously init = function()
		config = function(_)
			local loaded = false
			local function check()
				local cwd = vim.uv.cwd()
				if vim.fn.filereadable(cwd .. "/CmakeLists.txt") == 1 then
					require("lazy").load({ plugins = "cmake-tools.nvim" })
					loaded = true
				end
			end
			check()
			vim.api.nvim_create_autocmd("DirChanged", {
				callback = function()
					if not loaded then
						check()
					end
				end,
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		lazy = true,
		opts = {},
	},

	-- { "j-hui/fidget.nvim", lazy = true, event = "VeryLazy", opts = {} },
	-- { "saecki/crates.nvim", ft = { "toml", "rust" }, tag = "stable", opts = {} },
	-- { "saecki/crates.nvim", ft = { "toml", "rust" }, tag = "stable", opts = true },

	{
		"vrslev/cmp-pypi",
		ft = { "python" },
		dependencies = { { "nvim-lua/plenary.nvim", lazy = false } },
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
		"Airbus5717/c3.vim",
		ft = { "c3", "c3c" },
	},

	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },

	{ "RRethy/vim-illuminate", lazy = true },
	{ "tridactyl/vim-tridactyl", ft = "tridactyl" },
}

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
