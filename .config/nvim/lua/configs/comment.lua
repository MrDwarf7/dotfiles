return {
	"numToStr/Comment.nvim",
	event = "BufReadPost",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	-- config = function()
	opts = {
		pre_hook = function()
			return vim.bo.commentstring
		end,
	},
}

-- require("Comment").setup({
--
-- pre_hook = function()
-- 	return vim.bo.commentstring
-- end,
-- })
