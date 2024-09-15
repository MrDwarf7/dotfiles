local M = {}

M.capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
	return capabilities
end

-- local capabilities = capabilities

-- return {
M.servers = function()
	return {
		bashls = {},
		biome = {},
		clangd = {
			cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },
			single_file_support = true,
			capabilities = M.capabilities,
		},
		neocmake = {},

		cssls = {},

		docker_compose_language_service = {},
		dockerls = {},
		-- erlangls = {},
		eslint = {},
		html = {},
		jsonls = {},
		lua_ls = {
			cmd = { "lua-language-server" },
			filetypes = { "lua" },
			root_dir = require("lspconfig.util").root_pattern(".git", ".luacheckrc", ".luarocks", "lua.config.*"),
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
						path = vim.split(package.path, ";"),
					},
					completion = {
						callSnippet = "Replace",
					},
					diagnostics = {
						disable = { "missing-fields" },
						globals = { "vim" },
					},
					workspace = {
						checkThirdParty = true,
						codeLens = {
							enable = true,
						},
						completion = {
							callSnippet = "Replace",
						},
						doc = {
							privateName = { "^_" },
						},
						hint = {
							enable = true,
							setType = false,
							paramType = true,
						},
						library = {
							"${3rd}/luv/library",
							-- unpack(vim.api.nvim_get_runtime_file("", true)),
							-- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
							-- [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
						},
					},
				},
			},
		},
		marksman = {},
		ols = {},
		omnisharp = {
			filetypes = { "cs", "vb" },
		},
		-- powershell_es = {
		-- 	cmd = { "pwsh", "-NoLogo", "-NoProfile", "-Command", "Invoke-EditorServices" },
		-- 	filetypes = { "powershell", "ps1", "psm1", "psd1" },
		-- 	root_dir = require("lspconfig.util").root_pattern(
		-- 		".git",
		-- 		".editorconfig",
		-- 		".gitignore",
		-- 		".ps1",
		-- 		".psm1",
		-- 		".psd1"
		-- 	),
		-- 	-- bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/PowerShellEditorServices",
		-- 	bundle_path = "~/AppData/Local/nvim-data/mason/packages/powershell-editor-services",
		-- 	settings = {
		-- 		powershell = {
		-- 			codeFormatting = {
		-- 				Preset = "OTBS",
		-- 			},
		-- 		},
		-- 		scriptAnalysis = {
		-- 			enable = true,
		-- 		},
		-- 		completion = {
		-- 			enable = true,
		-- 			useCommandDiscovery = true,
		-- 		},
		-- 	},
		-- },
		prismals = {},
		pyright = {
			cmd = { "pyright-langserver", "--stdio" },
			filetypes = { "python" },
			root_dir = require("lspconfig.util").root_pattern(
				".git",
				"setup.py",
				"setup.cfg",
				"pyproject.toml",
				"requirements.txt",
				".venv",
				"venv"
			),
			on_attach = vim.lsp.inlay_hint.enable(),
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "workspace",
						useLibraryCodeForTypes = true,
					},
				},
			},
		},
		ruff_lsp = {
			cmd = { "ruff-lsp" },
			filetypes = { "python" },
			single_file_support = true,
			capabilities = M.capabilities,
		},

		tailwindcss = {
			filetypes = {
				"html",
				"css",
				"scss",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
			},
			flags = { debounce_text_changes = 300 },
			root_dir = require("lspconfig.util").root_pattern("tailwind.config.*"),
		},
		taplo = {},
		vimls = {},
		yamlls = {},
	}
end

-- M.setup = function()
-- 	local capabilities = M.capabilities()
-- 	local servers = M.servers()
-- 	return {
-- 		capabilities = capabilities,
-- 		servers = servers,
-- 	}
-- end

return {
	M.servers(),
	M.capabilities(),
}
