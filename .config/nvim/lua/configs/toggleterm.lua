local architecture = require("util.architecture")
local types = require("types")

local M = {}
M.term = function()
	local get_os = architecture.get_os()
	local get_shell = architecture.get_shell(get_os)
	local arch_shell = architecture.shell_setup(get_shell)
	return arch_shell
end

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	lazy = false,
	-- init = function()
	-- 	M.term()
	-- end,
	opts = {
		open_mapping = {
			"<A-;>",
		},
		shell = M.term(),
		size = 20,
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = false,
		shading_factor = 0.1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
		start_in_insert = true,
		persist_size = true,
		direction = "horizontal",
		close_on_exit = true,
		float_opts = {
			border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
		},
	},
}

-- require("toggleterm").setup({
-- })
