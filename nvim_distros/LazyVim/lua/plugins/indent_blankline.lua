return {
	"lukas-reineke/indent-blankline.nvim",
	-- init = function() end,
	keys = {},

	opts = function(highlight)
		return {
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
					"fugitive",
					"flog",
					"flog-*",
					"Neogit",
					"neo-tree-popup",
					"norg",
					"NvimTree",
					"oil",
					"Oil",
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
				show_start = true,
				highlight = highlight,
			},
		}
	end,

	config = function()
		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}

		vim.g.rainbow_delimiters = { highlight = highlight }
		local hooks = require("ibl.hooks")

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
		end)

		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
	end,
}
