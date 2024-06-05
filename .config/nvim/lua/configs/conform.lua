---@usage get_available_formatters("powershell_es", bufnr)
---@param formatter string
---@param buf number | nil
---@return string[] | function | table | nil
local get_available_formatters = function(formatter, buf)
	local bufnr = buf or vim.api.nvim_get_current_buf()
	if require("conform").get_formatter_info(formatter, bufnr).available then
		return { formatter }
	else
		return { vim.lsp.buf.format({ async = true }) }
	end
end

return {

	"stevearc/conform.nvim",
	lazy = true,
	event = "BufWritePost",

	opts = {
		formatters_by_ft = {
			cpp = { "clang-format" },
			-- cs = { "omnisharp" },
			cs = { "csharpier" },
			gleam = { "gleam" },
			vb = { "csharpier" },
			javascript = { "biome" },
			javascriptreact = { "biome" },
			json = { "fixjson", { "biome" } },
			lua = { "stylua" },
			powershell = function(formatter, bufnr)
				-- local formatter = "powershell_es"
				get_available_formatters(formatter, bufnr)
			end,

			-- get_available_formatters("powershell_es"),
			-- end,
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
		},

		notify_on_error = false,
		format_on_save = function(bufnr)
			local disabled_ft = {
				c = true,
				cpp = true,
				netrw = true,
			}
			return {
				timeous_ms = 1000,
				lsp_fallback = not disabled_ft[vim.bo[bufnr].filetype],
			}
		end,
	},
}
