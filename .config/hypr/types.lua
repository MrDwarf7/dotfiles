---@diagnostic disable: undefined-doc-class
---@meta

---@alias void nil
---@alias bool boolean

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

---@class HyprTypes
return {
  HyprlandEvents = HyprlandEvents,
}
