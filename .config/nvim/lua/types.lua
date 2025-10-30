--- A generic type for a table that can be used directly, or called to produce a new table.
--- `any` here is the stand-in for T: table (Thank-you LuaLS)
---@generic T: table
---@class PartiallyApplied<T> : any
---@field __call fun(self: any, desc: string|nil): any

---@alias PathBuf string Represents a file system path as a string.
---@alias WindowsPathBuf string Represents a Windows file system path as a string (Different type due to usage of backslashes).
---@alias FullPathMap table<number, PathBuf>
---@alias FileName string Represents a file name as a string.

--- A number with only integer values.
--- May be either positive or negative.
---
---@class Int: number

---
--- A number with only integer values.
--- This class states the number must be unsigned
--- and non-negative. (No `-` sign.).
---
---@class Uint: Int|number

---
--- A number with a decimal point, arbirarily precision cos Lua is Lua.
---
---@class Float: number

--- Message level type for logging/notification levels.
---
---@alias MsgLevel string|integer|vim.log.levels.TRACE|vim.log.levels.DEBUG|vim.log.levels.INFO|vim.log.levels.WARN|vim.log.levels.ERROR|nil

--- A message data type that can be either
--- unknown or a vim.SystemCompleted object.
---
--- * Note: `unknown` here is _not_ 'any'
---
---@class MsgData: unknown|vim.SystemCompleted

--- Represents an error message that can be
--- either a MsgData object, a string, or nil.
---@alias Error MsgData|string|nil

--- Represents an error code that can be
--- a type of system exit or error code/number.
---
--- * Note: this differes from
---@see Error
---
---@alias ErrorCode integer|nil

---@alias ExpectedFsStatType "file"|"directory"|"link"|"socket"|"char"|"block"|"fifo"

-------------------------

---@class Types
---@field LangTablesEnums LangTablesEnums|nil
---@field OsEnums OsEnums|nil
---
---@field setup fun(): Types
local Types = {
  LangTablesEnums = nil,
  OsEnums = nil,
}

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

---@class OsEnums
---@field OsEnumLower EOperatingSystemEnumLower|nil
---@field OsEnum EOperatingSystemEnum|nil
---
---@field setup fun(): OsEnums
local OsEnums = {
  OsEnumLower = nil,
  OsEnum = nil,
}

local has_init_os = false

function OsEnums.setup()
  if has_init_os then
    return OsEnums
  end

  local oe = OsEnums
  oe.OsEnumLower = OsEnumLower
  oe.OsEnum = OsEnum

  has_init_os = true

  return setmetatable(oe, {
    __index = function(_, key)
      error("Attempt to access undefined OsEnums key: " .. tostring(key), 2)
    end,
    __call = function(_, desc)
      return OsEnums.setup()
    end,
  })
end

---@enum TypeOfE
local TypeOfE = {
  linters = "linters",
  formatters = "formatters",
  linter = "linter",
  formatter = "formatter",
}

---@enum CategoryE
local CategoryE = {
  treesitter = "treesitter",
  mason = "mason",
}

---@enum TreeSitterSubtypeE
local TreeSitterSubtypeE = {
  languages = "languages",
  data_formats = "data_formats",
  system = "system",
}

---@enum MasonSubtypeE
local MasonSubtypeE = {
  formatters = "formatters",
  linters = "linters",
  lsps = "lsps",
  daps = "daps",
}

---@enum SubtypeE
local SubtypeE = {
  treesitter = TreeSitterSubtypeE,
  mason = MasonSubtypeE,
  all = "all",
}

---@enum WantsTypeE
local WantsTypeE = {
  all = "all",
  ensure_installed = "ensure_installed",
  disabled = "disabled",
}

---@class LangTablesEnums
---@field TypeOfE? TypeOfE|table
---@field CategoryE? CategoryE|table
---@field TreeSitterSubtypeE? TreeSitterSubtypeE|table
---@field MasonSubtypeE? MasonSubtypeE|table
---@field SubtypeE? SubtypeE|table
---@field WantsTypeE? WantsTypeE|table
---
---@field setup fun(): LangTablesEnums
local LangTablesEnums = {
  TypeOfE = nil,
  CategoryE = nil,
  TreeSitterSubtypeE = nil,
  MasonSubtypeE = nil,
  SubtypeE = nil,
  WantsTypeE = nil,
}

local has_init_lt = false

function LangTablesEnums.setup()
  if has_init_lt then
    return LangTablesEnums
  end

  local lt = LangTablesEnums
  lt.TypeOfE = TypeOfE
  lt.CategoryE = CategoryE
  lt.TreeSitterSubtypeE = TreeSitterSubtypeE
  lt.MasonSubtypeE = MasonSubtypeE

  lt.SubtypeE = SubtypeE
  lt.WantsTypeE = WantsTypeE

  has_init_lt = true

  return setmetatable(lt, {
    __index = function(_, key)
      error("Attempt to access undefined LangTablesEnums key: " .. tostring(key), 2)
    end,
    __call = function(_, desc)
      return LangTablesEnums.setup()
    end,
  })
end

local has_init_types = false

function Types.setup()
  if has_init_types then
    return Types
  end
  local types = Types

  if type(types.LangTablesEnums) ~= "table" then
    types.LangTablesEnums = LangTablesEnums.setup()
  end

  if type(types.OsEnums) ~= "table" then
    types.OsEnums = OsEnums.setup()
  end

  has_init_types = true

  return setmetatable(types, {
    __index = function(_, key)
      if type(types[key]) ~= "nil" then
        error("Attempt to access undefined Types key: " .. tostring(key), 2)
      else
        return types[key]
      end
    end,
    __call = function(_, desc)
      return Types.setup()
    end,
  })
end

---@return Types
return Types.setup()
