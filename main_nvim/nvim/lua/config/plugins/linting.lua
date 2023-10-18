local autocmd = vim.api.nvim_create_autocmd
return {
	'mfussenegger/nvim-lint',
	event = {
		'BufWritePre',
		'BufReadPre',
	},
	config = function()
		local lint = require('lint')

		lint.linter_by_ft = {
			css = { 'stylelint' },
			yaml = { 'yamllint' },
			docker = { 'hadolint' },
			python = { 'ruff', 'vulture' },
			vim = { 'vint' },
			sh = { 'shellcheck' },
			lua = { 'selene' },
			javascript = { 'eslint_d' },
			typescript = { 'eslint_d' },
		}

		local lint_augroup = vim.api.nvim_create_augroup('lint', {
			clear = true,
		})

		vim.api.nvim_command('augroup ' .. lint_augroup)

		autocmd({
			'BufEnter',
			'BufWritePre',
			'InsertLeave',
			--[[ 'TextChanged', ]]
		}, {
			--[[ pattern = '*', ]]
			-- Other option would be listing specifics filetypes
			pattern = { "*.lua", "*.js", "*.ts", "*.tsx", "*.jsx", "*.sh", "*.css", "*.yaml", "*.yml", "*.docker", "*.py", "*.vim"},
			group = lint_augroup,
			callback = function()
				lint.try_lint()
				--[[ lint.lint() ]]
			end,
		})

		vim.keymap.set('n', '<leader>ll', function()
			lint.try_lint()
		end, { noremap = true, silent = true, buffer = true, desc = 'Lint' })
	end,
}

