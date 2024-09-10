return {
	{
		"tpope/vim-dadbod",
		lazy = true,
	},
	-- sqlserver://<<SERVER>>/<<DATABASE>>?trusted_connection=yes
	-- trusted_connection=yes if using built in/winoows authentication
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql", "mssql" }, lazy = true }, -- Optional
		},
		keys = {

			-- TODO: create a func. that makes a tab --/ if a tab already exists with the DBUI open, then switch to it
			{
				"<Leader>do",
				"<cmd>DBUI<CR>",
				desc = "DB UI",
			},

			{
				"<Leader>dO",
				"<cmd>DBUI<CR>",
				desc = "DB UI",
			},

			{
				"<Leader>dt",
				"<cmd>DBUIToggle<CR>",
				desc = "DB Toggle",
			},

			{
				"<Leader>da",
				"<cmd>DBUIAddConnection<CR>",
				desc = "DB Add Con.",
			},

			{
				"<Leader>df",
				"<cmd>DBUIFindBuffer<CR>",
				desc = "DB Find Buff.",
			},

			{
				"<Leader>dn",
				"<cmd>DBUIHideNotifications<CR>",
				desc = "DB Find Buff.",
			},
		},

		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
			"DBUIHideNotifications",
			"DBUILastQueryInfo",
		},

		opts = {
			db_completion = function()
				require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
			end,
		},

		config = function(_, opts)
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_auto_execute_table_helpers = 1
			-- vim.g.db_ui_show_help = 0 -- Disable help block at top left
			vim.g.db_ui_winwidth = 35

			-- vim.g.db_ui_save_location = vim.fn.stdpath("cache") .. "/db_ui_save_location"

			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"sql",
				},
				command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"sql",
					"mysql",
					"plsql",
					"mssql",
					"tsql",
				},
				callback = function()
					vim.schedule(opts.db_completion)
				end,
			})
		end,
	},
}
