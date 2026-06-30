---@diagnostic disable: undefined-doc-class
---@meta

---@alias void nil
---@alias bool boolean

---@class HyprConfig.Events : HL.EventName
local HyprlandEvents = {
  START = "hyprland.start",
  SHUTDOWN = "hyprland.shutdown",
}

---@class HyprTypes
return {
  HyprlandEvents = HyprlandEvents,
}
