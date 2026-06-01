--- Vanilla shell-specific autostart execs.
--- These only run when HYPRLAND_SHELL=vanilla.
--- DMS handles all of this internally via quickshell.

local utils = require("utils")
local programs = require("shared.programs")

-- TODO: at a later stage, we can move the
-- fancy stuff in shared/execs.lua into a helper fn/framework
-- and then just make use of it in both the existing shared one + per shell (vanilla here, and dms if we add dms specific execs later).

local setup = function()
  hl.on("hyprland.start", function()
    -- Status bar
    utils.uwsm_launcher(programs.bar, false)

    -- Wallpaper daemon (swww)
    utils.uwsm_launcher(programs.wallpaper_daeomon, true)

    -- Notification daemon (swaync)
    utils.uwsm_launcher(programs.notification_daeomon, true)
    hl.exec_cmd(programs.notifications)

    -- Polkit agent (only needed if NOT using uwsm to manage it via systemctl)
    -- If using uwsm: systemctl --user enable --now hyprpolkitagent.service

    -- Hyprsunset (night light)
    -- If using uwsm: systemctl --user enable --now hyprsunset.service
  end)
end

return setup()
