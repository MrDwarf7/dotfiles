---@diagnostic disable: undefined-doc-class
---@meta

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

--- Extended window rule types.
--- Supplements the minimal HL.WindowRuleSpec from the official stub.

---@alias RegexStr string
---@alias WorkSpaceStr string|integer
---@alias EffectFields string

---@class HyprConfig.HL.WindowMatch
---@field class? RegexStr
---@field title? RegexStr
---@field initial_class? RegexStr
---@field initial_title? RegexStr
---@field tag? string
---@field xwayland? boolean
---@field float? boolean|integer
---@field fullscreen? boolean
---@field pin? boolean
---@field focus? boolean
---@field group? boolean
---@field modal? boolean
---@field namespace? string

---@class HyprConfig.HL.WindowRuleSpec : HL.WindowRuleSpec
---@field match? HyprConfig.HL.WindowMatch
---@field float? boolean
---@field center? boolean
---@field size? string|string[]
---@field move? string|string[]
---@field workspace? WorkSpaceStr
---@field tag? string
---@field opacity? string
---@field persistent_size? boolean
---@field no_initial_focus? boolean
---@field no_focus? boolean
---@field stay_focused? boolean
---@field border_size? integer
---@field no_blur? boolean
---@field no_shadow? boolean
---@field no_anim? boolean
---@field pin? boolean
---@field fullscreen? boolean
---@field maximize? boolean
---@field suppress_event? string
---@field immediate? boolean
---@field keep_aspect_ratio? boolean
---@field focus_on_activate? boolean
---@field opaque? boolean
---@field no_float? boolean

---@class HyprConfig.FloatCenterApp : HyprConfig.HL.WindowRuleSpec
---@field class RegexStr

---@class HyprConfig.TagEffectApp : HyprConfig.HL.WindowRuleSpec
---@field class RegexStr
---@field workspace WorkSpaceStr

---@class HyprTypes
return {
  HyprlandEvents = HyprlandEvents,
}
