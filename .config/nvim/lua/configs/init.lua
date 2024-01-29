return {

	{
		"folke/tokyonight.nvim",
		lazy = false,
		enabled = true,
		priority = 1000,
		config = function()
			require("colorschemes.tokyonight")
		end,
	},

	{ "nvim-lua/plenary.nvim" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },

	{
		"folke/neodev.nvim",
		lazy = false,
		ft = { "lua" },
		opts = {},
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
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			vim.keymap.set("n", "<Leader>lp", function()
				require("trouble").toggle()
			end, { desc = "[p]roblems" })

			vim.keymap.set("n", "]]", function()
				require("trouble").next({ skip_groups = true, jump = true })
			end, { desc = "[p]robem NEXT" })

			vim.keymap.set("n", "[[", function()
				require("trouble").previous({ skip_groups = true, jump = true })
			end, { desc = "[p]robem PREV" })
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
		-- Couldn't get the actual proper main part working for now
		-- But is working for telescope call so
	},

	{ "ThePrimeagen/git-worktree.nvim" },
	{ "nvim-telescope/telescope-fzy-native.nvim" },
	{ "AckslD/nvim-neoclip.lua" },
	{ "nvim-telescope/telescope-live-grep-args.nvim" },

	{
		"mbbill/undotree",
		event = "InsertEnter",
		config = function()
			vim.keymap.set("n", "<Leader>U", vim.cmd.UndotreeToggle, { desc = "[U]ndo-tree" })
			vim.g.undotree_SetFocusWhenToggle = 1
		end,
		opts = {},
	},
}

-- Play around with either - Both comment tools do almost identical things so idk lol
--    {
--        "terrortylor/nvim-comment",
--        event = "BufEnter",
--        config = function()
--            require("nvim_comment").setup()
--        end
--    },
