local lspconfig = require('lspconfig')

local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not has_cmp then
	return
end
local util = require 'lspconfig.util'
local bufnr = vim.api.nvim_get_current_buf()
local capabilities = vim.lsp.protocol.make_client_capabilities()

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local clangd_capabilities = vim.tbl_deep_extend(
	"force",
	{},
	vim.lsp.protocol.make_client_capabilities(),
	has_cmp and cmp_nvim_lsp.default_capabilities() or {},
	{
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true,
				},
			},
		},
	})

lspconfig.lua_ls.setup({
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_dir = function(fname)
		local root_files = {
			'.luarc.json',
			'.luarc.jsonc',
			'.luacheckrc',
			'.stylua.toml',
			'stylua.toml',
			'selene.toml',
			'selene.yml',
		}
		local root = util.root_pattern(unpack(root_files))(fname)
		if root and root ~= vim.env.HOME then
			return root
		end
		root = util.root_pattern 'lua/' (fname)
		if root then
			return root
		end
		return util.find_git_ancestor(fname)
	end,
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
	on_attach = function(client)
		client.server_capabilities.hoverProvider = true
	end,
	capabilities = capabilities
}) -- End lua_ls

lspconfig.tsserver.setup({
	on_attach = function(client)
		client.server_capabilities.hoverProvider = true
	end,
	capabilities = capabilities,
}) -- End tsserver

lspconfig.biome.setup({
	cmd = { 'biome', 'lsp-proxy' },
	filetypes = {
		'javascript',
		'javascriptreact',
		'json',
		'jsonc',
		'typescript',
		'typescript.tsx',
		'typescriptreact',
	},
	root_dir = util.root_pattern 'biome.json',
	single_file_support = false,
	default_config = {
		root_dir = [[root_pattern('biome.json')]],
	},
	on_attach = function(client)
		client.server_capabilities.hoverProvider = true
	end,
	capabilities = capabilities,
}) -- End biome


lspconfig.bashls.setup({
	cmd = { 'bash-language-server', 'start' },
	settings = {
		bashIde = {
			globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
		},
	},
	filetypes = { 'sh' },
	root_dir = util.find_git_ancestor,
	single_file_support = true,

	default_config = {
		root_dir = [[util.find_git_ancestor]],
	},
	on_attach = function(client)
		client.server_capabilities.hoverProvider = true
	end,
	capabilities = capabilities,
}) -- End bashls'


lspconfig.cmake.setup({
	cmd = { 'cmake-language-server' },
	filetypes = { 'cmake' },
	root_dir = function(fname)
		return util.root_pattern(unpack(root_files))(fname)
	end,
	single_file_support = true,
	init_options = {
		buildDirectory = 'build',
	},
	default_config = {
		root_dir = [[root_pattern('CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake')]],
	},
	on_attach = function(client)
		client.server_capabilities.hoverProvider = true
	end,
	capabilities = capabilities,
}) -- End cmake


lspconfig.vimls.setup({
	cmd = { 'vim-language-server', '--stdio' },
	filetypes = { 'vim' },
	root_dir = util.find_git_ancestor,
	single_file_support = true,
	init_options = {
		isNeovim = true,
		iskeyword = '@,48-57,_,192-255,-#',
		vimruntime = '',
		runtimepath = '',
		diagnostic = { enable = true },
		indexes = {
			runtimepath = true,
			gap = 100,
			count = 3,
			projectRootPatterns = { 'runtime', 'nvim', '.git', 'autoload', 'plugin' },
		},
		suggest = { fromVimruntime = true, fromRuntimepath = true },
	},
	gn_attach = function(_, client)
		client.server_capabilities.hoverProvider = true
	end,
	capabilities = capabilities,
})

-- lspconfig.dockerls.setup {},
-- lspconfig.docker_compose_language_service.setup {},

-------------------------------------------------------

lspconfig.ruff_lsp.setup({
	on_attach = function(_, client)
		client.server_capabilities.hoverProvider = false
	end,
	capabilities = capabilities,
	cmd = { "ruff-lsp" },
	filetypes = { "python" }
})

lspconfig.pyright.setup({
	on_attach = function(client)
		client.server_capabilities.hoverProvider = true
	end,
	capabilities = capabilities,
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_dir = require("lspconfig.util").root_pattern(
		".git",
		"setup.py",
		"setup.cfg",
		"pyproject.toml",
		"requirements.txt"
	),
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
			},
		},
	},
}) -- End pyright


--BUG: ~/.xdg/share/nvim/lazy/nvim-lspconfig/lua/lspconfig/server_configurations/clangd.lua
--~/.xdg/data/nvim/lazy/nvim-lspconfig/lua/lspconfig/server_configurations
-- Navigate to the above file and change line 39 from using BOTH utf-8 and utf-16 to just utf-16,
-- remove the table brackets and just use "utf-16" as the value.
-- This is a workaround for:
-- warning: multiple different client offset encodings
lspconfig.clangd.setup({
	on_attach = function(_, client)
		client.capabilities.offsetEncoding = "utf-16"
	end,
	capabilities = clangd_capabilities,
	cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },

	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	root_dir = require("lspconfig.util").root_pattern( -- THIS WORK OR HAVE TO MATCH THE WAY PYRIGHT CALLS LSPCONFIG???
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac",
		".git"
	),
	single_file_support = true,
}) -- End CLANGD
