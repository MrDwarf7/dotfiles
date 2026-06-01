--- DMS (DankLinux Desktop) shell-specific configuration.
--- Loaded by hyprland.lua when HYPRLAND_SHELL=dms.
--- Handles DMS-specific setup: keymaps, layer rules, window rules, colors, etc.
--- DMS handles bar, wallpaper, and notifications internally via quickshell,
--- so no autostart execs are needed here (shared execs cover the common ones).

---@class HyprConfig.Dms
local Dms = {}

---@return HyprConfig.Dms
function Dms:setup()
  -- Load DMS-specific modules (each self-contained, calls hl.* directly)
  require("dms.colors")
  -- require("dms.cursor")
  require("dms.keymaps")
  require("dms.layerrules")
  -- require("dms.layout")
  require("dms.windowrules")

  return self
end

return Dms
