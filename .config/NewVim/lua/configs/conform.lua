local conform = require("conform")
local opts = {
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
		lua = { "stylua" },
		javascript = { "biome" },
		typescript = { "biome" },
		sh = { "shfmt" },
		yaml = { "yamlfmt" },
		powershell = { "powershell_es" },
		python = { "ruff_format", { "isort", "black" } },
	},
}

conform.setup(opts)

-- cpp = function(bufnr)
--     bufnr = bufnr or vim.api.nvim_get_current_buf()
--     if require("conform").get_formatter_info("clang_format", bufnr).available then
--         return { "clang_format" }
--     else
--         require("conform.formatters.clang_format")
--     end
-- end,
-- },

-- format_on_save = {
-- 	timeout_ms = 500,
-- 	lsp_fallback = opts,
-- },

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "",
-- 	callback = function(args)
-- 		require("conform").format({ bufnr = args.buf })
-- 	end,
-- }),
-- })
