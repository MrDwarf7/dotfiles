-- TODO: properly configure it (binds etc.)

return {
	"folke/trouble.nvim",
	enabled = true,
	lazy = false,
	cmd = "Trouble",
	keys = {
		-- stylua: ignore start
		{ "<leader>xd", "<CMD>Trouble diagnostics toggle<CR>",              desc = "Diagnostics (Trouble)" },
		{ "<leader>xD", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
		{ "<leader>xs", "<CMD>Trouble symbols toggle<CR>",                  desc = "Symbols (Trouble)" },
		{ "<leader>xS", "<CMD>Trouble lsp toggle<CR>",                      desc = "LSP references/definitions/... (Trouble)" },
		{ "<leader>xl", "<CMD>Trouble loclist toggle<CR>",                  desc = "Location List (Trouble)" },
		{ "<leader>xq", "<CMD>Trouble qflist toggle<CR>",                   desc = "Quickfix List (Trouble)" },
		{ "<Leader>lt", "<CMD>Trouble todo<CR>",                            desc = "list [t]odo's",                           mode = "n" },

		-- { "<Leader>tt", "<CMD>Trouble<CR>",                              desc = "[t]rouble" },
		-- { "<Leader>f]", "<CMD>Trouble loclist toggle<CR>",               desc = "trouble - [j]ump" },
		-- { "<Leader>f[", "<CMD>Trouble qflist toggle<CR>",                desc = "trouble - qflist" },
		-- { "<Leader>lq", "<CMD>Trouble qflist toggle<CR>",                desc = "trouble - qflist" },
		-- stylua: ignore end

		{
			"<Leader>tl",
			function()
				-- need to check if the todo list is open or not

				-- filetype for it (from set ft?) is `trouble`
				-- We need to find it it's open at all
				local is_open = false
				for _, win in pairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
					if ft == "trouble" then
						is_open = true
						break
					end
				end
				if is_open then
					require("trouble").close()
				else
					local lm = require("trouble").last_mode
					require("trouble").open(lm or "workspace_diagnostics")
				end
			end,
			desc = "Toggle [t]rouble last",
		},

		{
			"]]",
			function()
				if require("trouble").is_open() then
					require("trouble").next({ skip_groups = false, jump = true })
				else
					local ok, err = pcall(vim.cmd.cnext)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
				-- return require("trouble").next({ skip_groups = true, jump = true })
			end,
			mode = "n",
			desc = "[p]robem NEXT",
		},

		{
			"[[",
			function()
				if require("trouble").is_open() then
					require("trouble").prev({ skip_groups = false, jump = true })
				else
					local ok, err = pcall(vim.cmd.cprev)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
				-- return require("trouble").previous({ skip_groups = true, jump = true })
			end,
			mode = "n",
			desc = "[p]robem PREV",
		},
	},
	opts = {},
}

-- return {
--   "folke/trouble.nvim",
--   opts = {}, -- for default options, refer to the configuration section for custom setup.
--   cmd = "Trouble",
--   keys = {
--     {
--       "<leader>xx",
--       "<cmd>Trouble diagnostics toggle<cr>",
--       desc = "Diagnostics (Trouble)",
--     },
--     {
--       "<leader>xX",
--       "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
--       desc = "Buffer Diagnostics (Trouble)",
--     },
--     {
--       "<leader>cs",
--       "<cmd>Trouble symbols toggle focus=false<cr>",
--       desc = "Symbols (Trouble)",
--     },
--     {
--       "<leader>cl",
--       "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
--       desc = "LSP Definitions / references / ... (Trouble)",
--     },
--     {
--       "<leader>xL",
--       "<cmd>Trouble loclist toggle<cr>",
--       desc = "Location List (Trouble)",
--     },
--     {
--       "<leader>xQ",
--       "<cmd>Trouble qflist toggle<cr>",
--       desc = "Quickfix List (Trouble)",
--     },
--   },
-- }
