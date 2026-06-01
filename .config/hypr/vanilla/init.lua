--- Vanilla (default) Hyprland shell configuration.
--- Loaded by hyprland.lua when HYPRLAND_SHELL=vanilla.
--- Handles vanilla-specific setup: waybar, swww, swaync, etc.

---@class HyprConfig.Vanilla
local Vanilla = {}

---@param shell_name string  The name of the shell being set up (for logging/debugging)
---@return HyprConfig.Vanilla
function Vanilla:setup(shell_name)
  -- Load vanilla-specific autostart execs

  require("vanilla.execs"):setup(shell_name)
  require("vanilla.keymaps")

  return self
end

return Vanilla
