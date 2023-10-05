
local M = {
	"echasnovski/mini.nvim",
	dependencies = {
"nvim-treesitter/nvim-treesitter-textobjects",
	},
	version = false,
	event = { "BufReadPre", "BufNewFile" },
}

function M.config()
	local ai = require("mini.ai")

	ai.setup()



	local surround = require("mini.surround")
	surround.setup({
		mappings = {
			add = "sa",
			delete = "sd",
			find = "sf",
			find_left = "sF",
			highlight = "sh",
			replace = "sr",
			update_n_lines = "sn",
			change = "sc",
			},
	})


	local basics = require("mini.basics")
	basics.setup({
		autocommands = {
			relnum_in_visual_mode = false,
		},
		mappings = {
		option_toggle_prefix = [[<leader>u]],
			desc = "UI Toggle Options"
		},
		move_with_alt = {
			enable = false,
		},
	})

	local bufremove = require("mini.bufremove")
	bufremove.setup({})

--TODO: Further sus of the mini libs

end
return M
