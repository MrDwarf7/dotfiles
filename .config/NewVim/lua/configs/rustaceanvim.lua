local cmd = vim.cmd
local set_map = vim.keymap.set

local M = {}

M.rustacean_vim_attach = function(event)
	local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "RUST: " .. desc })
	end


	map("<Leader>lf", function()
		vim.lsp.buf.format({ async = true })
	end, "format")

	map("<Leader>ll", function()
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


M.rustaceanvim_setup = function()
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
				autoSetHints = true,
				auto = true,
				highlight = "NonText",
			},
		},
		server = {
			on_attach = function(client, bufnr)
				M.rustacean_vim_attach(client)

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

		dap = {
			adapter = {
				command = "lldb-vscode",
				name = "lldb",
				type = "executable",
			},
			configuration = {
				args = {},
				cwd = vim.fn.getcwd(),
				env = {},
				externalConsole = false,
				MIMode = "gdb",
				name = "lldb",
				program = "${file}",
				request = "launch",
				stopOnEntry = true,
				type = "lldb",
				setupCommands = {
					{
						description = "Enable pretty-printing for gdb",
						ignoreFailures = true,
						text = "-enable-pretty-printing",
					},
				},
				sourceLanguages = { "rust" },
			},
		},
	}
end

return M
