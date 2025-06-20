-- local M = {}
-- local lsp_server_utils = require("util.lsp_servers")
-- local lsp_config = require("lspconfig")
-- local servers = lsp_server_utils[1]
-- local capabilities = lsp_server_utils[2]

-- local telescope_builtin = require("telescope.builtin")

--- LSP Keymaps / binds
---@return table
local function lsp_maps()
	-- stylua: ignore start
	return {
		-- map("gd", vim.lsp.buf.definition, "[G]oto [d]efinition") -- Prefer built-in
		{ "gd", function() return require("telescope.builtin").lsp_definitions() end, desc = "[G]oto [d]efinition" },
		{ "gD", function() return vim.lsp.buf.declaration() end, "[G]oto [D]eclration" },
		{ "gr", function() return require("telescope.builtin").lsp_references() end, desc = "[G]oto [r]eferences" },
		{ "gi", function() return require("telescope.builtin").lsp_implementations() end, desc = "[G]oto [I]mpl" },
		{ "gt", function() return require("telescope.builtin").lsp_type_definitions() end, desc = "[G]oto [t]ype def" },
		{ "<Leader>ls", function() return require("telescope.builtin").lsp_document_symbols() end, desc = "[S]ymbols document" },
		{ "<Leader>lS", function() return require("telescope.builtin").lsp_dynamic_workspace_symbols() end, desc = "[S]ymbol workspace" },
		{ "<Leader>ll", function() return require("telescope.builtin").lsp_incoming_calls() end, desc = "ca[l]ls incoming" },
		{ "<Leader>lL", function() return require("telescope.builtin").lsp_outgoing_calls() end, desc = "ca[L]ls outgoing" },
		{ "<Leader>lt", function() return require("telescope.builtin").treesitter() end, desc = "[T]reesitter symbols" },
		{ "<Leader>ld", function() return require("telescope.builtin").diagnostics() end, desc = "[d]iagnostics" },
		{ "<Leader>lr", function() return vim.lsp.buf.rename() end, desc = "[r]ename" },
		{ "<Leader>la", function() return vim.lsp.buf.code_action() end, desc = "[a]ction" },
		{ "<leader>lI", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
		{ "K", function() return vim.lsp.buf.hover() end, desc = "Hoever Docs" },
		{ "<C-k>", vim.lsp.buf.signature_help, "Signature Help" },
		{ "gO", function() return require("telescope.builtin").lsp_outgoing_calls() end, desc = "[O]utgoing" },
		{ "<Leader>lh", function() return vim.diagnostic.open_float() end, desc = "float", },
		{ "<Leader>lf", function()
				if package.loaded["conform"] then
					return require("conform").format()
				elseif package.loaded["conform"] == nil then
					pcall(require, "conform")
				return vim.lsp.buf.format({ async = true })
				end
			end,
			desc = "format [lspconfig]",
		}
	}
end

return {
	"neovim/nvim-lspconfig",
	lazy = true,
	event = "BufReadPre",
	-- "LspAttach",
	dependencies = {
		-- { "nvim-telescope/telescope.nvim", lazy = true },
		{ "folke/neoconf.nvim", cmd = "Neoconf", lazy = true },
		{ "folke/lazydev.nvim", lazy = true },
		{ "j-hui/fidget.nvim", event = "VeryLazy" },
	},

	keys = lsp_maps(),
	opts = function(_, opts)
		-- local servers = require("util.lsp_servers")[1]
		-- local capabilities = require("util.lsp_servers")[2]
		local servers_file = require("util.lsp_servers")
		local servers = servers_file()
		local capabilities = require("util.lsp_servers").capabilities()

		opts.mason_tools = {
			ensure_installed = servers_file:extend_list({
				"beautysh",
				"black",
				"cbfmt",
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
				--"markdown_oxide",
				-- "mdsf",
				"mdslw",
				"mypy",
				"prettier",
				"ruff",
				"shfmt",
				"stylua",
				"sqlfluff",
				"sql-formatter",
				"ts-standard",
				"vulture",
				"yamlfmt",
				"csharpier",
			}),
		}

		opts.plugin_handled = {
			"cmake",
			"gopls",
			"powershell_es",
			"rust_analyzer",
			"tsserver",
			"zig",
		}

		opts.mason_lsp_config = {
			handlers = {
				function(server_name) ---@param server_name string | table
					if server_name == vim.tbl_keys(opts.plugin_handled) then
						return true
					end
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities or {})
					assert(server, "Server not found") -- Catches if server is nil, will also provide the name for depr. server(s)
					require("lspconfig")[server_name].setup(server)
				end,
			},
			-- NEW :: 2025_06_01
			ensure_installed = servers,
			automatic_enable = {
				exclude = opts.plugin_handled,
			},
		}

		opts.diagnostic_config = {
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "",
			},
			underline = true,
			severity_sort = true,
			update_in_insert = false,
			signs = true,
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
		}

		return opts
	end,

	config = function(_, opts)
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
		-- require("configs.mason")
		vim.diagnostic.config(opts.diagnostic_config)

		require("mason-tool-installer").setup(opts.mason_tools)
		require("mason-lspconfig").setup(opts.mason_lsp_config)
	end,
}
