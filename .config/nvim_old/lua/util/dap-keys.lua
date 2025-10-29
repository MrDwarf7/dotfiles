local map = vim.keymap.set

local M = {}

M.dap_binds = function()
	map("n", "<Leader>dc", function()
		require("dap").continue()
	end, { desc = "[c]ontinue" })

	map("n", "<Leader>.", function()
		require("dap").continue()
	end, { desc = "DAP [c]ontinue" })

	map("n", "<Leader>db", function()
		require("dap").toggle_breakpoint()
	end, { desc = "[b]reakpoint" })

	map("n", "<Leader>dC", function()
		require("dap").terminate()
	end, { desc = "[C]ancel" })

	map("n", "<Leader>di", function()
		require("dap").step_into()
	end, { desc = "[i]nto" })

	map("n", "<Leader>do", function()
		require("dap").step_over()
	end, { desc = "[o]ver" })

	map("n", "<Leader>dO", function()
		require("dap").step_out()
	end, { desc = "[O]ut" })

	map("n", "<Leader>dl", function()
		require("dap").run_last()
	end, { desc = "[l]ast" })
end

return M
