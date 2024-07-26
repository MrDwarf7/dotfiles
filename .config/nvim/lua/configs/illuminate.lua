return {
	"RRethy/vim-illuminate",
	lazy = false,
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
