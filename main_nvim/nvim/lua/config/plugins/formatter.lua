return {
	'stevearc/conform.nvim',
	event = { 'BufWritePre', 'BufNewFile' },
	config = function()
		local conform = require('conform')

		conform.setup({
			formatters_by_ft = {
				javascript = { 'prettier', 'prettierd' },
				typescript = { 'prettier', 'prettierd' },
				typescriptreact = { 'prettier', 'prettierd' },
				javascriptreact = { 'prettier', 'prettierd' },
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
					'ruff_fix',
					{ 'ruff_format', 'black' },
					'isort',
				},
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 2000, -- Default is 1000, disregarded if async = true
			},
		})

		vim.keymap.set({ 'n', 'v' }, '<leader>lf', function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 2000, -- Default is 1000, disregarded if async = true
			})
		end, { desc = 'Format [n], format range [v]' })
	end,
}
