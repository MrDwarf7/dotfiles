local hooks = require("ibl.hooks")

require("ibl").setup({
	exclude = {
		filetypes = {
			"dbout",
			"Diffview",
			"flutterToolsOutline",
			"git",
			"gitcommit",
			"help",
			"log",
			"markdown",
			"Neogit",
			"neo-tree-popup",
			"norg",
			"NvimTree",
			"org",
			"orgagenda",
			"txt",
			"undotree",
		},
	},
	indent = {
		char = "│", -- ▏┆ ┊ 
		tab_char = "│",
	},
	scope = {
		char = "▎",
		highlight = {
			"RainbowDelimiterRed",
			"RainbowDelimiterYellow",
			"RainbowDelimiterBlue",
			"RainbowDelimiterOrange",
			"RainbowDelimiterGreen",
			"RainbowDelimiterViolet",
			"RainbowDelimiterCyan",
		},
		show_start = true,
	},
})

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
