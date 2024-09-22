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

		opts = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_auto_execute_table_helpers = 1
			vim.g.db_ui_winwidth = 35

			return vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"sql",
					"mysql",
					"plsql",
					"mssql",
					"tsql",
				},
				callback = function(opts)
					-- vim.schedule(opts.db_completion)
					vim.schedule(function()
						return require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
					end)
				end,
			})
		end,

	------------------ testing

	-- {
	-- 	"kndndrj/nvim-dbee",
	-- 	lazy = false,
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- 	build = function()
	-- 		-- Install tries to automatically detect the install method.
	-- 		-- if it fails, try calling it with one of these parameters:
	-- 		--    "curl", "wget", "bitsadmin", "go"
	-- 		require("dbee").install("go")
	-- 	end,
	-- 	config = function()
	-- 		require("dbee").setup(--[[optional config]])
	-- 	end,
	-- },
}
