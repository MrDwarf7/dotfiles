-- TODO: properly configure it (binds etc.)
return {
	"folke/trouble.nvim",
	enabled = true,
	lazy = false,
	keys = {
		-- stylua: ignore start
		{ "<leader>xd", "<CMD>Trouble diagnostics toggle<CR>",              desc = "Diagnostics (Trouble)" },
		{ "<leader>xD", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
		{ "<leader>xs", "<CMD>Trouble symbols toggle<CR>",                  desc = "Symbols (Trouble)" },
		{ "<leader>xS", "<CMD>Trouble lsp toggle<CR>",                      desc = "LSP references/definitions/... (Trouble)" },
		{ "<leader>xl", "<CMD>Trouble loclist toggle<CR>",                  desc = "Location List (Trouble)" },
		{ "<leader>xq", "<CMD>Trouble qflist toggle<CR>",                   desc = "Quickfix List (Trouble)" },
		-- { "<Leader>tt", "<CMD>Trouble<CR>",                              desc = "[t]rouble" },
		-- { "<Leader>f]", "<CMD>Trouble loclist toggle<CR>",               desc = "trouble - [j]ump" },
		-- { "<Leader>f[", "<CMD>Trouble qflist toggle<CR>",                desc = "trouble - qflist" },
		-- { "<Leader>lq", "<CMD>Trouble qflist toggle<CR>",                desc = "trouble - qflist" },
		-- stylua: ignore end
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

	-- opts = {},
}
