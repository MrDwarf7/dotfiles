require("illuminate").configure({
	providers = {
		"lsp",
		"regex",
		"treesitter",
	},
	delay = 100, -- Default value
})
