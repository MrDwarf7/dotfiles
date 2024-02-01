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
						require("lspconfig")[server_name].setup({
						})
					end,
				}, -- handlers end
			})

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
		-- dependencies = {
		-- 	"nvim-lua/plenary.nvim",
		-- 	"mfussenegger/nvim-dap",
		-- },
		ft = { "rust" },
	},

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

		local bufnr = vim.api.nvim_get_current_buf()
		vim.keymap.set("n", "<Leader>la", function()
			vim.cmd.RustLsp("codeAction")
		end, { silent = true, buffer = bufnr, desc = "[a]ction" })

		vim.keymap.set("n", "<Leader>lc", function()
			vim.cmd.RustLsp("flyCheck")
		end, { silent = true, buffer = bufnr, desc = "[c]heck" })

		vim.keymap.set("n", "<Leader>dd", function()
			vim.cmd.RustLsp("debuggables")
		end, { silent = true, buffer = bufnr, desc = "[d]ebuggables" })

		vim.keymap.set("n", "<Leader>dr", function()
			vim.cmd.RustLsp("runnables")
		end, { silent = true, buffer = bufnr, desc = "[r]un" })

		vim.keymap.set("n", "<Leader>lh", function()
			vim.cmd.RustLsp("hover")
		end, { silent = true, buffer = bufnr, desc = "[h]over" })
	end,
}

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
-- }
