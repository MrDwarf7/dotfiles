return {
	{
		"tpope/vim-dadbod",
		event = "VeryLazy",
		lazy = false,
	},

	{
		'kristijanhusak/vim-dadbod-ui',
		event = "VeryLazy",
		dependencies = {
			{ 'tpope/vim-dadbod',                     lazy = false },
			{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
		},
		cmd = {
			'DBUI',
			'DBUIToggle',
			'DBUIAddConnection',
			'DBUIFindBuffer',
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},


}
