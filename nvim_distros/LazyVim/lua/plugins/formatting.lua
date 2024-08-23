return {
	"stevearc/conform.nvim",

	opts = function(_, opts)
		opts.default_format_opts = {
			notify_on_error = false,
		}
		opts.disabled_ft = {
			"c",
			"cpp",
			"netrw",
			"oil",
			"Oil",
			"treesitter",
			"zig",
		}

		opts.formatters_by_ft = {
			cpp = { "clang-format" },
			-- cs = { "omnisharp" },
			cs = { "csharpier" },
			gleam = { "gleam" },
			vb = { "csharpier" },
			javascript = { "biome" },
			javascriptreact = { "biome" },
			json = { "biome" },
			lua = { "stylua" },
			powershell = function(formatter, bufnr)
				bufnr = bufnr or vim.api.nvim_get_current_buf()
				if require("conform").get_formatter_info(formatter, bufnr).available then
					return { formatter }
				else
					return { vim.lsp.buf.format({ async = true }) }
				end
			end,

			python = function(bufnr)
				if require("conform").get_formatter_info("ruff_format", bufnr).available then
					return { "ruff_format" }
				else
					return { "isort", "black" }
				end
			end,
			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "beautysh" },
			typescript = { "biome" },
			typescriptreact = { "biome" },
			yaml = { "yamlfmt" },
			rust = { "rustfmt" },
		}
	end,
}
