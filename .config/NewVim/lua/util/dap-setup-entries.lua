local nvim_dap = require("dap")

local M = {}

M.debugpy_adapater = function()
	if vim.g.os == "win32" then
		local os_call = os.getenv("USERPROFILE") .. "/scoop/apps/python/current/python.exe"
		return os_call
	elseif vim.g.os == "unix" then
		local os_call_lin = os.getenv("HOME") .. "/.config/.pyenv/versions/3.12.1/bin/python3.12"
		return os_call_lin
	end
end

M.venv_path = function()
	local path_set
	if vim.g.os == "win32" then
		local win_venv = vim.fn.getcwd() .. "/.venv/Scripts/python.exe"
		path_set = win_venv
	elseif vim.g.os == "unix" then
		local lin_venv = vim.fn.getcwd() .. "/.venv/bin/python"
		path_set = lin_venv
	end
	return path_set
end

M.dap_entries_configs = function()
	-- print("This is the 'dap enntries file'")
	nvim_dap.adapters.python = {
		type = "executable",
		command = M.debugpy_adapater(),
		args = { "-m", "debugpy.adapter" },
	}

	nvim_dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			pythonPath = function()
				local python_path = M.venv_path()
				return python_path
			end,
		},
	}
end

return M
