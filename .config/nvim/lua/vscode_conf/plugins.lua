-----@ class vscode_conf.plugins
-- local M = {}

-----@overload fun(): table
-----@return table
-----@usage require("vscode_conf.plugins").vscode_plugins()
-- M.vscode_plugins = function()
-- 	return {}
-- end

print("Vscode specific plugins file loads...")

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
	end,
}
