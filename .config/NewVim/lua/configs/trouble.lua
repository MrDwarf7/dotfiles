local trouble = require("trouble")

trouble.setup({})

vim.keymap.set("n", "<Leader>lp", trouble.toggle, { silent = true, desc = "[p]roblems" })
vim.keymap.set("n", "]]", function()
    trouble.next({ skip_groups = true, jump = true })
end, { silent = true, desc = "[p]robem NEXT" })

vim.keymap.set("n", "[[", function()
    trouble.previous({ skip_groups = true, jump = true })
end, { silent = true, desc = "[p]robem PREV" })
