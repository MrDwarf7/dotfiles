return {
	'stevearc/conform.nvim',
	event = { 'BufWritePre', 'BufNewFile' },
	config = function()
		local conform = require('conform')

		conform.setup({
			formatters_by_ft = {
				javascript = { 'prettierd' },
				typescript = { 'prettierd' },
				typescriptreact = { 'prettierd' },
				javascriptreact = { 'prettierd' },
				--html = { 'prettierd' },
				css = { 'prettierd' },
				scss = { 'prettierd' },
				json = { 'prettierd' },
				yaml = { 'prettierd' },
				toml = { 'prettierd' },
				markdown = { 'prettierd' },
				lua = { 'stylua' },
				--[[ lua = { "lua-format", "stylua"}, ]]
				python = {
					'ruff_fix',
					{ 'ruff_format', 'black' },
					'isort',
				},
			},
			format_on_save = {
				lsp_fallback = false,
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
