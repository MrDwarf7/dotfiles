return {
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

	{ "nvim-neotest/nvim-nio", lazy = false },
	{ "folke/neoconf.nvim", lazy = false, cmd = "Neoconf", opts = {} },
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "LazyVim", words = { "LazyVim" } },
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
		init = function()
			require("colorschemes.tokyonight")
		end,
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
		init = function()
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
	{ "saecki/crates.nvim", ft = { "toml", "rust" }, tag = "stable", opts = {} },

	{
		"vrslev/cmp-pypi",
		ft = { "python" },
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = false },
		},
		"saecki/crates.nvim",
		lazy = false,
		ft = { "toml", "rust" },
		tag = "stable",
		opts = {},
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
