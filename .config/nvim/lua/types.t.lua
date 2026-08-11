---@meta
---Generic types and general types that don't belong to any specific area

---@alias WindowsPathBuf string Represents a Windows file system path as a string (Different type due to usage of backslashes).
---@alias FullPathMap table<number, PathBuf>
---@alias FileName string Represents a file name as a string.

--- A number with only integer values.
--- May be either positive or negative.
---
---@class Int: number

-- --- A standin for nil
-- ---@class Void: nil
--
-- --- Wrapper around concrete void type
-- ---@alias void Void|nil

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
-- ---@alias Error MsgData|string|nil

--- Represents an error code that can be
--- a type of system exit or error code/number.
---
--- * Note: this differes from
---@see Error
---
---@alias ErrorCode integer|nil

---@alias ExpectedFsStatType "file"|"directory"|"link"|"socket"|"char"|"block"|"fifo"

---@generic K
---@generic T
---@generic V
---@class GettableTable : table<K, V>
---@field get fun(key: any): T
---@field verify fun(key: any): V

-- Unique case for 'void' :: 'nil'
-- because nil is treated differently in Lua
-- and we want to be explicit about it in our type system.
-- But we are forced to alias instead of creating a new type
-- because Lua.

---@alias void nil
local __void = {}

---@class bool : boolean
local __bool = {}
---@class int : integer
local __int = {}
---@class float : number
local __float = {}
---@class str : string
local __str = {}

-- TODO: [types] : Actually figure out a way to implement this a little better than just a
-- table with a metatable.
-- The problem is that Lua's type system is not expressive enough to represent union types directly,
-- so we have to use a workaround.
-- The current implementation is a placeholder and does not enforce the union type constraint at runtime.

-- --- Represents a union type of two types K and V.
-- --- A table-like object that may have EITHER a key of type K OR type V, but not both simultaneously.
-- --- You may use this as a list-like object (array) or a map-like object (dictionary),
-- --- but not both at the same time.
-- --- Example:
-- --- ```lua
-- --- ---@type union<int, str>
-- --- local my_union = { env = "HOST", fd = 1 } -- valid, but not both at the same time
-- -- for k, v in pairs(my_union) do
-- --   if type(k) == "number" then
-- --     print("Key is a number: " .. k)
-- --   elseif type(k) == "string" then
-- --     print("Key is a string: " .. k)
-- --   else
-- --     print("Key is of unknown type: " .. type(k))
-- --   end
-- -- end
-- -- ```
-- --- The above example demonstrates how to use the `union` type to create a table that can have
-- --- EITHER an integer key or a string key, but not both at the same time. The type system will enforce this constraint, ensuring that you cannot have both types of keys in the same table.
-- ---
-- ---
-- ---@generic K : Index
-- ---@generic A : OfAnyOrNil
-- ---@class union<K, A> : table<union<K, A>, table<Index, A>>
-- local __union = {}
--
-- ---@generic T : OfAnyOrNil
-- ---@class Unique<T> : [T]

--- Represents a type used for indexing tables.
--- It can be a number, string, or any type that can be used as a key in a table.
---@class Index : AnyNum|Str|OfAnyOrNil
local __Index = {}

--- Represents a table that can be indexed by an Index type and returns a value of any type or nil.
---@class Indexable : table<Index, OfAnyOrNil>
local __Indexable = {}

--- Represents a filesystem path, e.g. "/home/user/.config/hypr" or "/usr/bin/hl".
--- This is a REFERENCE type (not owned). Use PathBuf for an owned path.
---@class Path : string
local __Path = {}

--- Represents a filesystem path, e.g. "/home/user/.config/hypr" or "/usr/bin/hl".
--- This is an OWNED type (not a reference). Use Path for a reference path.
---@class PathBuf : Path|string
local __PathBuf = {}

--- Represents a Lua module path, e.g. "foo.bar.baz" or "foo.bar.baz.qux".
--- This is a REFERENCE type (not owned). Use LuaPathBuf for an owned Lua module path.
---@class LuaPath : Path|PathBuf|string
local __LuaPath = {}

--- Represents a Lua module path, e.g. "foo.bar.baz" or "foo.bar.baz.qux".
--- This is an OWNED type (not a reference). Use LuaPath for a reference Lua module path.
---@class LuaPathBuf : PathBuf|LuaPath|string
local __LuaPathBuf = {}

--- Represents an aggregate of Path-like types (Path, PathBuf, LuaPath, LuaPathBuf).
---@generic P : Path|PathBuf|LuaPath|LuaPathBuf|string
---@class PathLike : P

--- Represents a filesystem directory path, e.g. "/home/user/.config/hypr" or "/usr/bin/hl".
--- This must NEVER have a trailing slash.
--- This is a REFERENCE type (not owned). Use DirPath for an owned directory path.
---@class DirPath : Path
local __DirPath = {}

--- Represents a filesystem directory path, e.g. "/home/user/.config/hypr" or "/usr/bin/hl".
--- This must NEVER have a trailing slash.
--- Ths is an OWNED type (not a reference). Use Dir for a reference directory path.
---@class DirPathBuf : PathBuf
local __DirPathBuf = {}

--- Represents an aggregate of directory path-like types (DirPath, DirPathBuf).
---@generic D : DirPath|DirPathBuf
---@class DirLike<D> : D

--- Represents the older generation of configuration files, e.g. "/home/user/.config/hypr/programs.conf".
--- This is mostly deprecated in favor of Lua modules, but is still supported for legacy configs.
---@deprecated This used to be a PathBuf, but is now a LuaPathBuf.
--- Use LuaPathBuf for new configs.
---@class ConfFile : PathBuf
local __ConfFile = {}

---@generic S : str
--- Represents a string type that contains a known set of values.
--- This is useful for documenting intent and providing type safety in Lua code.
---@class Str<S> : S

---@generic N : float|integer|number|any
---@class AnyNum<N> : N
local __AnyNum = {}

---@generic I : AnyNum<I>
---@generic N : OfAnyOrNil
---@class Vec<I, N>
local __Vec = {}

---@generic N : AnyNum<N>
---@class Vec2<N> : { [1]: N, [2]: N }
local __Vec2 = {}

---@generic N : AnyNum<N>
---@class Vec3<N> : { [1]: N, [2]: N, [3]: N }
local __Vec3 = {}

---@generic N : AnyNum<N>
---@class Vec4<N> : { [1]: N, [2]: N, [3]: N, [4]: N }
local __Vec4 = {}

---@alias Vec2f Vec2<float>
---@alias Vec2i Vec2<int>

---@alias Vec3f Vec3<float>
---@alias Vec3i Vec3<int>

---@alias Vec4f Vec4<float>
---@alias Vec4i Vec4<int>

---@generic N : AnyNum<N>
---@class Box<N> : { [1]: Vec2<N>, [2]: Vec2<N> }
local __Box = {}

---@alias error error

---@class Error : MsgData|string|nil|error
local __Error = {}

---@class fun : function|function(...)
local __fun = {}

---@class func : fun
local __func = {}

---@class OfAny : any
local __OfAny = {}

---@class OfAnyOrNil : OfAny|nil
local __OfAnyOrNil = {}

---@generic I : OfAnyOrNil
---@generic B : OfAnyOrNil
---@class BoundeObject<I, B> : table|fun(I, ...): B
local __BoundeObject = {}

-- ---@generic T : OfAnyOrNil

---@generic R : OfAnyOrNil
---@class AssociatedFunction<T, R> : fun(...): R
local __AssociatedFunction = {}

---@generic T : OfAnyOrNil
---@generic R : OfAnyOrNil
---@class AssociatedMethod<T, R> : fun(self: T, ...): R
local __AssociatedMethod = {}
