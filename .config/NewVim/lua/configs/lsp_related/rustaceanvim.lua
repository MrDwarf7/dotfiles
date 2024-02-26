local cmd = vim.cmd
local map = vim.keymap.set

local M = {}

M.rustaceanvim_setup = function()
	local lsp_mappings = require("util.lsp-mappings")
	local buffer = require("util.buffer")
	local lsp_capabilities = require("util.lsp-capabilities")

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
			on_attach = function(client, attach_buffer)
				local bufnr = vim.api.nvim_get_current_buf()
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
				-- local capabilities_call = lsp_capabilities.capabilities

				require("lsp-inlayhints").on_attach(client, attach_buffer)
				require("lsp-inlayhints").show()
				pcall(require, "dap-ui")

				local opts = { buffer = true, bufnr = bufnr }
				lsp_mappings.lsp_binds(opts)

				if client.resolved_capabilities.document_formatting then
					map("n", "<Leader>lf", function()
						cmd.RustLsp("format")
					end, opts, { desc = "[f]ormat" })
				end

				if client.resolved_capabilities.document_range_formatting then
					map("x", "<Leader>lf", function()
						cmd.RustLsp("format")
					end, opts, { desc = "[f]ormat" })
				end
			end,
			capabilities = lsp_capabilities.default_capabilities(),
			default_settings = {
				["rust-analyzer"] = {
					inlay_hints = {
						typeHints = true,
						parameterHints = true,
						chainingHints = true,
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

local opts = { buffer = vim.api.nvim_get_current_buf() }
map("n", "<Leader>lc", function()
	cmd.RustLsp("flyCheck")
end, opts, { desc = "[c]heck" })
map("n", "<Leader>dd", function()
	cmd.RustLsp("debuggables")
end, opts, { desc = "[d]ebuggables" })
map("n", "<Leader>dr", function()
	cmd.RustLsp("runnables")
end, opts, { desc = "[r]un" })
map("n", "<Leader>lh", function()
	cmd.RustLsp("hover")
end, opts, { desc = "[h]over" })

return M
