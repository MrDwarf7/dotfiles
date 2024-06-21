local map = vim.keymap.set

return {

	"kevinhwang91/nvim-ufo",
	lazy = true,
	event = "VeryLazy",
	-- event = "BufReadPost",
	dependencies = {
		"kevinhwang91/promise-async",
	},

	opts = {
		provider_selector = function(bufnr, filetype, buftype)
			return { "treesitter", "indent" }
		end,
	},

	config = function(_, opts)
		require("ufo").setup(opts)
		map("n", "zR", require("ufo").openAllFolds)
		map("n", "zM", require("ufo").closeAllFolds)
	end,
}
