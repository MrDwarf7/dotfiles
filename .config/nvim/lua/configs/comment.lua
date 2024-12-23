-- local ft = require("Comment.ft")
-- ft.set("jsonc", "//%s")

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
		ft = {
			jsonc = "//%s",
		},
	},

	config = function(_, opts)
		opts = opts or vim.tbl_extend("force", opts, {})

		return require("Comment").setup(opts)
		-- 	{
		-- 	pre_hook = function()
		-- 		return vim.bo.commentstring
		-- 	end,
		-- })
	end,
}
