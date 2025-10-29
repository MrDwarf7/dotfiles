return {
	"stevearc/dressing.nvim",
	event = "BufReadPost",
	opts = {
		input = {
			insert_only = false,
			border = "rounded",
		},
		mappings = {
			n = {
				["q"] = "Close",
			},
		},
	},
}
