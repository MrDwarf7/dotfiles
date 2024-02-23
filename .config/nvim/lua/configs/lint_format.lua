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
				cpp = { "cpplint", "clang-tidy" },
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
					end,

					-- go = function()
					-- 	require("conform").formatter.go = {
					-- 		inherit = false,
					-- 	}
					-- end,

					-- require("go.format").gofmt() -- gofmt only
					-- require("go.format").goimport() -- goimport + gofmt
					-- Run gofmt on save
					-- 	local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
					-- 	vim.api.nvim_create_autocmd("BufWritePre", {
					-- 		pattern = "*.go",
					-- 		callback = function()
					-- 			require("go.format").gofmt()
					-- 		end,
					-- 		group = format_sync_grp,
					-- 	})
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
