return {
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufWritePre",
			"BufReadPre",
		},

		config = function()
			local lint = require("lint")
			lint.linter_by_ft = {
				css = { "stylelint" },
				yaml = { "yamllint" },
				docker = { "hadolint" },
				python = { "ruff", "vulture" },
				vim = { "vint" },
				sh = { "shellcheck" },
				lua = { "luacheck" },
				javascript = { "biomejs" },
				typescript = { "biomejs" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		event = {
			"BufEnter",
			"BufReadPre",
			"BufWritePre",
		},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },

					python = function(bufnr)
						if require("conform").get_formatter_info("ruff_format", bufnr).available then
							return { "ruff_format" }
						else
							return { "isort", "black" }
						end
					end,

					javascript = { "biomejs" },
					typescript = { "biomejs" },
					sh = { "shfmt" },
					yaml = { "yamllint" },
					powershell = { "powershell_es" },
				},

				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},

				vim.api.nvim_create_autocmd("BufWritePre", {
					pattern = "*",
					callback = function(args)
						require("conform").format({ bufnr = args.buf })
					end,
				}),
			})
		end,
	},
}
