return {
	"RRethy/vim-illuminate",
	lzy = false,
	opts = function()
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
