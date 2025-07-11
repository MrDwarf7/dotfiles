local types = require("types")

---@class Arch
---@field get_os fun(): EOperatingSystemEnum
---@field get_os_lower fun(): EOperatingSystemEnumLower
local M = {}

--- Gets the current operating system as a type of OperatingSystemEnum
---@return EOperatingSystemEnum
M.get_os = function()
	---@type EOperatingSystemEnum
	return assert(vim.loop.os_uname().sysname, "Operating system not found in list")
end

--- Returns the current operating system.
--- return value is always lowercased.
---@return EOperatingSystemEnumLower
M.get_os_lower = function()
	return assert(string.lower(vim.g.os or vim.loop.os_uname().sysname), "Operating system not found in list") --[[@as EOperatingSystemEnumLower]]
end

---@type OperatingSystems
local os_type = types.os_class()

M.OsType = nil

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

---@class Architecture
---@field OsClass OperatingSystems
---@field ShellsEnum ShellsTypeEnum
---@field ShellsClass Shells
---@field ValidShell ShellsTypeEnum

-- setmetatable(M, {
-- 	__call = function(m, ...)
-- 		return m.maybe_dev(...)
-- 	end,
-- })

--- Convert any value to a string and lower case
---@param str any
---@return string
M.lower_str = function(str)
	return string.format("%s", str):lower()
end

--- Check if the HOME_PROFILE environment variable is set to true
---@return boolean
M.home_check = function()
	M.HomeCheck = nil
	M.GetEnvValue = nil

	local h = M.lower_str(M.lower_str(os.getenv("HOME_PROFILE")))
	M.GetEnvValue = h
	-- lower_str(lower_str(os.getenv("HOME_PROFILE"))) -- is true if the env variable HOME_PROFILE is set as true, everything else is automatically false
	if not M.GetEnvValue then
		M.HomeCheck = false
		return false
	else
		M.HomeCheck = true or nil
		return true
	end
end

--- Check if the system is Windows
---@return boolean
M.is_windows = function()
	-- M.IsWindows = nil
	if M.get_os() == os_type.windows then
		return true
	else
		return false
	end
end

--- Universal function to handle checking if
--- the system is Windows && if the HOME_PROFILE env variable is set to true
---@return boolean
M.should_load = function()
	-- Cache IsWindows check
	local win = M.is_windows()
	local home = M.home_check()

	if win then
		return home -- returns a bool, true if the env variable HOME_PROFILE is set as true
		-- M.home_check()
	else -- Linux system, always disable Avante on linux systems
		return false
	end
end

---
---@param os_name EOperatingSystemEnum
---@return ShellsTypeEnum | string
M.get_shell = function(os_name)
	M.ValidShell = nil
	if os_name == os_type.windows then
		M.ValidShell = shells_t.pwsh or shells_t.powershell
		return shells_t.pwsh
	elseif os_name == os_type.linux then
		M.ValidShell = shells_t.bash
		return shells_t.zsh
	else
		M.ValidShell = shells_t.bash
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
