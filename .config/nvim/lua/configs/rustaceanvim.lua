local cmd = vim.cmd

-- 	config = function()
-- 		require("configs.rustaceanvim").rustaceanvim_setup()
-- 	end,
-- },

-- local M = {}

return {
	"mrcjkb/rustaceanvim",
	-- lazy = false,
	version = "^4",
	ft = { "rust" },
	config = function()
		-- rustaceanvim_setup = function()
		-- 	if vim.opt.diff:get() then
		-- 		cmd([[LspStop]])
		-- 		return
		-- 	end

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
					vim.lsp.inlay_hint.enable()
				end,

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
	end,
}

-- return M
