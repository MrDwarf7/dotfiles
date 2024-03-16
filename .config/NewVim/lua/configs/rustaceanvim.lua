local cmd = vim.cmd
local set_map = vim.keymap.set

local M = {}

local rustacean_vim_attach = function(event)
	local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
	end

	map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [d]efinition")
	map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclration")

	map("gr", require("telescope.builtin").lsp_references, "[G]oto [r]eferences")
	map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mpl")
	map("gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [t]ype def")

	map("<Leader>ls", require("telescope.builtin").lsp_document_symbols, "[S]ymbols document")
	map("<Leader>lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[S]ymbol workspace")
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
		-- if pcall(require, "conform") then
		-- 	print("pcall on conform -> return")
		-- 	return
		-- else
		vim.lsp.buf.format({ async = true })
		-- end
	end, "format")

	map("<Leader>lc", function()
		cmd.RustLsp("flyCheck")
	end, "[c]heck")

	map("<Leader>dd", function()
		cmd.RustLsp("debuggables")
	end, "[d]ebuggables")

	map("<Leader>dr", function()
		cmd.RustLsp("runnables")
	end, "[r]un")

	map("<Leader>lh", function()
		cmd.RustLsp("hover")
	end, "[h]over")
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

M.rustaceanvim_setup = function()
	-- local lsp_mappings = require("util.lsp-mappings")
	-- local buffer = require("util.buffer")
	-- local lsp_capabilities = require("util.lsp-capabilities")

	if vim.opt.diff:get() then
		cmd([[LspStop]])
		return
	end

	vim.g.rustaceanvim = {
		tools = {
			hover_actions = {
				auto_focus = true,
			},
			inlay_hints = {
				highlight = "NonText",
				autoSetHints = true,
				auto = true,
			},
		},
		server = {
			on_attach = function(client, bufnr)
				rustacean_vim_attach(client)

				require("lsp-inlayhints").on_attach(client, bufnr)
				require("lsp-inlayhints").show()
				pcall(require, "dap-ui")

				-- local opts = { buffer = true, bufnr = bufnr }
				-- lsp_mappings.lsp_binds(opts)

				if client.resolved_capabilities.document_formatting then
					set_map("n", "<Leader>lf", function()
						cmd.RustLsp("format")
					end, { desc = "[f]ormat" })
				end

				if client.resolved_capabilities.document_range_formatting then
					set_map("x", "<Leader>lf", function()
						cmd.RustLsp("format")
					end, { desc = "[f]ormat" })
				end

				vim.lsp.inlay_hint.enable(bufnr)
			end,

			-- capabilities = capabilities,
			default_settings = {
				["rust-analyzer"] = {
					inlay_hints = {
						typeHints = true,
						-- parameterHints = true,
						bindingHints = true,
						chainingHints = true,
						closingBraceHints = true,
						closureCaptureHints = true,
						closureReturnTypeHints = true,
						closureStyle = "rust_analyzer",
						discriminationHints = true,
						expressionAdjustmentHints = true,
						mutableBorrowHints = true,
						implicitDrops = true,
						-- lifetimeEllisionHints = true,
						lifetimeEllisionHints = {
							enable = true,
							useParamaterNames = true,
						},
						parameterHints = {
							enable = true,
						},
						rangeExclusiveHints = {
							enable = true,
						},

						maxLength = 120,
						align = true,
						prefix = " » ",
						highlight = "Comment",
					},
				},
			},
		},

		dap = {
			adapter = {
				type = "executable",
				command = "lldb-vscode",
				name = "lldb",
			},
			configuration = {
				name = "lldb",
				type = "lldb",
				request = "launch",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				stopOnEntry = true,
				args = {},
				env = {},
				externalConsole = false,
				MIMode = "gdb",
				setupCommands = {
					{
						description = "Enable pretty-printing for gdb",
						text = "-enable-pretty-printing",
						ignoreFailures = true,
					},
				},
				sourceLanguages = { "rust" },
			},
		},
	}
end

return M
