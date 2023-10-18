--TODO: lsp configs for other langs
local M = {
	'neovim/nvim-lspconfig',
	lazy = false,
	dependencies = {
		{ 'williamboman/mason.nvim' },
		{ 'williamboman/mason-lspconfig.nvim' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'SmiteshP/nvim-navic' },
	},
}

function M.on_attach(client, bufnr)
	local navic = require('nvim-navic')
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set(
		'n',
		'<leader>la',
		vim.lsp.buf.code_action,
		{ noremap = true, silent = true, buffer = bufnr, desc = 'LSP Code Action' }
	)
	--[[ vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts) ]]
	--[[ vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts) ]]
	--[[ vim.keymap.set('n', '<leader>wl', function() ]]
	--[[   print(vim.inspect(vim.lsp.buf.list_workspace_folders())) ]]
	--[[ end, bufopts) ]]
	--[[ vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts) ]]
	--[[ vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts) ]]
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<leader>lf', function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

function M.config()
	local lspconfig = require('lspconfig')
	local mason_lspconfig = require('mason-lspconfig')
	local mason_tool_installer = require('mason-tool-installer')

	local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
	vim.diagnostic.config({
		virtual_text = false,
	})

	-- Diagnostics symbols for display in the sign column.
	local signs = { Error = '', Warn = '', Hint = '', Info = '' }
	for type, icon in pairs(signs) do
		local hl = 'DiagnosticSign' .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	require('mason').setup({
		ui = {
			border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
			icons = {
				package_installed = '✓',
				package_pending = '➜',
				package_uninstalled = '✗',
			},
		},
	})
	mason_lspconfig.setup({
		ensure_installed = {
			'lua_ls',
			'ruff_lsp',
			'bashls',
			'rust_analyzer',
			-- 'html',
			'tsserver',
			'cssls',
			'dockerls',
			'vimls',
			'powershell_es',
			--[[ 'yamlls', ]]
			--[[ 'debugpy', ]]
			--[[ 'pyright', ]]
		},
	})
	mason_lspconfig.setup_handlers({
		-- The first entry (without a key) will be the default handler
		-- and will be called for each installed server that doesn't have
		-- a dedicated handler.
		function(server_name) -- default handler (optional)
			lspconfig[server_name].setup({
				on_attach = M.on_attach,
				capabilities,
			})
		end,

		['lua_ls'] = function()
			lspconfig.lua_ls.setup({
				on_attach = M.on_attach,
				capabilities,
				filetypes = { 'lua' },
			})
		end,
		--TODO: lsp attach issue?
		-- 	['html'] = function()
		-- 		lspconfig.html.setup({
		-- 			on_attach = M.on_attach,
		-- 			capabilities,
		-- 			filetypes = { 'html' },
		-- 		})
		-- 	end,
	})

	--[[ function M.setup() ]]
	--[[ 		require("dap-python").setup({ ]]
	--[[ 		args = { "-m", "debugpy.adapter" } ]]
	--[[ 		}) ]]
	--[[ 		require("dapui").setup() ]]
	--[[ 	end ]]

	require('ufo').setup()

	M = {
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		lazy = false,
	}

	mason_tool_installer.setup({
		ensure_installed = {
			'prettier',
			'prettierd',
			'black',
			'isort',
			'stylelint',
			'yamllint',
			'hadolint',
			'ruff',
			'vulture',
			'vint',
			'shellcheck',
			'selene',
			'eslint_d',
			'taplo',

			--

			'powershell_es',
			'lua_ls',
			--[[ 'yamlls', ]]
			'vimls',
			'rust_analyzer',
			--[[ 'debugpy', ]]
			--[[ 'pyright', ]]
			'ruff_lsp',
			'bashls',
			--
		}
	})
end

return M
