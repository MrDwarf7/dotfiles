--- Window rules loader — self-contained.
--- Loads all rule files from shared/rules/.
--- Each rule file returns a table of rule tables.

--- Some notes on the window_rule.move and window_rule.size params:
---
--- monitor_w and monitor_h for monitor size
--- window_x and window_y for window position
--- window_w and window_h for window size
--- cursor_x and cursor_y for cursor position

-- Global floating window rule
hl.window_rule({
  name = "no-floating-border",
  match = {
    float = true,
  },
  border_size = 0,
})

-- List of rule modules to load
local modules = {
  "a_generic",
  "affine",
  "ag_blueman",
  "ag_mpv",
  "ag_pip",
  "ag_popups",
  "ag_pulse_pavu",
  "ag_qalculate",
  "ag_qt5ct",
  "alecaframe",
  "appimagelauncher",
  "calendly",
  "chromium",
  "code",
  "davinici-panels",
  "discord",
  "docker",
  "feh",
  "ghostty",
  "jetbrains",
  "keepassxc",
  "keymap",
  "kt",
  "limo",
  "obsidian",
  "polychromatic",
  "qBittorrent",
  "rimworld",
  "showmethekey",
  "signal",
  "solarar",
  "spotify",
  "steam",
  "swappy",
  "telegram",
  "thunar",
  "thunderbird",
  "ueberzugpp",
  "viewnoir",
  "vivaldi",
  "waypaper",
  "webapp-grok",
  "webapp-manager",
  "wezterm",
  "xdg-portal",
  "youtube-music_ytm_yt_music",
  "ytm__pear",
  "zathura",
  "zed-editor",
  "zen",
  "zmk-studio",
}

for _, module in ipairs(modules) do
  local rules = require("shared.rules." .. module)
  -- local rules = require(module)
  if type(rules) == "table" then
    for _, rule in ipairs(rules) do
      hl.window_rule(rule)
    end
  end
end
