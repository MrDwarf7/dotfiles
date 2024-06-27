-- local undotree = pcall(require, "undotree")
-- local map = vim.keymap.set
-- local g = vim.g

return {
	"mbbill/undotree",
	event = "VeryLazy",
	keys = {

		{ "<Leader>u", ":UndotreeToggle<CR>", desc = "[u]ndotree" },
	},
	init = function()
		vim.g.undotree_HighlightChangedWithSign = 1
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.g.undotree_WindowLayout = 1
	end,
}
