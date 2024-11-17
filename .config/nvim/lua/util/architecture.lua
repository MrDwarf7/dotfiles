local M = {}

local types = require("types")

---@type OperatingSystems
local os_type = types.os_class()

---@type Shells
local shells_t = types.shells_class()

----@type OperatingSystem
-- local operating_systems = {
-- 	windows = "Windows_NT",
-- 	linux = "Linux",
-- 	macos = "macos",
-- }

----@type ShellType
-- local shells = {
-- 	zsh = "zsh",
-- 	pwsh = "pwsh",
-- 	powershell = "powershell",
-- 	bash = "bash",
-- 	fish = "fish",
-- }

---@return boolean
M.is_windows = function()
	if vim.fn.has(os_type.windows) == 1 then
		return true
	else
		return false
	end
end

---
---@return OperatingSystemEnum
M.get_os = function()
	---@type OperatingSystemEnum
	local os_t = vim.loop.os_uname().sysname
	return assert(os_t, "Operating system not found in list")
end

---
---@param os_name OperatingSystemEnum
---@return ShellsTypeEnum | string
M.get_shell = function(os_name)
	if os_name == os_type.windows then
		return shells_t.pwsh
	elseif os_name == os_type.linux then
		return shells_t.zsh
	else
		return shells_t.bash
	end
end

---
---@param chosen_shell ShellsTypeEnum
---@return ShellsTypeEnum?
M.shell_setup = function(chosen_shell)
	if chosen_shell == shells_t.zsh then
		return
	end
	if chosen_shell == (shells_t.pwsh or chosen_shell == shells_t.powershell) then
		-- Check if 'pwsh' is executable and set the shell accordingly

		-- Setting shell command flags
		vim.o.shellcmdflag =
			"-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
		-- Setting shell redirection
		vim.o.shellredir = '2>&1 | %{ "$_" } | Out-File %s; exit $LastExitCode'
		-- Setting shell pipe
		vim.o.shellpipe = '2>&1 | %{ "$_" } | Tee-Object %s; exit $LastExitCode'
		-- Setting shell quote options
		vim.o.shellquote = ""
		vim.o.shellxquote = ""

		-- vim.opt.shellcmdflag =
		-- 	"-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
		-- vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
		-- vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
		-- vim.opt.shellquote = ""
		-- vim.opt.shellxquote = ""

		return chosen_shell
	end
	return chosen_shell
end

return M
