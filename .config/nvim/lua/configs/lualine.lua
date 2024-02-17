---@diagnostic disable: unused-local

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,

	--event = "CursorMoved",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local my_theme = "tokyonight"
		-- {
		-- evil_line = require("lualine_confs.evil_line").setup()
		-- bubbles = require("lualine_confs.bubbles").setup(),
		-- tokyonight = "tokyonight",
		-- }
		require("lualine").setup({
			theme = my_theme,
		})
	end,
}
