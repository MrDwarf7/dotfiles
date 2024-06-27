-- local map = vim.keymap.set

return {

	"sindrets/diffview.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{ "<Leader>gdo", "<cmd>DiffviewOpen<CR>", mode = "n", desc = "[o]pen" },
		{ "<Leader>gdc", "<cmd>DiffviewClose<CR>", mode = "n", desc = "[c]lose" },
		{ "<Leader>gdf", "<cmd>DiffviewToggleFiles<CR>", mode = "n", desc = "[f]iles toggle" },
	},
}

-- require("diffview").setup({})
-- 	config = function()
-- 		require("configs.diffview")
-- 	end,
-- },
