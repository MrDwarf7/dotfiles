--##################
--## MY PROGRAMS ###
--##################

-- TEST: -- THIS IS MY LOCAL VARIANT, NOT PARU/PACMAN!!!!!!
-- If removing or cargo clean'ing, this will break.
-- $bar = /home/dwarf/Documents/GitHub_Projects/Rust/OTHER/ashell/target/release/ashell

-- If using hyprpaper as the wallpaper manager, will want to enable and start the service
-- systemctl --user enable --now hyprpaper
-- systemctl --user start --now hyprpaper

-- Only required if using swww as the waypaper backend
-- Can only set to startup via systemctl or uwsm

-- Run the swww-daemon as a service via a uwsm slice (background compatible when -t service)
-- $wallpaper_prog = uwsm app -t service -- swww-daemon

local locs = require("shared.locations")

-- for field, value in pairs(locs) do
--   print("[programs] locs." .. field .. " = " .. value)
-- end

return {
  term = "ghostty",
  second_term = "wezterm",
  file_manager = "thunar",
  menu = "tofi-drun",
  menu_other = "wofi -n",
  locking = "hyprlock",
  logout_prog = "wleave -f",
  browser = "vivaldi",
  screenshot = locs.hypr_scripts .. "/screenshot.fish",
  -- locs.hyprdir .. "/scripts/screenshot.fish",
  -- os.getenv("HOME") .. "/.config/hypr/scripts/screenshot.fish",
  clipboard_history = "clapboard",
  notification_daeomon = "swaync",
  notifications = "swaync-client -df",
  bar = "waybar",
  color_picker = "hyprpicker -r -na -f hex",
  wallpaper_prog = "awww --restore",
  wallpaper_daeomon = "awww-daemon",
  idle_manager = "hypridle",
}
