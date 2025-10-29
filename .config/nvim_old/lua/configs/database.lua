-- Get the environment variables for each database and make them available
-- in the file to load into the plugin
local DB_BP_PRD = vim.fn.getenv("DB_BP_PRD")
local DB_BP_UAT = vim.fn.getenv("DB_BP_UAT")
local DB_BP_DEV = vim.fn.getenv("DB_BP_DEV")
local DB_MI_RPRT_EDA = vim.fn.getenv("DB_MI_RPRT_EDA")

local DB_MI_RPRT_CLUSTER = vim.fn.getenv("DB_MI_RPRT_CLUSTER")

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
			{
				"kristijanhusak/vim-dadbod-completion",
				ft = { "sql", "mysql", "plsql", "mssql" },
				lazy = true,
			}, -- Optional
		},
		keys = {

			-- TODO: create a func. that makes a tab --/ if a tab already exists with the DBUI open, then switch to it
			{
				"<Leader>so",
				"<cmd>DBUI<CR>",
				desc = "DB UI",
			},

			{
				"<Leader>sO",
				"<cmd>DBUI<CR>",
				desc = "DB UI",
			},

			{
				"<Leader>st",
				"<cmd>DBUIToggle<CR>",
				desc = "DB Toggle",
			},

			{
				"<Leader>sa",
				"<cmd>DBUIAddConnection<CR>",
				desc = "DB Add Con.",
			},

			{
				"<Leader>sf",
				"<cmd>DBUIFindBuffer<CR>",
				desc = "DB Find Buff.",
			},

			{
				"<Leader>sn",
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
			vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui_save_location"

			vim.api.nvim_create_autocmd("FileType", {
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
						return require("cmp").setup.buffer({
							sources = {
								{ name = "vim-dadbod-completion" },
								{ name = "copilot" },
								{ name = "buffer" },
								{ name = "nvm_lsp" },
							},
						})
					end)
				end,
			})
		end,

		-- Now we just hand them straight out/to the plugin

		config = function(_, opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"sql",
				},
				command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
			})

			vim.g.dbs = {

				{ name = "BP_PRD", url = DB_BP_PRD },
				{ name = "BP_UAT", url = DB_BP_UAT },
				{ name = "BP_DEV", url = DB_BP_DEV },
				{ name = "MI_RPRT_EDA", url = DB_MI_RPRT_EDA },

				{ name = "MI_RPRT_CLUSTER", url = DB_MI_RPRT_CLUSTER },
			}

			return opts
		end,
	},
}
