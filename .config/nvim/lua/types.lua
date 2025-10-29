---@meta

---@class EOperatingSystemEnumLower
local OsEnumLower = {
  linux = "linux",
  windows_nt = "windows_nt",
  macos = "macos",
}

---@class EOperatingSystemEnum
local OsEnum = {
  windows = "Windows_NT",
  linux = "Linux",
  unix = "unix",
  macOS = "macos",
}


--- A generic type for a table that can be used directly, or called to produce a new table.
--- `any` here is the stand-in for T: table (Thank-you LuaLS)
---@generic T: table
---@class PartiallyApplied<T> : any
---@field __call fun(self: any, desc: string|nil): any

