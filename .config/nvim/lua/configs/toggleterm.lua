local architecture = require("util.architecture")
local types = require("types")

local term = architecture.shell_setup(architecture.get_shell(architecture.get_os()))

require("toggleterm").setup({
	open_mapping = {
		"<A-;>",
	},
	shell = term,
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
})
