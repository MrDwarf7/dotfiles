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

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "🛑", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)

		vim.keymap.set("n", "<leader>d", "+[d]ebug", { desc = "+[d]ebug" })
		vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "[c]ontinue" })
		vim.keymap.set("n", "<Leader>.", dap.continue, { desc = "[c]ontinue" })
		vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "[b]reakpoint" })
		vim.keymap.set("n", "<Leader>dC", dap.terminate, { desc = "[C]ancel" })

		vim.keymap.set("n", "<Leader>di", function()
			require("dap").step_into()
		end, { desc = "[i]nto" })

		vim.keymap.set("n", "<Leader>do", function()
			require("dap").step_over()
		end, { desc = "[o]ver" })

		vim.keymap.set("n", "<Leader>dO", function()
			require("dap").step_out()
		end, { desc = "[O]ut" })

		vim.keymap.set("n", "<Leader>dl", function()
			require("dap").run_last()
		end)

		local architechture = function()
			local os_type = function()
				if vim.fn.has("win32") == 1 then
					return "win32"
				end
				if vim.fn.has("unix") == 1 then
					return "unix"
				end
			end
			return os_type()
		end

		local debugpy_adapater = function()
			local arch = architechture()
			if arch == "win32" then
				local os_call = os.getenv("USERPROFILE") .. "/scoop/apps/python/current/python.exe"
				return os_call
			end
			if arch == "unix" then
				local os_call_lin = os.getenv("HOME") .. "/.config/.pyenv/versions/3.12.1/bin/python3.12"
				return os_call_lin
			end
		end

		local path = function()
			local arch = architechture()
			local path_set

			if arch == "win32" then
				local win_venv = vim.fn.getcwd() .. "/.venv/Scripts/python.exe"
				path_set = win_venv
			end
			if arch == "unix" then
				local lin_venv = vim.fn.getcwd() .. "/.venv/bin/python"
				path_set = lin_venv
			end
			return path_set
		end

		dap.adapters.python = {
			type = "executable",
			command = debugpy_adapater(),
			args = { "-m", "debugpy.adapter" },
		}

		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = function()
					local python_path = path()
					return python_path
				end,
			},
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

		vim.keymap.set("n", "<Leader>dw", function()
			require("dapui").toggle()
		end, { desc = "[w]indow" })

		vim.keymap.set("n", "<Leader>d[", function()
			require("dapui").open()
		end, { desc = "dap OPEN" })

		vim.keymap.set("n", "<Leader>d]", function()
			require("dapui").close()
		end, { desc = "dap CLOSE" })

		vim.keymap.set("n", "<Leader>dz", function()
			require("dapui").open({ reset = true })
		end, { desc = "[z]reset ui" })

		vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
			require("dap.ui.widgets").hover()
		end, { desc = "[hover" })

		vim.keymap.set({ "n", "v" }, "<Leader>de", function()
			require("dapui").eval()
		end, { desc = "[e]val" })

		vim.keymap.set("n", "<Leader>df", function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.frames)
		end, { desc = "[f]rames" })

		vim.keymap.set("n", "<Leader>ds", function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.scopes)
		end, { desc = "[s]copes" })

		vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
			require("dap.ui.widgets").preview()
		end, { desc = "[p]review" })
	end,
}
