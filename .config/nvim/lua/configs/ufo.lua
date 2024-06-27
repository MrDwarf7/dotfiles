return {
	"kevinhwang91/nvim-ufo",
	lazy = true,
	event = "VeryLazy",
	-- event = "BufReadPost",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	keys = {
		{
			"zR",
			function()
				require("ufo").openAllFolds()
			end,
		},
		{
			"zM",
			function()
				require("ufo").closeAllFolds()
			end,
		},
	},
	opts = {
		provider_selector = function(bufnr, filetype, buftype)
			return { "treesitter", "indent" }
		end,
	},
	-- config = function(_, opts)
	-- 	require("ufo").setup(opts)
	-- end,
}
