local M = {}
local lsp_server_utils = require("util.lsp_servers")

local home = vim.env.HOME
local zls_exe = home .. "/.zls/zls.exe"
local zig_exe = home .. "/.zig/zig.exe"

return {
	"neovim/nvim-lspconfig",
	-- lazy = false,
	event = "BufReadPre",
	-- "LspAttach",
	dependencies = {
		-- { "nvim-telescope/telescope.nvim", lazy = true },
		{ "folke/neoconf.nvim", cmd = "Neoconf", lazy = true },
		{ "folke/lazydev.nvim" },
		{ "j-hui/fidget.nvim" },
	},

	-- stylua: ignore start
	keys = {
		-- map("gd", vim.lsp.buf.definition, "[G]oto [d]efinition") -- Prefer built-in
		{ "gd", function() require("telescope.builtin").lsp_definitions() end, desc = "[G]oto [d]efinition" },
		{ "gD", function() vim.lsp.buf.declaration() end, "[G]oto [D]eclration" },
		{ "gr", function() require("telescope.builtin").lsp_references() end, desc = "[G]oto [r]eferences" },
		{ "gi", function() require("telescope.builtin").lsp_implementations() end, desc = "[G]oto [I]mpl" },
		{ "gt", function() require("telescope.builtin").lsp_type_definitions() end, desc = "[G]oto [t]ype def" },
		{ "<Leader>ls", function() require("telescope.builtin").lsp_document_symbols() end, desc = "[S]ymbols document" },
		{ "<Leader>lS", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, desc = "[S]ymbol workspace" },
		{ "<Leader>ll", function() require("telescope.builtin").lsp_incoming_calls() end, desc = "ca[l]ls incoming" },
		{ "<Leader>lL", function() require("telescope.builtin").lsp_outgoing_calls() end, desc = "ca[L]ls outgoing" },
		{ "<Leader>lt", function() require("telescope.builtin").treesitter() end, desc = "[T]reesitter symbols" },
		{ "<Leader>ld", function() require("telescope.builtin").diagnostics() end, desc = "[d]iagnostics" },
		{ "<Leader>lr", function() vim.lsp.buf.rename() end, desc = "[r]ename" },
		{ "<Leader>la", function() vim.lsp.buf.code_action() end, desc = "[a]ction" },
		{ "<leader>lI", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
		{ "K", function() vim.lsp.buf.hover() end, desc = "Hoever Docs" },
		{ "<C-k>", vim.lsp.buf.signature_help, "Signature Help" },
		{ "gO", function() require("telescope.builtin").lsp_outgoing_calls() end, desc = "[O]utgoing" },
		{ "<Leader>lh", function() vim.diagnostic.open_float() end, desc = "float", },
		{ "<Leader>lf", function()
				if package.loaded["conform"] then
					-- print("Conform required FROM LSP.lua --- IF")
					require("conform").format()
				elseif package.loaded["conform"] == nil then
					-- print("Conform required FROM LSP.lua --- ELSEIF")
					pcall(require, "conform")
					vim.lsp.buf.format({ async = true })
				end
			end,
			desc = "format [lspconfig]",
		},
	},
	-- stylua: ignore end

	opts = function()
		local servers = lsp_server_utils[1]
		local capabilities = lsp_server_utils[2]
		local mason_lsp = require("mason-lspconfig")
		local mason_tools = require("mason-tool-installer")

		require("configs.mason")

		local ensure_installed_array = vim.tbl_keys(servers) or {}

		local ensure_installed = vim.list_extend(ensure_installed_array, {
			"beautysh",
			"black",
			"clang-format",
			"cmakelang",
			"cmakelint",
			"codelldb",
			"debugpy",
			"delve",
			"fixjson",
			"gopls",
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

		mason_tools.setup({
			ensure_installed = ensure_installed,
		})

		local lsp_config = require("lspconfig")

		-- local servers = lsp_server_utils[1]
		-- local capabilities = lsp_server_utils[2]
		-- local mason_tools = require("mason-tool-installer")
		local plugin_handled = {
			"cmake",
			"gopls",
			"powershell_es",
			"rust_analyzer",
			"tsserver",
			"zig",
		}

		require("lspconfig.ui.windows").default_options.border = "single"
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "single",
		})
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "single",
		})
		vim.lsp.handlers["textDocument/diagnostics_border"] = vim.lsp.with(vim.lsp.handlers.diagnostic, {
			border = "single",
		})

		lsp_config.gleam.setup({})
		lsp_config.zls.setup({
			cmd = { zls_exe },
			capabilities = vim.tbl_deep_extend("force", {}, capabilities or {}),
			settings = {
				zls = {
					zig_exe_path = zig_exe,
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
		})

		return {

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						if server_name == vim.tbl_keys(plugin_handled) then
							return true
						end
					end,

					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities or {})
						lsp_config[server_name].setup(server)
					end,
				},
			}),
			-- Currently isn't included in the mason-lspconfig
			-- }

			vim.diagnostic.config({
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "icons",
				},
				underline = true,
				severity_sort = true,
				signs = true,
				update_in_insert = false,
				float = { border = "single" }, -- This line
				inlay_hints = {
					enabled = true,
				},
				codelens = {
					enabled = true,
				},
				document_highlight = {
					enabled = true,
				},
				--
				capabilities = {
					workspace = {
						fileOperations = {
							didRename = true,
							willRename = true,
						},
					},
				},
			}),
		}
	end,

	config = function(opts)
		return opts
	end,
}

---@diagnostic disable: missing-fields
-- local autocmd = vim.api.nvim_create_autocmd
-- local augroup = vim.api.nvim_create_augroup

-- local function cursor_holds(event)
-- 	local client = vim.lsp.get_client_by_id(event.data.client_id)
-- 	if client and client.server_capabilities.documentHighlightProvider then
-- 		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
-- 			buffer = event.buf,
-- 			callback = vim.lsp.buf.document_highlight,
-- 		})
--
-- 		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
-- 			buffer = event.buf,
-- 			callback = vim.lsp.buf.clear_references,
-- 		})
-- 	end
-- end
--
-- local function lsp_restart_handler(event)
-- 	local lsp_restart = function()
-- 		vim.lsp.stop_client(vim.lsp.get_active_clients())
-- 		vim.cmd([[ LspRestart<CR> ]])
-- 	end
--
-- 	vim.keymap.set("n", "<Leader>l%", function()
-- 		lsp_restart()
-- 	end, { desc = "Restart" })
-- end
