return {
	'echasnovski/mini.nvim',
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
	},
	config = function()
		local surround = require('mini.surround')
		surround.setup({
			mappings = {
				add = 'sa',
				delete = 'td',
				find = 'sf',
				find_left = 'tF',
				highlight = 'th',
				replace = 'sr',
				update_n_lines = 'sn',
				change = 'sc',
			},
		})


		local basics = require('mini.basics')
		basics.setup({
			autocommands = {
				relnum_in_visual_mode = false,
			},
			move_with_alt = {
				enable = true,
			},
		})
		-- mappings = {
		-- 	option_toggle_prefix = [[<leader>u]],
		-- 	desc = 'UI Toggle Options',
		-- },

		local bufremove = require('mini.bufremove')
		bufremove.setup({})
	end
}
