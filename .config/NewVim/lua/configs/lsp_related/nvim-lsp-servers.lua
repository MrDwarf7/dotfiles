local buffer = require("util.buffer")
local nvim_lsp = require("lspconfig")
local nvim_lsp_utils = require("lspconfig.util")

local cmd = vim.cmd
local lsp = vim.lsp
local map = vim.keymap.set
local opt_local = vim.opt_local

local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not has_cmp then
	return
end

local M = {}

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
	}
)

M.lsp_server_setups = function(attach_fnc, capabilities_fnc)
	nvim_lsp.ruff_lsp.setup({
		on_attach = function(_, client)
			client.server_capabilities.hoverProvider = false
			client.server_capabilities.completionProvider = false
			client.server_capabilities.signatureHelpProvider = false
			client.server_capabilities.definitionProvider = false
			client.server_capabilities.referencesProvider = false
			client.server_capabilities.documentSymbolProvider = false
			client.server_capabilities.workspaceSymbolProvider = false
			client.server_capabilities.codeActionProvider = false
			client.server_capabilities.codeLensProvider = false
			client.server_capabilities.documentFormattingProvider = true
			client.server_capabilities.documentRangeFormattingProvider = true
			client.server_capabilities.documentOnTypeFormattingProvider = false
			client.server_capabilities.renameProvider = false
			client.server_capabilities.documentLinkProvider = false
			client.server_capabilities.executeCommandProvider = true
			client.server_capabilities.typeDefinitionProvider = false
			client.server_capabilities.implementationProvider = false
			client.server_capabilities.declarationProvider = false
			-- client.server_capabilities.colorProvider = true
			client.server_capabilities.foldingRangeProvider = false
			attach_fnc(_)
		end,

		capabilities = capabilities_fnc,
		cmd = { "ruff-lsp" },
		filetypes = { "python" },
	})

	nvim_lsp.pyright.setup({
		on_attach = function(_, client)
			client.server_capabilities.hoverProvider = true
			client.server_capabilities.codeActionProvider = true
			client.server_capabilities.codeLensProvider = true
			attach_fnc(_)
			-- client.server_capabilities.completionProvider = true
		end,

		capabilities = capabilities_fnc,
		cmd = { "pyright-langserver", "--stdio" },
		filetypes = { "python" },
		root_dir = nvim_lsp_utils.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt"),
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					useLibraryCodeForTypes = true,
				},
			},
		},
	}) -- End pyright

	nvim_lsp.clangd.setup({
		on_attach = function(_, client)
			-- attach_fnc(_)
			client.server_capabilities.documentFormattingProvider = false
			-- client.capabilities.offsetEncoding = "utf-16"
		end,
		capabilities = clangd_capabilities,

		cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		root_dir = nvim_lsp_utils.root_pattern( -- THIS WORK OR HAVE TO MATCH THE WAY PYRIGHT CALLS LSPCONFIG???
			".clangd",
			".clang-tidy",
			".clang-format",
			"compile_commands.json",
			"compile_flags.txt",
			"configure.ac",
			".git"
		),
		single_file_support = true,
	}) -- End clangd

	-- nvim_lsp.tsserver.setup({
	--     on_attach = function(_, client)
	--         client.server_capabilities.hoverProvider = true
	--         attach_fnc(_)
	--     end,
	--     capabilities = capabilities_fnc,
	-- }) -- End tsserver

	nvim_lsp.tailwindcss.setup({
		on_attach = attach_fnc,
		capabilities = capabilities_fnc,
		filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
		flags = { debounce_text_changes = 300 },
		root_dir = nvim_lsp.util.root_pattern("tailwind.config.*"),
	})

	-- nvim_lsp.powershell_es.setup({
	-- 	on_attach = attach_fnc,
	-- 	capabilities = capabilities_fnc,
	-- 	filetypes = { "ps1", "psm1", "psd1" },
	-- 	flags = { debounce_text_changes = 300 },
	-- 	root_dir = nvim_lsp.util.root_pattern("*.ps1"),
	-- 	cmd = "pwsh -NoLogo -NoProfile -Command & '$env:LOCALAPPDATA\\nvim-data\\mason\\packages\\powershell-editor-services/PowerShellEditorServices/Start-EditorServices.ps1' -BundledModulesPath '$env:LOCALAPPDATA\\nvim-data\\mason\\packages\\powershell-editor-services' -LogPath '$env:TEMP\\nvim/powershell_es.log' -SessionDetailsPath '$env:TEMP\\nvim/powershell_es.session.json' -FeatureFlags @() -AdditionalModules @() -HostName nvim -HostProfileId 0 -HostVersion 1.0.0 -Stdio -LogLevel Normal",
	-- })
end

return M
