local df = require("diffview")
local map = vim.keymap.set

df.setup({})

-- map("n", "<Leader>gd", "+[d]iffview", { desc = "[d]iffview" })

map("n", "<Leader>gdo", "<cmd>DiffviewOpen<CR>", { desc = "[o]pen" })
map("n", "<Leader>gdc", "<cmd>DiffviewClose<CR>", { desc = "[c]lose" })
map("n", "<Leader>gdf", "<cmd>DiffviewToggleFiles<CR>", { desc = "[f]iles toggle" })
