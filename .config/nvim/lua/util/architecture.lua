local M = {}

-- ---@alias OperatingSystem string
local operating_systems = {
	"Windows_NT",
	"Linux",
	"macos",
}

local shells = {
	"zsh",
	"pwsh",
	"powershell",
	"bash",
	"fish",
}

---@return boolean
M.is_windows = function()
	---@type boolean
	local ret_os

	if vim.fn.has(operating_systems[1]) == 1 then
		ret_os = true
	else
		ret_os = false
	end
	return ret_os
end

M.get_os = function()
	local os_t = vim.loop.os_uname().sysname

	---@cast os_t OperatingSystemType
	---@return OperatingSystemType | string | nil
	return assert(os_t, "Operating system not found in list")
end

---@return ShellType
M.get_shell = function()
	---@type ShellType
	local ret_shell

	local os_ver = M.get_os()

	for _, t in ipairs(shells) do
		if os_ver == "Windows_NT" then
			if t == "pwsh" then
				ret_shell = t
			end
		else
			if t == "zsh" then
				ret_shell = t
			end
		end
	end

	---@return ShellType
	return assert(ret_shell, "Shell not found in list")
end

---@param chosen_shell ShellType
M.shell_setup = function(chosen_shell)
	if chosen_shell == shells[1] then
		return
	elseif chosen_shell == shells[2] or chosen_shell == shells[3] then
		-- Check if 'pwsh' is executable and set the shell accordingly

		-- Setting shell command flags
		vim.o.shellcmdflag =
			"-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
		-- Setting shell redirection
		vim.o.shellredir = '2>&1 | %{ "$_" } | Out-File %s; exit $LastExitCode'
		-- Setting shell pipe
		vim.o.shellpipe = '2>&1 | %{ "$_" } | Tee-Object %s; exit $LastExitCode'
		-- Setting shell quote options
		vim.o.shellquote = ""
		vim.o.shellxquote = ""
	end

	---@return Shells
	return assert(chosen_shell, "Shell not set")
end

return M
