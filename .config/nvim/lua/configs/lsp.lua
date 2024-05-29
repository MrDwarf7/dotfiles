local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

return {
	{

		"neovim/nvim-lspconfig",
		lazy = true,
		event = {
			"BufReadPre",
		},
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },

			{
				"folke/neoconf.nvim",
				cmd = "Neoconf",
				-- config = false,
			},
			{ "folke/neodev.nvim", opts = {} },
			{
				"j-hui/fidget.nvim",
				-- lazy = false,
				opts = {},
			},
			{
				"williamboman/mason.nvim",
				-- lazy = false,
				event = "BufEnter",
			},
			{ "williamboman/mason-lspconfig.nvim", lazy = true },
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				lazy = true,
				-- event = "VeryLazy",
			},
		},
		config = function()
			autocmd("LspAttach", {
				group = augroup("LspAuGroup", { clear = true }),
				----@param event Event: LspAttach
				callback = function(event)
					-- if vim.lsp.client.name == "rust_analyzer" then
					-- 	return true
					-- end
					--
					---@param keys string
					---@param func function
					---@param desc string
					---@return nil
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [d]efinition")
					-- map("gd", vim.lsp.buf.definition, "[G]oto [d]efinition") -- Prefer built-in
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclration")

					map("gr", require("telescope.builtin").lsp_references, "[G]oto [r]eferences")
					map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mpl")
					map("gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [t]ype def")

					map("<Leader>ls", require("telescope.builtin").lsp_document_symbols, "[S]ymbols document")
					map("<Leader>lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[S]ymbol workspace")

					map("<Leader>ll", require("telescope.builtin").lsp_incoming_calls, "ca[l]ls incoming")
					map("<Leader>lL", require("telescope.builtin").lsp_outgoing_calls, "ca[L]ls outgoing")
					map("<Leader>lt", require("telescope.builtin").treesitter, "[T]reesitter symbols")
					map("<Leader>ld", require("telescope.builtin").diagnostics, "[d]iagnostics")
					map("<Leader>lr", vim.lsp.buf.rename, "[r]ename")
					map("<Leader>la", vim.lsp.buf.code_action, "[a]ction")
					map("K", vim.lsp.buf.hover, "Hoever Docs")
					map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

					----------------------
					map("gO", require("telescope.builtin").lsp_outgoing_calls, "[O]utgoing")
					map("<Leader>lh", vim.diagnostic.open_float, "float")
					map("]d", vim.diagnostic.goto_next, "diag next")
					map("[d", vim.diagnostic.goto_prev, "diag prev")

					map("<Leader>lf", function()
						if package.loaded["conform"] then
							require("conform").format()
						elseif package.loaded["conform"] == nil then
							vim.lsp.buf.format({ async = true })
						end
					end, "format")

					local lsp_restart = function()
						vim.lsp.stop_client(vim.lsp.get_active_clients())
						vim.cmd([[ LspRestart<CR> ]])
					end

					map("<Leader>l%", lsp_restart, "Restart")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
					--

					vim.lsp.inlay_hint.enable()
				end,
			})

			local handlers = require("util.lsp-handlers")

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				bashls = {},
				biome = {},
				clangd = {
					cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },
					single_file_support = true,
					capabilities = capabilities,
				},

				cssls = {},

				docker_compose_language_service = {},
				dockerls = {},
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
				omnisharp = {
					filetypes = { "cs", "vb" },
				},
				powershell_es = {
					filetypes = { "powershell", "ps1", "psm1", "psd1" },
					-- bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/PowerShellEditorServices",
					settings = {
						powershell = {
							codeFormatting = {
								Preset = "OTBS",
							},
						},
						scriptAnalysis = {
							enable = true,
						},
						completion = {
							enable = true,
							useCommandDiscovery = true,
						},
					},
				},
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
					capabilities = capabilities,
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
				zls = {},
			}

			require("mason").setup({
				pip = {
					upgrade_pip = true,
				},

				ui = {
					border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
					icons = {
						package_pending = " ",
						package_installed = "󰄳 ",
						package_uninstalled = " 󰚌",
					},
				},
			})

			local ensure_installed = vim.tbl_keys(servers or {})
			-- Things that are not LSP servers, but are installable via Mason
			vim.list_extend(ensure_installed, {
				"beautysh",
				"black",
				"clang-format",
				"codelldb",
				"debugpy",
				"delve",
				"fixjson",
				"isort",
				"jsonlint",
				"mypy",
				"powershell_es",
				"prettier",
				"ruff",
				"shfmt",
				"stylua",
				"ts-standard",
				"vulture",
				"yamlfmt",
				"csharpier",
			})

			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
			})

			local plugin_handled = {
				"cmake",
				"gopls",
				"rust_analyzer",
				"tsserver",
			}

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						if server_name == vim.tbl_keys(plugin_handled) then
							return true
						end
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})

			require("lspconfig.ui.windows").default_options.border = "single"

			vim.lsp.handlers["textDocument/hover"] = handlers.hover
			vim.lsp.handlers["textDocument/signatureHelp"] = handlers.signature_help
			vim.lsp.handlers["textDocument/diagnostics_border"] = handlers.diagnostics_border
			vim.diagnostic.config({
				virtual_text = true,
				underline = true,
				signs = true,
				update_in_insert = true,
				float = { border = "single" }, -- This line
			})
		end,
	},
}
