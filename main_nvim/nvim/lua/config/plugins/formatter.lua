return {
	'stevearc/conform.nvim',
	event = { 'BufWritePre', 'BufNewFile' },
	config = function()
		local conform = require('conform')

		conform.setup({
			formatters_by_ft = {
				javascript = { 'prettier', { 'prettierd', 'tsserver' } },
				typescript = { 'prettier', { 'prettierd', 'tsserver' } },
				typescriptreact = { 'prettier', { 'prettierd', 'tsserver' } },
				javascriptreact = { 'prettier', { 'prettierd', 'tsserver' } },
				html = { 'prettier', 'prettierd' },
				css = { 'prettier', 'prettierd' },
				scss = { 'prettier', 'prettierd' },
				json = { 'prettier', 'prettierd' },
				yaml = { 'prettier', 'prettierd' },
				toml = { 'prettier', 'prettierd' },
				markdown = { 'prettier', 'prettierd' },
				lua = { 'stylua' },
				--[[ lua = { "lua-format", "stylua"}, ]]
				python = {
					--[[ 'ruff_fix', ]]
					{ 'ruff_lsp', 'ruff_format', 'black', 'isort' },
				},
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 3500, -- Default is 1000, disregarded if async = true
			},
			format_after_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 3500, -- Default is 1000, disregarded if async = true
			},
		})

		vim.keymap.set({ 'n', 'v' }, '<leader>lf', function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 2500, -- Default is 1000, disregarded if async = true
			})
		end, { desc = 'Format or format range if visual' })
	end,
}
