return {
	"RRethy/vim-illuminate",
	lazy = true,
	-- event = "VeryLazy",
	-- dependencies = {
	-- 	"nvim-treesitter/nvim-treesitter",
	-- },

	config = function()
		require("illuminate").configure({
			providers = {
				"lsp",
				"regex",
				"treesitter",
			},
			delay = 100, -- Default value
		})
	end,
}
