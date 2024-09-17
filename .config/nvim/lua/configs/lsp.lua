-- local M = {}
-- local lsp_server_utils = require("util.lsp_servers")
-- local lsp_config = require("lspconfig")
-- local servers = lsp_server_utils[1]
-- local capabilities = lsp_server_utils[2]

-- local telescope_builtin = require("telescope.builtin")

return {
	"neovim/nvim-lspconfig",
	-- lazy = false,
	event = "BufReadPre",
	-- "LspAttach",
	dependencies = {
		-- { "nvim-telescope/telescope.nvim", lazy = true },
		{ "folke/neoconf.nvim", cmd = "Neoconf", lazy = true },
		{ "folke/lazydev.nvim", lazy = true },
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

	opts = function(_, opts)
		local servers = require("util.lsp_servers")[1]
		local capabilities = require("util.lsp_servers")[2]

		local ensure_installed = vim.list_extend(vim.tbl_keys(servers) or {}, {
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

		opts.mason_tools = {
			ensure_installed = ensure_installed,
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
				function(server_name)
					if server_name == vim.tbl_keys(opts.plugin_handled) then
						return true
					end
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		}

		opts.diagnostic_config = {
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

		require("configs.mason")
		vim.diagnostic.config(opts.diagnostic_config)
		require("mason-tool-installer").setup(opts.mason_tools or {})
		require("mason-lspconfig").setup(opts.mason_lsp_config)
	end,
}
