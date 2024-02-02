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
			local utils = require("utils")
			local on_attach = utils.on_attach("omnifunc", "vim:lua.vim.lsp.omnifunc")

			require("mason").setup({
				ui = {
					border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
					icons = {
						package_pending = " ",
						package_installed = "󰄳 ",
						package_uninstalled = " 󰚌",
					},
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
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
				}, -- handlers end
			})

			-- require("lspconfig")["bashls"].setup({
			-- 	on_attach = on_attach,
			-- 	filetypes = {
			-- 		"sh",
			-- 		"zsh",
			-- 		"bash",
			-- 	},
			-- })



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
			"lvimuser/lsp-inlayhints.nvim",
		},
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				inlay_hints = {
					highlight = "NonText",
				},
				tools = {
					hover_actions = {
						auto_focus = true,
					},
				},
				server = {
					on_attach = function(client, bufnr)
						require("lsp-inlayhints").on_attach(client, bufnr)
						require("dap-ui")
					end,
				},
			}
			local rst = package.loaded.rustaceanvim

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


			vim.keymap.set("n", "<Leader>lc", rst.flyCheck, opts, { desc = "[c]heck" })
			vim.keymap.set("n", "<Leader>dd", rst.debuggables, opts, { desc = "[d]ebuggables" })
			vim.keymap.set("n", "<Leader>dr", rst.runnables, opts, { desc = "[r]unnables" })
			vim.keymap.set("n", "<Leader>lh", rst.hover, opts, { desc = "[r]unnables" })





			vim.keymap.set("n", "<Leader>lc", function()
				vim.cmd.RustLsp("flyCheck")
			end, opts, { desc = "[c]heck" })

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
}
