return {
	"numToStr/Comment.nvim",
	event = "BufReadPost",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	opts = {
		pre_hook = function()
			return vim.bo.commentstring
		end,
	},

	config = function(_, opts)
		opts = opts or vim.tbl_extend("force", opts, {})

		require("Comment").setup(opts)
		-- 	{
		-- 	pre_hook = function()
		-- 		return vim.bo.commentstring
		-- 	end,
		-- })
	end,
}
