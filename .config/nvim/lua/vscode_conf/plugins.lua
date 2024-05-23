---@ class vscode_conf.plugins
local M = {}

---@overload fun(): table
---@return table
---@usage require("vscode_conf.plugins").vscode_plugins()
M.vscode_plugins = function()
	print("Vscode specific plugins file loads...")

	return {
		{
			"numToStr/Comment.nvim",
			lazy = false,
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
		},
	}
end

return M
