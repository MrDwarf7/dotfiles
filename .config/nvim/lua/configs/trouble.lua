return {
	"folke/trouble.nvim",
	lazy = false,
	event = "BufReadPre",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble",
	keys = {
		{ "<Leader>tt", "<cmd>Trouble<CR>", desc = "[t]rouble" },
		{ "<Leader>f]", "<cmd>Trouble loclist toggle<CR>", desc = "trouble - [j]ump" },
		{ "<Leader>f[", "<cmd>Trouble qflist toggle<CR>", desc = "trouble - qflist" },
		{ "<Leader>lq", "<cmd>Trouble qflist toggle<CR>", desc = "trouble - qflist" },
		{
			"]]",
			function()
				require("trouble").next(_, { skip_groups = true, jump = true })
			end,
			mode = "n",
			desc = "[p]robem NEXT",
		},

		{
			"[[",
			function()
				require("trouble").previous({ skip_groups = true, jump = true })
			end,
			mode = "n",
			desc = "[p]robem PREV",
		},
	},
	opts = {},
}
