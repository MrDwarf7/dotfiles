local map = vim.keymap.set

require("todo-comments").setup({
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
})

map("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

map("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

map("n", "<Leader>lt", ":TodoLocList<CR>", { desc = "list [t]odo's" })
