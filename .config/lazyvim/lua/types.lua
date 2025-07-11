---@meta

---@alias vim vim
---@alias PathBuf string
---@alias FileName string
---@alias FullPathMap [PathBuf]

---@alias LinuxPathBuf PathBuf
---@alias WindowsPathBuf PathBuf

---@class Types
---@field os_enum_lower fun(): EOperatingSystemEnumLower
---@field os_enum fun(): EOperatingSystemEnum
---@field os_class fun(): OperatingSystems
---@field shells_enum fun(): ShellsTypeEnum
---@field shells_class fun(): Shells
local M = {}

--- A generic type for a table that can be used directly, or called to produce a new table.
--- `any` here is the stand-in for T: table (Thank-you LuaLS)
---@generic T: table
---@class PartiallyApplied<T> : any
---@field __call fun(self: any, desc: string|nil): any

--- Used for the 'mod' function call
--- that creates a partially applied fun()
--- allowing for
--- -@field noremap = true
--- -@field silent = true
--- -@field desc = ?
---
--- With a metatable that can be treated as a table, or a functio
--- to apply the missing desc at a later stage.
---
---@class SilentOpts.Table
---@field noremap boolean
---@field silent boolean
---@field desc? string

---@class SilentOpts
---@field silent_opts SilentOpts.Table

---@class COperatingSystemEnumLower
---@field linux "linux"
---@field windows_nt "windows_nt"
---@field macos "macos"

---@enum EOperatingSystemEnumLower
local OsEnumLower = {
  linux = "linux",
  windows_nt = "windows_nt",
  macos = "macos",
}

M.os_enum_lower = function()
  local os_e_l = OsEnumLower
  return os_e_l
end

---@enum EOperatingSystemEnum
local OsEnum = {
  windows = "Windows_NT",
  linux = "Linux",
  unix = "unix",
  macOS = "macos",
}

M.os_enum = function()
  local os_e = OsEnum
  return os_e
end

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

M.os_class = function()
  M.OsClass = OsClass
  return M.OsClass
end

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

M.shells_enum = function()
  M.ShellsEnum = ShellsEnum
  return M.ShellsEnum
  -- local shell_e = ShellsEnum
  -- return shell_e
end

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

M.shells_class = function()
  M.ShellsClass = ShellsClass
  return M.ShellsClass
  -- local shells_c = ShellsClass
  -- return shells_c
end

return M

-- Enums by default allow you to ref the
-- Structure.KEY, and get the VALUE
--
-- However - if you pass ---@enum (key)
-- You can give the Quoted KEY only, and get the VALUE
