local map = vim.keymap.set

return {

	"sindrets/diffview.nvim",
	event = { "VeryLazy" },
	opts = {},

	map("n", "<Leader>gdo", "<cmd>DiffviewOpen<CR>", { desc = "[o]pen" }),
	map("n", "<Leader>gdc", "<cmd>DiffviewClose<CR>", { desc = "[c]lose" }),
	map("n", "<Leader>gdf", "<cmd>DiffviewToggleFiles<CR>", { desc = "[f]iles toggle" }),
}

-- require("diffview").setup({})
-- 	config = function()
-- 		require("configs.diffview")
-- 	end,
-- },
