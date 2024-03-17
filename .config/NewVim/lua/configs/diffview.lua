local map = vim.keymap.set

require("diffview").setup({})
map("n", "<Leader>gdo", "<cmd>DiffviewOpen<CR>", { desc = "[o]pen" })
map("n", "<Leader>gdc", "<cmd>DiffviewClose<CR>", { desc = "[c]lose" })
map("n", "<Leader>gdf", "<cmd>DiffviewToggleFiles<CR>", { desc = "[f]iles toggle" })
