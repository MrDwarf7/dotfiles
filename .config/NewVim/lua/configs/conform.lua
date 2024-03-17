require("conform").setup({
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
	formatters_by_ft = {
		cpp = { "clang-format" },
		javascript = { "biome" },
		lua = { "stylua" },
		powershell = { "powershell_es" },
		python = { "ruff_format", { "isort", "black" } },
		sh = { "shfmt" },
		typescript = { "biome" },
		yaml = { "yamlfmt" },
	},
})
