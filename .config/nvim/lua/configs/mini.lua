return {
	"echasnovski/mini.nvim",
	event = "BufReadPost",
	config = function()
		require("mini.ai").setup({
			n_lines = 100,
		})
		require("mini.surround").setup()
	end,
}
