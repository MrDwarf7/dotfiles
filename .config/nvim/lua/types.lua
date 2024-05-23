local M = {}

---@class LspAttach Event
---
---@class Event
---@field buf number
---@field data table

-----@alias Windows "Windows_NT"
-----@alias Linux "Linux"
-----@alias Unix "unix"
-----@alias MacOS "macos"

---@enum OperatingSystemEnum
local OsEnum = {
	windows = "Windows_NT",
	linux = "Linux",
	unix = "unix",
	macOS = "macos",
}

M.os_enum = OsEnum

---@class (exact) OperatingSystems
---@field windows "Windows_NT
---@field linux "Linux"
---@field unix "unix
---@field macos "macos

---@type OperatingSystems
local OsClass = {
	windows = "Windows_NT",
	unix = "unix",
	linux = "Linux",
	macos = "macos",
}

M.os_class = OsClass

----- Os stuff done

----@alias Bash "bash"
----@alias Fish "fish"
----@alias Powershell "powershell.exe"
----@alias Pwsh "pwsh.exe"
----@alias Zsh "zsh"

---@enum ShellsTypeEnum
local ShellsEnum = {
	bash = "bash",
	fish = "fish",
	powershell = "powershell",
	pwsh = "pwsh",
	zsh = "zsh",
}

M.shells_enum = ShellsEnum

---@class (exact) Shells
---@field bash "bash"
---@field fish "fish"
---@field powershell "powershell"
---@field pwsh "pwsh.exe"
---@field zsh "zsh"

---@type Shells
local ShellsClass = {
	bash = "bash",
	fish = "fish",
	powershell = "powershell",
	pwsh = "pwsh.exe",
	zsh = "zsh",
}

M.shells_class = ShellsClass

return M

-- Enums by default allow you to ref the
-- Structure.KEY, and get the VALUE
--
-- However - if you pass ---@enum (key)
-- You can give the Quoted KEY only, and get the VALUE
