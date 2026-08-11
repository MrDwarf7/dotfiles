--- Vanilla (default) Hyprland shell configuration.
--- Loaded by hyprland.lua when HYPRLAND_SHELL=vanilla.
--- Handles vanilla-specific setup: waybar, swww, swaync, etc.

---@class HyprConfig.Vanilla
local vanilla = {}

---@param self HyprConfig.Vanilla
---@return HyprConfig.Vanilla
vanilla.setup = function(self)
  -- Load vanilla-specific autostart execs

  require("vanilla.execs")
  require("vanilla.keymaps")

  return self
end

return vanilla
