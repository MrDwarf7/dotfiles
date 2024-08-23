return {
	--#region nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
		init = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			keys[#keys + 1] = { "<Leader>c", false }
			keys[#keys + 1] = { "<Leader>ca", false }
			keys[#keys + 1] = { "<Leader>cc", false }
			keys[#keys + 1] = { "<Leader>cC", false }
			keys[#keys + 1] = { "<Leader>cR", false }
			keys[#keys + 1] = { "<Leader>cr", false }
			keys[#keys + 1] = { "<Leader>cA", false }
			keys[#keys + 1] = { "<Leader>cl", false }
			keys[#keys + 1] = { "<Leader>cs", false }
			keys[#keys + 1] = { "<Leader>cS", false }
			keys[#keys + 1] = { "gy", false }
			keys[#keys + 1] = { "gy", false }
			keys[#keys + 1] = { "<C-k>", false }
		end,

		opts = function(_, opts)
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			keys[#keys + 1] = { "gt", vim.lsp.buf.type_definition, desc = "[t]ype Definition" }
			keys[#keys + 1] = { "gd", vim.lsp.buf.definition, desc = "[d]efinition", has = "definition" }
			keys[#keys + 1] = { "gr", vim.lsp.buf.references, desc = "[r]eferences", nowait = true }
			keys[#keys + 1] = { "gI", vim.lsp.buf.implementation, desc = "[I]mplementation" }
			keys[#keys + 1] = { "gD", vim.lsp.buf.declaration, desc = "[D]eclaration" }

			keys[#keys + 1] = { "<C-k>", vim.lsp.buf.signature_help, "Signature Help" }

			keys[#keys + 1] = { "<Leader>l", "", desc = "+[L]sp" }
			keys[#keys + 1] = { "<Leader>la", vim.lsp.buf.code_action, desc = "[a]ction", has = "codeAction" }
			keys[#keys + 1] = { "<Leader>lh", vim.diagnostic.open_float, desc = "[h]over" }
			keys[#keys + 1] = { "<leader>lc", vim.lsp.codelens.run, desc = "[c]heck", mode = { "n", "v" }, has = "codeLens" }
			keys[#keys + 1] = {
				"<leader>lC",
				vim.lsp.codelens.refresh,
				desc = "[c]heck & refresh",
				has = "codeLens",
			}
			keys[#keys + 1] = { "<leader>lr", vim.lsp.buf.rename, desc = "[r]ename", has = "rename" }
			keys[#keys + 1] = {
				"<leader>lR",
				LazyVim.lsp.rename_file,
				desc = "[R]ename file",
				mode = { "n" },
				has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
			}
			keys[#keys + 1] = { "<leader>lI", "<cmd>LspInfo<cr>", desc = "[l]sp [I]nfo" }

			opts.servers = {
				bashls = {},
				biome = {},
				clangd = {
					cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },
					single_file_support = true,
					capabilities = opts.capabilities,
				},
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
					capabilities = opts.capabilities,
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
		end,
	},
	--#endregion nvim-lspconfig

	{
		"mrcjkb/rustaceanvim",
		opts = {
			tools = {
				float_win_config = {
					border = "single",
					-- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					highlight = "Normal",
				},
				hover_actions = {
					auto_focus = true,
				},
				inlay_hints = {
					autoSetHints = true,
					auto = true,
					highlight = "NonText",
				},
			},
			server = {
				on_attach = function(_, bufnr)
					vim.keymap.set("n", "<Leader>lc", function()
						vim.cmd.RustLsp("flyCheck")
					end, { desc = "[c]heck" })

					vim.keymap.set("n", "<Leader>dd", function()
						vim.cmd.RustLsp("debuggables")
					end, { desc = "[d]ebuggables" })

					vim.keymap.set("n", "<Leader>dr", function()
						vim.cmd.RustLsp("runnables")
					end, { desc = "[r]un" })

					vim.keymap.set("n", "<Leader>la", function()
						vim.cmd.RustLsp("codeAction")
					end, { desc = "[a]ction", buffer = bufnr })
				end,
				default_settings = {
					-- rust-analyzer language server configuration
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						-- Add clippy lints for Rust.
						checkOnSave = true,
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
						},
						inlay_hints = {
							align = true,
							bindingHints = true,
							chainingHints = true,
							closingBraceHints = true,
							closureCaptureHints = true,
							closureReturnTypeHints = true,
							closureStyle = "rust_analyzer",
							discriminationHints = true,
							expressionAdjustmentHints = true,
							highlight = "Comment",
							implicitDrops = true,
							lifetimeEllisionHints = {
								enable = true,
								useParamaterNames = true,
							},
							-- lifetimeEllisionHints = true,
							maxLength = 120,
							mutableBorrowHints = true,
							parameterHints = {
								enable = true,
							},
							-- parameterHints = true,
							prefix = " » ",
							rangeExclusiveHints = {
								enable = true,
							},
							typeHints = true,
						},
					},
				},
			},
		},
	},
}

-- { "]]", function() LazyVim.lsp.words.jump(vim.v.count1) end, has = "documentHighlight",
--   desc = "Next Reference", cond = function() return LazyVim.lsp.words.enabled end },
-- { "[[", function() LazyVim.lsp.words.jump(-vim.v.count1) end, has = "documentHighlight",
--   desc = "Prev Reference", cond = function() return LazyVim.lsp.words.enabled end },
-- { "<a-n>", function() LazyVim.lsp.words.jump(vim.v.count1, true) end, has = "documentHighlight",
--   desc = "Next Reference", cond = function() return LazyVim.lsp.words.enabled end },
-- { "<a-p>", function() LazyVim.lsp.words.jump(-vim.v.count1, true) end, has = "documentHighlight",
--   desc = "Prev Reference", cond = function() return LazyVim.lsp.words.enabled end },

--stylua: ignore start
---------- Telescope versions ----------
-- 	{ "<Leader>ls", function() require("telescope.builtin").lsp_document_symbols() end, desc = "[S]ymbols document" },
-- 	{ "<Leader>lS", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, desc = "[S]ymbol workspace" },
-- 	{ "<Leader>ll", function() require("telescope.builtin").lsp_incoming_calls() end, desc = "ca[l]ls incoming" },
-- 	{ "<Leader>lL", function() require("telescope.builtin").lsp_outgoing_calls() end, desc = "ca[L]ls outgoing" },
-- 	{ "<Leader>lt", function() require("telescope.builtin").treesitter() end, desc = "[T]reesitter symbols" },
-- 	{ "<Leader>ld", function() require("telescope.builtin").diagnostics() end, desc = "[d]iagnostics" },
-- 	{ "gr", function() require("telescope.builtin").lsp_references() end, desc = "[G]oto [r]eferences" },
-- 	{ "gi", function() require("telescope.builtin").lsp_implementations() end, desc = "[G]oto [I]mpl" },
-- 	{ "gt", function() require("telescope.builtin").lsp_type_definitions() end, desc = "[G]oto [t]ype def" },
-- 	{ "gd", function() require("telescope.builtin").lsp_definitions() end, desc = "[G]oto [d]efinition" },
-- 	{ "gO", function() require("telescope.builtin").lsp_outgoing_calls() end, desc = "[O]utgoing" },
-- stylua: ignore end
