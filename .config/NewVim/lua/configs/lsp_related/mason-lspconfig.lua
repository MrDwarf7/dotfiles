local nvim_lsp_utils = require("lspconfig.util")
local mason_lspconfig = require("mason-lspconfig")
local nvim_lsp = require("lspconfig")
local capabilities = require("util.lsp-capabilities")
local nvim_lsp_config_file = require("configs.lsp_related.nvim-lspconfig")
local lsp_mappings = require("util.lsp-mappings")
local nvim_lsp_servers_list = require("configs.lsp_related.nvim-lsp-servers")

local ensure_installed_table = {}

if vim.g.os == "unix" then
	ensure_installed_table = {
		--"awk_ls", -- Un-updated (requires running LTS version of node via NVM)
		"azure_pipelines_ls",
		"bashls",
		"biome",
		"clangd",
		"cmake",
		"cssls",
		"docker_compose_language_service",
		"dockerls",
		"eslint",
		"gopls",
		"html",
		"lua_ls",
		"marksman",
		-- "powershell_es",
		"prismals",
		"pyright",
		"ruff_lsp",
		-- "rust_analyzer", -- Since using Rustaceanvim, DO NOT SETUP via lspconfig call
		"slint_lsp",
		"tailwindcss",
		"taplo",
		-- "tsserver",
		"vimls",
		"yamlls",
		"zls",
	}
elseif vim.g.os == "win32" then
	ensure_installed_table = {
		--"awk_ls", -- Un-updated (requires running LTS version of node via NVM)
		"azure_pipelines_ls",
		-- "bashls",
		"biome",
		"clangd",
		"cmake",
		"cssls",
		"docker_compose_language_service",
		"dockerls",
		"eslint",
		"gopls",
		"html",
		"lua_ls",
		"marksman",
		"powershell_es",
		"prismals",
		"pyright",
		"ruff_lsp",
		-- "rust_analyzer", -- Since using Rustaceanvim, DO NOT SETUP via lspconfig call
		"slint_lsp",
		"tailwindcss",
		"taplo",
		-- "tsserver",
		"vimls",
		"yamlls",
		"zls",
	}
end

mason_lspconfig.setup({
	ensure_installed = ensure_installed_table,
	automatic_installation = {
		exclude = { "rust_analyzer", "pyright", "clangd", "ruff_lsp", "tsserver" },
	},

	handlers = {
		function(server_name)
			if server_name == "clangd" then
				return
			end
			if server_name == "rust_analyzer" then
				return
			end
			-- mason_lspconfig.clangd = function()
			--     nvim_lsp_servers_list.clangd.setup()
			--     nvim_lsp_config_file.lsp_on_attach()
			--     capabilities = nvim_lsp_servers_list[nvim_lsp.clangd.setup(capabilities)]
			-- end

			nvim_lsp[server_name].setup({
				on_attach = function()
					nvim_lsp_config_file.lsp_on_attach()
					-- inlay_hints_attach()
				end,
				capabilities = capabilities.default_capabilities(),
			})
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

					nvim_lsp_config_file.lsp_on_attach()
					-- inlay_hints_attach()
				end,

				capabilities = capabilities.default_capabilities(),
				cmd = { "ruff-lsp" },
				filetypes = { "python" },
			})

			nvim_lsp.pyright.setup({
				on_attach = function(_, client)
					client.server_capabilities.hoverProvider = true
					client.server_capabilities.codeActionProvider = true
					client.server_capabilities.codeLensProvider = true
					-- client.server_capabilities.completionProvider = true
					nvim_lsp_config_file.lsp_on_attach()
				end,

				capabilities = capabilities.default_capabilities(),
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
				root_dir = nvim_lsp_utils.root_pattern(
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
							diagnosticMode = "workspace",
							useLibraryCodeForTypes = true,
						},
					},
				},
			}) -- End pyright

			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if not has_cmp then
				return
			end

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

			nvim_lsp.clangd.setup({
				on_attach = function(_, client)
					-- attach_fnc(_)
					client.server_capabilities.documentFormattingProvider = false
					-- client.capabilities.offsetEncoding = "utf-16"
					nvim_lsp_config_file.lsp_on_attach()
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

			nvim_lsp.lua_ls.setup({
				on_attach = function(_, client)
					client.server_capabilities.hoverProvider = true
					nvim_lsp_config_file.lsp_on_attach()
				end,
				capabilities = capabilities.default_capabilities(),

				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_dir = nvim_lsp_utils.root_pattern(".git", ".luacheckrc", ".luarocks", "lua.config.*"),
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
							path = vim.split(package.path, ";"),
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file("", true)),
								-- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
								-- [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
							},
						},
					},
				},
			}) -- End lua

			-- nvim_lsp.tsserver.setup({
			--     on_attach = function(_, client)
			--         client.server_capabilities.hoverProvider = true
			--         attach_fnc(_)
			--     end,
			--     capabilities = capabilities_fnc,
			-- }) -- End tsserver

			nvim_lsp.tailwindcss.setup({
				on_attach = function()
					nvim_lsp_config_file.lsp_on_attach()
				end,
				capabilities = capabilities.default_capabilities(),
				filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
				flags = { debounce_text_changes = 300 },
				root_dir = nvim_lsp.util.root_pattern("tailwind.config.*"),
			})

			-- nvim_lsp["lua_ls"].setup({
			-- 	on_attach = function(_, client)
			-- 		client.server_capabilities.hoverProvider = true
			-- 		nvim_lsp_config_file.lsp_on_attach()
			-- 	end,
			-- 	capabilities = capabilities.default_capabilities(),
			-- 	cmd = { "lua-language-server" },
			-- 	filetypes = { "lua" },
			-- 	root_dir = nvim_lsp.util.root_pattern(".git", ".luacheckrc", ".luarocks", "lua.config.*"),
			-- 	settings = {
			-- 		Lua = {
			-- 			runtime = {
			-- 				version = "LuaJIT",
			-- 				path = vim.split(package.path, ";"),
			-- 			},
			-- 			diagnostics = {
			-- 				globals = { "vim" },
			-- 			},
			-- 			workspace = {
			-- 				library = {
			-- 					"${3rd}/luv/library",
			-- 					unpack(vim.api.nvim_get_runtime_file("", true)),
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- })
		end,
	},
})
