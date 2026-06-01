--- Vanilla shell-specific autostart execs.
--- These only run when HYPRLAND_SHELL=vanilla.
--- DMS handles all of this internally via quickshell.

local utils = require("utils")
local logger = require("utils.logger")
local programs = require("shared.programs")

local VanillaExecs = {}

function VanillaExecs:setup(shell_name)
  if shell_name ~= "vanilla" then
    print(
      "[hyprland] WARNING: Attempting to set up VanillaExecs for shell '"
        .. shell_name
        .. "'. This may indicate a misconfiguration. Proceeding with setup."
    )
    logger:log(
      "[hyprland] WARNING: Attempting to set up VanillaExecs for shell '"
        .. shell_name
        .. "'. This may indicate a misconfiguration. Proceeding with setup."
    )
  end
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
  return self
end

return VanillaExecs
