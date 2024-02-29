local todo = require("todo-comments")
local map = vim.keymap.set

todo.setup({
    keywords = {
        FIX = { icon = " ", color = "error" },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = ",", color = "warning" },
        WARN = { icon = " ", color = "warning" },
        PERF = { icon = " ", color = "warning" },
        NOTE = { icon = " ", color = "hint" },

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
