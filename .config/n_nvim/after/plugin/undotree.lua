vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_HighlightChangedWithSign = 1
vim.g.undotree_WindowLayout = 1

vim.keymap.set("n", "U", ":UndotreeToggle<CR>", { silent = true, desc = "[U]ndo-tree" })
