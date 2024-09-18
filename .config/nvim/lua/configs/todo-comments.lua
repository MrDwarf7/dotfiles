return {
	"folke/todo-comments.nvim",
	event = "BufReadPost",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"]t",
			function()
				return require("todo-comments").jump_next()
			end,
			desc = "Next todo comment",
		},

		{
			"[t",
			function()
				return require("todo-comments").jump_prev()
			end,
			desc = "Previous todo comment",
		},

		{ "<Leader>lt", ":TodoLocList<CR>", desc = "list [t]odo's", mode = "n" },
	},
	opts = {
		keywords = {
			FIX = { icon = " ", color = "error" },
			HACK = { icon = ",", color = "warning" },
			NOTE = { icon = " ", color = "hint" },
			PERF = { icon = " ", color = "warning" },
			TODO = { icon = " ", color = "info" },
			WARN = { icon = " ", color = "warning" },
		},
		search = {
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
			},
			pattern = [[\b(KEYWORDS):]],
		},
	},
}
