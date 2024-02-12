return {
	{
		"neovim/nvim-lspconfig",
		event = "BufEnter",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},

		-- Mason LSP CONFIG
		-- allows specifically for a cross over in the naming schema between
		-- the actual lsp server, and the naming conventions for the connections.
		-- in the below list - go to Mason, hit / to start a search and cancel it,
		-- this will give ghost text of the udnerlying name - Which is what you want to use here.

		config = function()
			-- local utils = require("utils")
			-- local on_attach = utils.on_attach("omnifunc", "vim:lua.vim.lsp.omnifunc")

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

			local bufnr = vim.api.nvim_get_current_buf()

			local custom_offset = vim.lsp.protocol.make_client_capabilities()
			local on_attach = function(client, bufnr)
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
				-- client.resolved_capabilities.document_formatting = false
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()

			local opts = { silent = true, nowait = true, buffer = bufnr }

			local lsp_binds = function(_)
				vim.keymap.set("n", "<Leader>l", "+[l]sp", { desc = "+[l]sp" })

				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, opts)

				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, opts, { desc = "[d]efinition" })

				vim.keymap.set("n", "gD", function()
					vim.lsp.buf.declaration()
				end, opts, { desc = "[D]eclaration" })

				vim.keymap.set("n", "gr", function()
					vim.lsp.buf.references()
				end, opts, { desc = "[r]eferences" })

				vim.keymap.set("n", "gi", function()
					vim.lsp.buf.implementation()
				end, opts, { desc = "[i]mplementations" })

				vim.keymap.set("n", "gt", function()
					vim.lsp.buf.type_definition()
				end, opts, { desc = "[T]ype" })

				vim.keymap.set("n", "]d", function()
					vim.diagnostic.goto_next()
				end, opts, { desc = "[diag] next" })

				vim.keymap.set("n", "[d", function()
					vim.diagnostic.goto_prev()
				end, opts, { desc = "[diag] prev" })

				vim.keymap.set("n", "gI", function()
					vim.lsp.buf.incoming_calls()
				end, opts, { desc = "[i]ncoming" })

				vim.keymap.set("n", "gO", function()
					vim.lsp.buf.outgoing_calls()
				end, opts, { desc = "[O]utgoing" })

				vim.keymap.set("n", "<Leader>lt", ":TodoLocList<CR>", { desc = "list [t]odo's" })

				vim.keymap.set("n", "<C-k>", function()
					vim.lsp.buf.signature_help()
				end, opts, { desc = "Signature Help" })

				vim.keymap.set("n", "<Leader>lr", function()
					vim.lsp.buf.rename()
				end, opts, { desc = "[r]ename" })

				vim.keymap.set({ "n", "v" }, "<Leader>la", function()
					vim.lsp.buf.code_action()
				end, opts, { desc = "Code [a]ction" })

				vim.keymap.set("n", "<Leader>lf", function()
					vim.lsp.buf.format({ async = true })
				end, opts, { desc = "[f]ormat (lsp)" })

				vim.keymap.set("n", "<Leader>lh", function()
					vim.diagnostic.open_float()
				end, opts, { desc = "[h]over" })

				vim.keymap.set("n", "<Leader>lt", ":TodoLocList<CR>", { desc = "list [t]odo's" })
				-- LSP attach autocmds are called within the autocmds file (group = LspAuGroup)
			end

			require("mason").setup({
				ui = {
					border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
					icons = {
						package_pending = " ",
						package_installed = "󰄳 ",
						package_uninstalled = " 󰚌",
					},
				},

				ensure_installed = {
					"biome",
					"eslint_d",
					"mypy",
					"ruff",
					-- "ruff_lsp",
					"pyright",
					"shellcheck",
					"ts-standard",
					"vulture",
					"beautysh",
					"biome",
					"black",
					"blackd-client",
					"isort",
					"prettier",
					"prettierd",
					"rustywind",
					"shfmt",
					"ts-standard",
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"tsserver",
					"biome",
					--"awk_ls", -- Un-updated (requires running LTS version of node via NVM)
					"azure_pipelines_ls",
					"bashls",
					"clangd",
					"cmake",
					"cssls",
					"docker_compose_language_service",
					"dockerls",
					"eslint",
					"html",
					"taplo",
					"marksman",
					"powershell_es",
					"prismals",
					"tailwindcss",
					"ruff_lsp",
					"pyright",
					--"rust_analyzer", -- Since using Rustaceanvim, DO NOT SETUP via lspconfig call
					"slint_lsp",
					"vimls",
					"yamlls",
					"zls",
				},

				handlers = {
					-- function(server_name)
					-- 	require("lspconfig")[server_name].setup({
					-- 		on_attach = on_attach,
					-- 		capabilities = capabilities,
					-- 		lsp_binds(),
					-- 	})
					-- end,

					require("lspconfig").ruff_lsp.setup({
						on_attach = function(_, client)
							client.server_capabilities.hoverProvider = false
						end,
						capabilities = capabilities,
						cmd = { "ruff-lsp" },
						filetypes = { "python" },
						lsp_binds(),
					}),

					require("lspconfig").pyright.setup({
						on_attach = function(_, client)
							client.server_capabilities.hoverProvider = true
							-- client.server_capabilities.completionProvider = true
						end,
						capabilities = capabilities,
						lsp_binds(),
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
					}), -- End pyright

					require("lspconfig").tsserver.setup({
						on_attach = function(_, client)
							client.server_capabilities.hoverProvider = true
						end,
						capabilities = capabilities,
						lsp_binds(),
					}), -- End tsserver

					--BUG: ~/.xdg/share/nvim/lazy/nvim-lspconfig/lua/lspconfig/server_configurations/clangd.lua
					--~/.xdg/data/nvim/lazy/nvim-lspconfig/lua/lspconfig/server_configurations
					-- Navigate to the above file and change line 39 from using BOTH utf-8 and utf-16 to just utf-16,
					-- remove the table brackets and just use "utf-16" as the value.
					-- This is a workaround for:
					-- warning: multiple different client offset encodings
					require("lspconfig").clangd.setup({
						on_attach = function(_, client)
							client.capabilities.offsetEncoding = "utf-16"
							-- client.server_capabilities.hoverProvider = false
							-- client.lsp_signature_help = false
						end,
						capabilities = clangd_capabilities,
						cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },

						-- { "/usr/sbin/clangd", "--background-index", "--offset-encoding=utf-16" }
						-- ||
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
						-- capabilities = {
						-- 	textDocument = {
						-- 		completion = {
						-- 			editsNearCursor = true,
						-- 		},
						-- 	},
						-- 	offsetEncoding = "utf-16",
						-- },
						-- offsetEncoding = { "utf-16" },
						single_file_support = true,
						lsp_binds(),
						-- require("lsp_binds").lsp_binds(),
						-- K.lsp_mappings().setup(),
					}), -- End CLANGD

					--
					--
					--
				}, -- handlers end
			})

			require("mason-nvim-dap").setup({
				ensure_installed = {
					"bash-debug-adapter",
					"chrome-debug-adapter",
					"codelldb",
					"cpptools",
					"debugpy",
					"firefox-debug-adapter",
				},
				handler = {},
			})

			-- require("lspconfig")["bashls"].setup({
			-- 	on_attach = on_attach,
			-- 	filetypes = {
			-- 		"sh",
			-- 		"zsh",
			-- 		"bash",
			-- 	},
			-- })
			lsp_binds()
		end,
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup({
				commented = true,
			})
		end,
	},

	{
		"lvimuser/lsp-inlayhints.nvim",
		opts = {},
	},

	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-lua/plenary.nvim",
			"lvimuser/lsp-inlayhints.nvim",
			{
				"lvimuser/lsp-inlayhints.nvim",
				opts = {},
			},
		},
		ft = { "rust" },
		opts = function()
			-- require("rustaceanvim").setup({})

			local on_attach = function(client, bufnr)
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
				-- client.resolved_capabilities.document_formatting = false
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()

			vim.g.rustaceanvim = {
				tools = {
					hover_actions = {
						auto_focus = true,
					},
					inlay_hints = {
						highlight = "NonText",
					},
				},
				server = {

					on_attach = function(client, bufnr)
						on_attach(client, bufnr)
						capabilities()
						require("lsp-inlayhints").on_attach(client, bufnr)
						require("lsp-inlayhints").show()
						require("dap-ui")
					end,
				},
			}
		end,

		config = function()
			require("rustaceanvim")
			require("lsp-inlayhints")

			local bufnr = vim.api.nvim_get_current_buf()
			local opts = { silent = true, nowait = true, buffer = bufnr }

			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)

			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, opts, { desc = "[d]efinition" })

			vim.keymap.set("n", "gD", function()
				vim.lsp.buf.declaration()
			end, opts, { desc = "[D]eclaration" })

			vim.keymap.set("n", "gr", function()
				vim.lsp.buf.references()
			end, opts, { desc = "[r]eferences" })

			vim.keymap.set("n", "gI", function()
				vim.lsp.buf.implementation()
			end, opts, { desc = "[i]mplementations" })

			vim.keymap.set("n", "gi", function()
				vim.lsp.buf.incoming_calls()
			end, opts, { desc = "[i]ncoming" })

			vim.keymap.set("n", "gt", function()
				vim.lsp.buf.type_definition()
			end, opts, { desc = "[T]ype" })

			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_next()
			end, opts, { desc = "[diag] next" })

			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_prev()
			end, opts, { desc = "[diag] prev" })

			vim.keymap.set("n", "gO", function()
				vim.lsp.buf.outgoing_calls()
			end, opts, { desc = "[O]utgoing" })

			vim.keymap.set("n", "<Leader>lt", ":TodoLocList<CR>", { desc = "list [t]odo's" })

			vim.keymap.set("n", "<C-k>", function()
				vim.lsp.buf.signature_help()
			end, opts, { desc = "Signature Help" })

			vim.keymap.set("n", "<Leader>lr", function()
				vim.lsp.buf.rename()
			end, opts, { desc = "[r]ename" })

			vim.keymap.set({ "n", "v" }, "<Leader>la", function()
				vim.cmd.RustLsp("codeAction")
			end, { silent = true, buffer = bufnr, desc = "[a]ction" })

			vim.keymap.set("n", "<Leader>lf", function()
				vim.lsp.buf.format({ async = true })
			end, opts, { desc = "[f]ormat (lsp)" })

			vim.keymap.set("n", "<Leader>lh", function()
				vim.diagnostic.open_float()
			end, opts, { desc = "[h]over" })

			vim.keymap.set("n", "<Leader>lt", ":TodoLocList<CR>", { desc = "list [t]odo's" })
			-- LSP attach autocmds are called within the autocmds file (group = LspAuGroup)

			-- vim.keymap.set("n", "<Leader>lc", rst.flyCheck, opts, { desc = "[c]heck" })
			-- vim.keymap.set("n", "<Leader>dd", rst.debuggables, opts, { desc = "[d]ebuggables" })
			-- vim.keymap.set("n", "<Leader>dr", rst.runnables, opts, { desc = "[r]unnables" })
			-- vim.keymap.set("n", "<Leader>lh", rst.hover, opts, { desc = "[r]unnables" })

			vim.keymap.set("n", "<Leader>lc", function()
				vim.cmd.RustLsp("flyCheck")
			end, opts, { desc = "[c]heck" })

			vim.keymap.set("n", "<Leader>d", "+[d]ebugging")

			vim.keymap.set("n", "<Leader>dd", function()
				vim.cmd.RustLsp("debuggables")
			end, opts, { desc = "[d]ebuggables" })

			vim.keymap.set("n", "<Leader>dr", function()
				vim.cmd.RustLsp("runnables")
			end, opts, { desc = "[r]un" })

			vim.keymap.set("n", "<Leader>lh", function()
				vim.cmd.RustLsp("hover")
			end, opts, { desc = "[h]over" })
		end,
	},

	-- Dap things here, specific to mason
	-- {
	-- 	"jay-babu/mason-nvim-dap.nvim",
	-- 	event = "BufReadPre",
	-- 	dependencies = {
	-- 		"williamboman/mason.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("mason-nvim-dap").setup({
	-- 			ensure_installed = {
	-- 				"python",
	-- 				"bash",
	-- 				"cppdbg",
	-- 				"codelldb",
	-- 				"chrome",
	-- 			},
	--
	-- 			automatic_installation = {
	-- 				-- exclude = {
	-- 				-- 	"bash",
	-- 				-- 	"chrome",
	-- 				-- 	"cppdbg",
	-- 				-- },
	-- 			},
	-- 			handler = {},
	-- 		})
	-- 	end,
	-- },

	-- clangd_setup = function()
	-- end,
}
