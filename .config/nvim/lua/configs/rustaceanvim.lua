return {
	"mrcjkb/rustaceanvim",
	-- lazy = false,
	version = "^4",
	ft = { "rust" },
	-- event = { "LspAttach" },
	config = function()
		vim.g.rustaceanvim = {
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
				on_attach = function(_, _)
					pcall(require, "dap-ui")

					local bufnr = vim.api.nvim_get_current_buf()

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

					vim.lsp.inlay_hint.enable()
				end,

				default_settings = {
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
	end,
}

-- return M
