---@meta
---
---@diagnostic disable: undefined-doc-class
---@diagnostic disable: unused-local

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
---@class Error : error
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

---@generic T : Str
---@class HyprConfig.Events<T> : HL.EventName<T>
local HyprlandEvents = {
  ---@type HL.EventName<"hyprland.start">
  START = "hyprland.start",
  ---@type HL.EventName<"hyprland.shutdown">
  SHUTDOWN = "hyprland.shutdown",
}

-- Extended Hyprland types for this config.

---@generic N : AnyNum<N>
---@class HyprConfig.CurvePoint<N> : Vec2<N>
local __HyprConfig_CurvePoint = {}

---@generic K : Index
---@class HyprConfig.Curve : { [K]: HyprConfig.Curve }
---@field name? string This field is largely ignored when handled via hl.curve fn as it expects the initial key to whatever table contains these to be the name
---@field type "bezier" | "linear" | "step" | "steps" | "cubic-bezier"
---@field points HyprConfig.CurvePoint[]
local __HyprConfig_Curve = {}

---@alias Styles "popin" | "popout" | "slidein" | "slideout" | "fadein" | "fadeout" | "none"

---@generic P
---@class Percentage<P> : AnyNum<P> -- nominal alias: a number between 0 and 100. Percentage == number (safe), used to document intent.

-- style = "popin 15%",

---@generic S : Styles
---@generic P : Percentage
---@class StyleStr : Str<S, P>
local __StyleStr = {}

---@generic P : PathLike
---@class HyprConfig.Locations<P> : table<AnyNum, DirPathBuf|ConfFile|LuaPathBuf>
---@field HOME? P
---@field hyprdir P
---@field hypr_scripts P
---@field rules_dir P
---@field keymaps_dir P
---@field programs? ConfFile
local __HyprConfig_Locations = {}

-- TODO: [bound] : there are a _known_ set of 'leaf' types, buuuut...

---@generic N : AnyNum
---@generic S : StyleStr
---@class HyprConfig.Animation
---@field leaf "windows" | "windowsIn" | "windowsOut" | "fade" | "fadeIn" | "fadeOut" | "workspaces" | "workspacesIn" | "workspacesOut" | "specialWorkspace" | "layers" | "layersIn" | "layersOut" | "fadePopups"
---@field enabled boolean
---@field speed AnyNum<N>
---@field bezier string
---@field style StyleStr<S, Percentage>
local __HyprConfig_Animation = {}

---@class RegexStr : string             -- nominal alias: a PCRE-ish pattern. RegexStr == string (safe), used to document intent.
local __RegexStr = {}
---@class WorkSpaceStr : string|integer -- "1 silent" | "4" | 4
local __WorkSpaceStr = {}

---@class HyprConfig.HL.WindowMatch
--- Match selectors (full set per Hyprland docs). All optional; a window matches
--- when EVERY provided selector matches. Regex fields are PCRE-ish -- anchoring
--- is the author's job, the type only documents intent.
---@field class? RegexStr
---@field title? RegexStr
---@field initial_class? RegexStr
---@field initial_title? RegexStr
---@field tag? string                 -- matches a tag (no leading +)
---@field xwayland? boolean
---@field float? boolean|integer      -- matcher: 1 = floating, 0 = tiled
---@field fullscreen? boolean
---@field pinned? boolean             -- Hyprland match key is `pinned` (not `pin`)
---@field focus? boolean
---@field group? boolean
---@field group_locked? boolean
---@field modal? boolean
---@field minimized? boolean
---@field workspace? string|integer
---@field monitor? string|integer
---@field namespace? string
---@field xdg_tag? string
local __HyprConfig_HL_WindowMatch = {}

---@class HyprConfig.HL.WindowRuleSpec : HL.WindowRuleSpec
--- Inherits `enabled?` and `name?` from the official stub (do NOT redeclare).
--- We only OVERRIDE `match` (parent's is uselessly wide) and ADD the runtime
--- effects HL applies (absent from the official stub).
--- Effects are top-level because HL's real call shape is flat
--- (hl.window_rule({ name, match={...}, float=..., workspace=... })) -- there is
--- no `effects` sub-table in the actual API, so the type mirrors the flat shape.
---@field match? HyprConfig.HL.WindowMatch
---
--- Effects (applied by HL at runtime; from the docs + current usage):
---@field tag? string                 -- effect: "+foo" adds a tag
---@field float? boolean
---@field tile? boolean
---@field center? boolean
---@field size? string|string[]       -- "W H" or { "W", "H" }
---@field move? string|string[]       -- "x y" or { "x", "y" }
---@field workspace? WorkSpaceStr
---@field monitor? string|integer
---@field opacity? string             -- "X override Y override"
---@field persistent_size? boolean
---@field no_initial_focus? boolean
---@field no_focus? boolean
---@field stay_focused? boolean
---@field focus_on_activate? boolean
---@field border_size? integer
---@field no_blur? boolean
---@field blur? boolean
---@field no_shadow? boolean
---@field shadow? boolean
---@field no_anim? boolean
---@field animation? string
---@field opaque? boolean
---@field alpha? number
---@field pin? boolean
---@field fullscreen? boolean
---@field fakefullscreen? boolean
---@field maximize? boolean
---@field nomaxsize? boolean
---@field minsize? string
---@field maxsize? string
---@field keep_aspect_ratio? boolean
---@field immediate? boolean
---@field pseudo? boolean
---@field decorate? boolean
---@field rounding? integer
---@field no_rounding? boolean
---@field suppress_event? string      -- e.g. "maximize"
---@field force? boolean
---@field xray? boolean
---@field dimaround? boolean
---@field forcergbx? boolean
---@field group? string               -- effect: assign to a group (set)
---@field parent? string              -- effect: set parent window
---@field syncid? string|integer      -- effect: sync id
---@field no_gaps? boolean
---@field no_border? boolean
---@field no_damage? boolean
---@field no_dim? boolean
---@field no_maximize? boolean
---@field no_fullscreen? boolean
---@field no_padding? boolean
---@field no_titlebar? boolean
---@field no_csd? boolean
---@field y_percent? number
---@field x_percent? number
---@field no_gap_when_fullscreen? boolean
---@field center_on? string
---@field move_to_group? boolean
---@field swap_with? string
---@field tentative? boolean
---@field title? string               -- effect: set title (rarely used)
---@field class? string               -- effect: set class (rarely used)
local __HL_WindowRuleSpec = {}

-- (Fake) Cast assignment

---@class HyprConfig.HL.API : HL.API
---@field window_rule fun(spec: HyprConfig.HL.WindowRuleSpec): HL.WindowRule
local _h = hl ---@cast _h HyprConfig.HL.API

-- localize window_rule + cast VIA the (fake)

---@type fun(spec: HyprConfig.HL.WindowRuleSpec): HL.WindowRule
local window_rule = _h.window_rule ---@cast window_rule fun(spec: HyprConfig.HL.WindowRuleSpec): HL.WindowRule

-- Assign the casted function back to the API table (so hl.window_rule is typed correctly).

---@type fun(spec: HyprConfig.HL.WindowRuleSpec): HL.WindowRule
_h.window_rule = window_rule ---@cast window_rule fun(spec: HyprConfig.HL.WindowRuleSpec): HL.WindowRule

-- Assign the casted function back to the global hl table (so hl.window_rule is typed correctly).

---@type fun(spec: HyprConfig.HL.WindowRuleSpec): HL.WindowRule
hl.window_rule = _h.window_rule ---@cast window_rule fun(spec: HyprConfig.HL.WindowRuleSpec): HL.WindowRule

hl = _h

setmetatable(hl, {
  __index = function(t, k)
    if k == "window_rule" then
      return _h.window_rule
    end
    return rawget(t, k)
  end,
})

---@class HyprTypes
local hypr_types = {
  HyprlandEvents = HyprlandEvents,

  ---@type HyprConfig.HL.API
  hl = hl,
  --
  ---@type HyprConfig.HL.API
  _h = _h,
}

---@return HyprTypes
return hypr_types
