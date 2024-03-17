require("trouble").setup({})

vim.keymap.set("n", "]]", function()
	require("trouble").next({ skip_groups = true, jump = true })
end, { silent = true, desc = "[p]robem NEXT" })

vim.keymap.set("n", "[[", function()
	require("trouble").previous({ skip_groups = true, jump = true })
end, { silent = true, desc = "[p]robem PREV" })
