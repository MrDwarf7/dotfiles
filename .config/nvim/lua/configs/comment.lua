return {
	"numToStr/Comment.nvim",
	event = "BufReadPost",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		require("Comment").setup({
			pre_hook = function()
				return vim.bo.commentstring
			end,
		})
	end,
}
