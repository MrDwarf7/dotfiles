local nvim_dap = require("dap")

local M = {}

M.debugpy_adapater = function()
	---@type OperatingSystems
	local os_ver = vim.g.os

	---@type string
	local ret_path

	if vim.g.os == os_ver.windows then
		-- return
		ret_path = os.getenv("USERPROFILE") .. "/scoop/apps/python/current/python.exe"
	elseif vim.g.os == os_ver.unix or vim.g.os == os_ver.linux then
		-- return
		ret_path = os.getenv("HOME") .. "/.config/.pyenv/versions/3.12.1/bin/python3.12"
	end
	return ret_path
end

M.venv_path = function()
	---@type OperatingSystems
	local os_ver = vim.g.os

	---@type string
	local path_set

	if vim.g.os == os_ver.windows then
		path_set = vim.fn.getcwd() .. "/.venv/Scripts/python.exe"
	elseif vim.g.os == os_ver.unix or vim.g.os == os_ver.linux then
		path_set = vim.fn.getcwd() .. "/.venv/bin/python"
	end

	---@return string
	return path_set
end

---@return nil
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
