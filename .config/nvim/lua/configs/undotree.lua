local undotree = pcall(require, "undotree")
local map = vim.keymap.set
local g = vim.g

return {

	"mbbill/undotree",
	event = "VeryLazy",
	config = function()
		g.undotree_HighlightChangedWithSign = 1
		g.undotree_SetFocusWhenToggle = 1
		g.undotree_WindowLayout = 1
	end,

	map("n", "<Leader>u", ":UndotreeToggle<CR>", { desc = "[u]ndotree" }),
}
