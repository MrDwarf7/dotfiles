return {
	"RRethy/vim-illuminate",
	event = "VeryLazy",
	-- lazy = false,
	config = function()
		return {
			configure = {
				providers = {
					"lsp",
					"regex",
					"treesitter",
				},
				delay = 100,
			},
		}
	end,
}
