require("conform").setup({
	formatters_by_ft = {
		cpp = { "clang-format" },
		javascript = { "biome" },
		lua = { "stylua" },
		powershell = { "powershell_es" },
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
		yaml = { "yamlfmt" },
		rust = { "rustfmt" },
	},

	notify_on_error = false,
	format_on_save = function(bufnr)
		local disabled_ft = {
			c = true,
			cpp = true,
			netrw = true,
		}
		return {
			timeous_ms = 500,
			lsp_fallback = not disabled_ft[vim.bo[bufnr].filetype],
		}
	end,
})
