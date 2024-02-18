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
				python = { "ruff", "mypy", "vulture" },
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
						bufnr = bufnr or 0
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
					cpp = function(bufnr)
						bufnr = bufnr or vim.api.nvim_get_current_buf()
						if require("conform").get_formatter_info("clang_format", bufnr).available then
							return { "clang_format" }
						else
							require("conform.formatters.clang_format")
						end
					end
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
