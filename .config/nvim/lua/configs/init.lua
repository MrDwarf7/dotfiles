return {
	{
		"tpope/vim-fugitive",
		event = "BufRead",
		keys = {
			{ "<Leader>gg", "<cmd>Git<CR>", mode = "n", desc = "[g]it" },

			{ "<Leader>gf", "<cmd>Git fetch<CR>", mode = "n", desc = "fetch" },
			{ "<Leader>gF", "<cmd>Git fetch --all<CR>", mode = "n", desc = "fetch --all" },

			{ "<Leader>gp", "<cmd>Git pull<CR>", mode = "n", desc = "pull" },
			{
				"<Leader>gP",
				function()
					vim.schedule(function()
						vim.cmd([[ Git push ]])
					end)
				end,
				mode = "n",
				desc = "push",
			},
			-- "<cmd>Git push<CR>", mode = "n", desc = "push" },

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

	{ "nvim-neotest/nvim-nio", lazy = false },
	{ "folke/neoconf.nvim", lazy = false, cmd = "Neoconf", opts = {} },
	{
		"folke/lazydev.nvim",
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

	{
		"folke/tokyonight.nvim",
		lazy = false,
		enabled = true,
		priority = 999,
		opts = function()
			return {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				transparent = false, -- Enable this to disable setting the background color
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
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
				---@param colors ColorScheme
				on_colors = function(colors) end,

				--- You can override specific highlights to use other groups or a hex color
				--- function will be called with a Highlights and ColorScheme table
				---@param highlights Highlights
				---@param colors ColorScheme
				on_highlights = function(highlights, colors) end,
			}
		end,
		config = function(_, opts)
			vim.cmd.colorscheme("tokyonight-storm")
			return opts
		end,
	},

	-- init = function()
	-- 	require("colorschemes.tokyonight")
	-- end,

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
	{ "j-hui/fidget.nvim", opts = {} },

	-- { "j-hui/fidget.nvim", lazy = true, event = "VeryLazy", opts = {} },
	-- { "saecki/crates.nvim", ft = { "toml", "rust" }, tag = "stable", opts = {} },
	-- { "saecki/crates.nvim", ft = { "toml", "rust" }, tag = "stable", opts = true },

	{ "vrslev/cmp-pypi", ft = { "python" }, dependencies = { { "nvim-lua/plenary.nvim", lazy = false } } },

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
