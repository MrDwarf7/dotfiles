---@meta
---Generic types and general types that don't belong to any specific area

---@alias PathBuf string Represents a file system path as a string.
---@alias WindowsPathBuf string Represents a Windows file system path as a string (Different type due to usage of backslashes).
---@alias FullPathMap table<number, PathBuf>
---@alias FileName string Represents a file name as a string.

--- A number with only integer values.
--- May be either positive or negative.
---
---@class Int: number

--- A standin for nil
---@class Void: nil

--- Wrapper around concrete void type
---@alias void Void|nil

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

---@generic T
---@generic V
---@class GettableTable
---@field get fun(key: any): T
---@field verify fun(key: any): V
