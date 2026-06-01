--- Shared autostart execs.
--- These run for ALL shell variants (vanilla and DMS).
--- Shell-specific execs belong in vanilla/ or dms/.

local utils = require("utils")
-- local programs = require("shared.programs")

hl.on("hyprland.start", function()
  -- PulseAudio: unmute default sink on startup
  hl.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 0")

  -- USB auto-mounting via udiskie (as uwsm service)
  utils.uwsm_launcher("udiskie -n -t -m flat", true)

  -- Telegram on workspace 6 (silent = don't switch to it)
  hl.exec_cmd("Telegram", { workspace = "6 silent" })

  -- utils.uwsm_launcher("wallpaperengine-gui -m", true)
  hl.exec_cmd("wallpaperengine-gui -m")

  -- Propagate Wayland/XDG vars to dbus
  -- NOTE: Commented out — redundant with dbus-broker + uwsm.
  -- dbus-broker reuses systemd's activation environment directly,
  -- so there's nothing to sync. The --all flag was also copying
  -- every env var on every boot for zero benefit.
  -- hl.exec_cmd("dbus-update-activation-environment --systemd --all")

  -- Start Hermes gateway services (delayed to avoid blocking boot)
  hl.exec_cmd("sleep 3 && systemctl --user start hermes.target")
end)
