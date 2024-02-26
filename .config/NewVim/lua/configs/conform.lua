local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "biome" },
		typescript = { "biome" },
		sh = { "shfmt" },
		yaml = { "yamlfmt" },
		powershell = { "powershell_es" },
		python = { "ruff_format", { "isort", "black" } },
		-- cpp = { "clang_format" },

		-- cpp = function(bufnr)
		--     bufnr = bufnr or vim.api.nvim_get_current_buf()
		--     if require("conform").get_formatter_info("clang_format", bufnr).available then
		--         return { "clang_format" }
		--     else
		--         require("conform.formatters.clang_format")
		--     end
		-- end,
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
