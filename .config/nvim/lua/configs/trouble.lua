return {
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
