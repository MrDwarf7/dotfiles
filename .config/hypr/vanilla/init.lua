--- Vanilla (default) Hyprland shell configuration.
--- Loaded by hyprland.lua when HYPRLAND_SHELL=vanilla.
--- Handles vanilla-specific setup: waybar, swww, swaync, etc.

---@class HyprConfig.Vanilla
local Vanilla = {}

---@return HyprConfig.Vanilla
function Vanilla:setup()
  -- Load vanilla-specific autostart execs

  require("vanilla.execs")
  require("vanilla.keymaps")

  return self
end

return Vanilla
