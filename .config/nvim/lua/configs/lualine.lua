---@diagnostic disable: unused-local

return {
	"nvim-lualine/lualine.nvim",
	event = "CursorMoved",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local my_theme = {
			-- evil_line = require("lualine_confs.evil_line").setup()
			-- bubbles = require("lualine_confs.bubbles").setup(),
			tokyonight = "tokyonight",
		}
		require("lualine").setup({
			theme = my_theme,
		})
	end,
}
