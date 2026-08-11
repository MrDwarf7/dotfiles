---@meta
---
---@diagnostic disable: undefined-doc-class

---@alias void nil
---@alias bool boolean
---@alias int integer
---@alias float number
---@alias str string

---@alias error error
---@class Error : error

---@class fun : function|function(...)

---@class OfAny : any
---@class OfAnyOrNil : OfAny|nil

---@generic I : OfAnyOrNil
---@generic B : OfAnyOrNil
---@alias BoundeObject table|fun(I, ...): B

---@generic T : OfAnyOrNil
---@generic R : OfAnyOrNil
---@alias AssociatedFunction fun(...): R

---@generic T : OfAnyOrNil
---@generic R : OfAnyOrNil
---@class AssociatedMethod : fun(self: T, ...): R

---@class HyprConfig.Events : HL.EventName
local HyprlandEvents = {
  START = "hyprland.start",
  SHUTDOWN = "hyprland.shutdown",
}

-- Extended Hyprland window-rule types for this config.

---@alias RegexStr string             -- nominal alias: a PCRE-ish pattern. RegexStr == string (safe), used to document intent.
---@alias WorkSpaceStr string|integer -- "1 silent" | "4" | 4

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
local ___HyprConfig_HL_WindowMatch = {}

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
