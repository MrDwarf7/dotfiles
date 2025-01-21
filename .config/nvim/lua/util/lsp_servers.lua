local M = {}

vim.g.markdown_denced_languaged = {
	"ts=typescript",
}

setmetatable(M, {
	__call = function(self)
		return self.servers()
	end,
	__index = function(self, key)
		if type(key) == "string" then
			dd(key)
			return self.servers()[key]
		end
	end,
})

M.capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
	return capabilities
end

M.servers = function()
	local self = M
	-- local capabilities = M.capabilities()
	local servers = {
		bacon = {},
		bashls = {},
		biome = {},
		clangd = {
			cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },
			single_file_support = true,
			capabilities = self:capabilities(),
		},
		neocmake = {},

		cssls = {},
		deno = {},

		-- deno = {
		-- 	root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
		-- 	settings = {
		-- 		deno = {
		-- 			enable = true,
		-- 			suggest = {
		-- 				imports = {
		-- 					hosts = {
		-- 						["https://deno.land"] = true,
		-- 					},
		-- 				},
		-- 			},
		-- 		},
		-- 	},
		-- },
		docker_compose_language_service = {},
		dockerls = {},
		-- erlangls = {},
		-- eslint = {},
		-- gleam = {},
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
		-- markdown_oxide = {},

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
				"\\.venv",
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
		ruff = {
			filetypes = { "python" },
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
		zls = {
			-- zls = {
			-- 	cmd = { zls_exe },
			-- 	capabilities = vim.tbl_deep_extend("keep", M.capabilities() or {}, {}),
			settings = {
				zls = {
					-- zig_exe_path = zig_exe,
					enableAutofix = true,
					enable_snippets = true,
					enable_ast_check_diagnostics = true,
					enable_autofix = true,
					enable_import_embedfile_argument_completions = true,
					warn_style = true,
					enable_semantic_tokens = true,
					enable_inlay_hints = true,
					inlay_hints_hide_redundant_param_names = true,
					inlay_hints_hide_redundant_param_names_last_token = true,
					operator_completions = true,
					include_at_in_builtins = true,
					max_detail_length = 1048576,
				},
			},
			-- },
		},
	}

	-- Coniditional servers
	if vim.g.os == "Linux" or vim.g.os == "unix" then
		-- check if we're on nixOS
		if vim.fn.system("nixos-version") == 0 then
			table.insert(servers, "nixd")
			servers.nixd = {}
		end
	end

	return servers
end

M.keys = function(self)
	return vim.tbl_keys(self:servers())
end

M.extend_table = function(self, tbl)
	return vim.tbl_extend("force", self:servers(), tbl)
end

M.extend_list = function(self, tbl)
	return vim.list_extend(self:keys(), tbl)
end

return M
