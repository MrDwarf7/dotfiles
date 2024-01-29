return {
	"mfussenegger/nvim-dap",
	lazy = false,
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
	},

	config = function()
		local dapui = require("dapui")
		local dap = require("dap")

		vim.keymap.set("n", "<leader>d", "+[d]ebug", { desc = "+[d]ebug" })

		vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "[c]ontinue" })
		vim.keymap.set("n", "<Leader>.", dap.continue, { desc = "[c]ontinue" })
		vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "[b]reakpoint" })
		vim.keymap.set("n", "<Leader>dC", dap.terminate, { desc = "[C]ancel" })

		dap.adapters.python = {
			type = "executable",
			command = os.getenv("HOME") .. "/.config/.pyenv/versions/3.12.1/bin/python3.12",
			args = { "-m", "debugpy.adapter" },
		}

		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = function()
					local cwd = vim.fn.getcwd()
					local python_path = vim.fn.glob(cwd .. "/.venv/bin/python")
					return python_path
				end,
			},
		}

		-- dap.adapters.codelldb = {
		-- 	type = "server",
		-- 	port = "13000",
		-- 	executable = {
		-- 		command = "/usr/sbin/codelldb/adapter/",
		-- 		args = { "--port", "${port}", "--log-file", "/tmp/codelldb.log" },
		-- 		-- detached = false, -- Windows specific
		-- 	},
		-- }

		dap.configurations.rust = {
			{},
			initCommands = function()
				-- Find out where to look for the pretty printer Python module
				local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

				local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
				local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

				local commands = {}
				local file = io.open(commands_file, "r")
				if file then
					for line in file:lines() do
						table.insert(commands, line)
					end
					file:close()
				end
				table.insert(commands, 1, script_import)

				return commands
			end,
		}
		-- DAP UI SPECIFIC

		dapui.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- vim.keymap.set("n", "<Leader>dt", function()
		-- 	dapui.toggle()
		-- end, { desc = "[t]oggle" })

		vim.keymap.set("n", "<Leader>dw", function()
			require("dapui").toggle()
		end, { desc = "[w]indow" })

		vim.keymap.set("n", "<Leader>d[", function()
			require("dapui").open()
		end, { desc = "dap OPEN" })

		vim.keymap.set("n", "<Leader>d]", function()
			require("dapui").close()
		end, { desc = "dap CLOSE" })

		vim.keymap.set("n", "<Leader>di", function()
			require("dapui").StepInto()
		end, { desc = "[i]nto" })

		vim.keymap.set("n", "<Leader>do", function()
			require("dapui").StepOver()
		end, { desc = "[o]ver" })

		vim.keymap.set("n", "<Leader>dO", function()
			require("dapui").StepOut()
		end, { desc = "[O]ut" })

		vim.keymap.set({ "n", "v" }, "<A-k>", function()
			require("dapui").eval()
		end)
	end,
}
