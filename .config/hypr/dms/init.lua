--- DMS (DankLinux Desktop) shell-specific configuration.
--- Loaded by hyprland.lua when HYPRLAND_SHELL=dms.
--- Handles DMS-specific setup: keymaps, layer rules, window rules, colors, etc.
--- DMS handles bar, wallpaper, and notifications internally via quickshell,
--- so no autostart execs are needed here (shared execs cover the common ones).

---@class HyprConfig.Dms
local Dms = {}

--- The use of a class table and a setup function
--- may seem redunant/overhead here, and it _sort of_ is.
--- But we get to call it explicitly in the top-level config
--- and all Shell types (Dms/Vanialla/Noctalia) have the same interface,
--- so it’s worth it for consistency and clarity.
--- The only other option is simply returning `<shell>:setup()`
--- here, and the caller only needs `require(<shell>)`, but... eh

---@return HyprConfig.Dms
function Dms:setup()
  -- Load DMS-specific modules (each self-contained, calls hl.* directly)
  require("dms.colors")
  -- require("dms.cursor")
  require("dms.keymaps")
  require("dms.layerrules")
  -- require("dms.layout")
  require("dms.windowrules")

  local types = require("types")
  -- probs move this to a proper execs.lua in here

  -- This reloads the githubInbox plugin on Hyprland start
  -- Required because it doesn't auto-fetch the secrets key by default
  hl.on(types.HyprlandEvents.START, function()
    -- pcall(function()
    hl.exec_cmd('dms ipc call plugins reload "githubInbox" >/dev/null 2>&1')
    -- end)
  end)

  return self
end

return Dms
