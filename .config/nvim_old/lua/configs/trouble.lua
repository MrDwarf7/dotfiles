---@diagnostic disable: missing-fields, missing-parameter
return {
	"folke/trouble.nvim",
	lazy = false,
	event = "BufReadPre",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "Trouble" },
	keys = {
		{ "<leader>xd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
		{ "<leader>xD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
		{ "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
		{ "<leader>xS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		-- { "<Leader>tt", "<cmd>Trouble<CR>", desc = "[t]rouble" },
		-- { "<Leader>f]", "<cmd>Trouble loclist toggle<CR>", desc = "trouble - [j]ump" },
		-- { "<Leader>f[", "<cmd>Trouble qflist toggle<CR>", desc = "trouble - qflist" },
		-- { "<Leader>lq", "<cmd>Trouble qflist toggle<CR>", desc = "trouble - qflist" },
		{
			"]]",
			function()
				if require("trouble").is_open() then
					require("trouble").next({ skip_groups = true, jump = true })
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
					require("trouble").prev({ skip_groups = true, jump = true })
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
	opts = {
		modes = {
			lsp = {
				win = { position = "right" },
			},
		},
	},
}
