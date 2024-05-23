local undotree = pcall(require, "undotree")
local map = vim.keymap.set
local g = vim.g

g.undotree_HighlightChangedWithSign = 1
g.undotree_SetFocusWhenToggle = 1
g.undotree_WindowLayout = 1

map("n", "<Leader>u", ":UndotreeToggle<CR>", { desc = "[u]ndotree" })
