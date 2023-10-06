--[[ local M = { ]]
local action = require('diffview.actions')
return {
	'sindrets/diffview.nvim',
	--[[ cmd = { ]]
	--[[     "DiffviewOpen", ]]
	--[[     "DiffviewFileHistory" ]]
	--[[ }, ]]

	require('diffview').setup({
		lazy = false,
		enabled = true,
		file_panel = {
			win_config = {
				position = 'left',
				width = 35,
				height = 10,
				use_icons = true,
				watch_index = true,
			},
		},
	}),
}
