return {
	{
		"L3MON4D3/LuaSnip",
		"onsails/lspkind.nvim",
		"windwp/nvim-autopairs",
		"doxnit/cmp-luasnip-choice",
		"rafamadriz/friendly-snippets",
		"saecki/crates.nvim",
		"vrslev/cmp-pypi",
		-----------------
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",

		"zbirenbaum/copilot-cmp", -- new
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",

		"doxnit/cmp-luasnip-choice", -- new
		"saecki/crates.nvim",      -- new
		"vrslev/cmp-pypi",         -- new

		"hrsh7th/cmp-nvim-lsp-signature-help",
		"petertriho/cmp-git",
		"hrsh7th/cmp-cmdline",
	},

	{
		"L3MON4D3/LuaSnip",
		dependencies = "rafamadriz/friendly-snippets",
		opts = { history = true, updateevents = "TextChanged,TextChangedI" },
		config = function(_, opts)
			local cmp_util = require("configs.completion_sub.cmp_sub_config")
			cmp_util.luasnip_func(opts)
		end,
	},

	{
		"onsails/lspkind.nvim",
		event = { "InsertEnter" },
	},

	{
		"windwp/nvim-autopairs",
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	{
		"doxnit/cmp-luasnip-choice",
		config = function()
			require("cmp_luasnip_choice").setup({
				auto_open = true, -- Automatically open nvim-cmp on choice node (default: true)
			})
		end,
	},

	{
		"saecki/crates.nvim",
		ft = { "toml", "rust" },
		tag = "stable",
		config = function()
			require("crates").setup()
		end,
	},

	{
		"vrslev/cmp-pypi",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = { "toml", "python" },
	},

	{
		"zbirenbaum/copilot-cmp",
		lazy = false,
		dependencies = {
			"zbirenbaum/copilot.lua",
		},

		config = function()
			require("copilot_cmp").setup({
				suggestion = { enabled = true },
				panel = { enabled = false },
			})
		end,
	},
}
