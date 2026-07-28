--####################
--## LOOK AND FEEL ###
--####################

-- https://wiki.hyprland.org/Configuring/Variables/#general
---@class HL.ConfigOptPartial : HL.ConfigOpt
local m = {
  ---@type HL.ConfigOpt.General
  general = {},
  -- https://wiki.hyprland.org/Configuring/Variables/#decoration

  ---@type HL.ConfigOpt.Decoration
  decoration = {
    ---@type HL.ConfigOpt.Decoration.Blur
    blur = {},
    ---@type HL.ConfigOpt.Decoration.Shadow
    shadow = {},
    ---@type HL.ConfigOpt.Decoration.Glow
    glow = {},
  },
}

m.general = {
  border_size = 1,
  -- locale =
  -- border_size = 0
  -- no_border_on_floating = true
  gaps_in = 6,
  gaps_out = 4,
  float_gaps = 0,
  gaps_workspaces = 0,
  col = {
    inactive_border = "rgba(595959aa)",
    active_border = "rgba(ffffffff)",
    nogroup_border = "rgba(ffff00ff)",
  },
  -- layout = "dwindle",
  -- layout = "master",
  layout = "scrolling",
  no_focus_fallback = false,
  resize_on_border = true,
  extend_border_grab_area = 10,
  hover_icon_on_border = true,
  -- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
  allow_tearing = true,
  resize_corner = 3,
  snap = {
    enabled = false,
    window_gap = 10,
    monitor_gap = 10,
    border_overlap = false,
    respect_gaps = false,
  },
}

m.decoration = {
  rounding = 0,
  rounding_power = 2.0,
  -- Change transparency of focused and unfocused windows
  -- active_opacity = 1.00
  -- active_opacity = 0.90
  -- inactive_opacity = 0.80
  active_opacity = 1.00,
  inactive_opacity = 0.80,
  -- active_opacity = 1.00
  -- inactive_opacity = 1.00
  fullscreen_opacity = 1.0,
  dim_inactive = false,
  dim_strength = 0.10,
  dim_special = 0.2,
  -- dim_around = 0.01
  dim_around = 0.4,
  -- screen_shader = ""
  border_part_of_window = true,
}

m.decoration.blur = {

  enabled = true,
  -- Size of each surface fragment (high values can cause a sort of 'kaleidoscope' effect)
  size = 4, -- default 8
  -- Gaussian blur
  passes = 6, -- default 1, previous was 5
  ignore_opacity = true,

  new_optimizations = true,
  xray = false,
  -- noise = 0.0117
  -- noise = 0.0000
  -- -- this is what I was using earlier
  -- noise = 0.0200
  noise = 0.0020,
  -- high ranking here is lighter, lower is darker
  -- contrast = 0.8916
  contrast = 0.92,
  -- note that the higher this goes, the more the colors will bleed through (good and bad)
  -- brightness = 0.65
  -- brightness = 0.30
  -- brightness = 0.8172,
  brightness = 0.7172,
  -- vibrancy = 1.0
  -- vibrancy = 1.0
  -- vibrancy = 0.1696
  vibrancy = 0.2696,
  vibrancy_darkness = 0.7,
  special = false,
  popups = true,
  popups_ignorealpha = 0.2,
  input_methods = false,
  input_methods_ignorealpha = 0.2,
  -- DMS's recommended settings
  -- contrast = 1.1
  -- vibrancy = 0.2
  -- vibrancy_darkness = 0.3
}

m.decoration.shadow = {
  enabled = true,
  -- range = 4
  range = 25,
  render_power = 3,
  offset = { 0, 0 },
  -- color = 0
  -- color = rgba(1a1a1aee)
  --          0x ee1a1a1a
  color = "rgba(1a1a1a1a)",
  -- DMS's recommended settings
  -- range = 20
  -- render_power = 3
  -- color = rgba(00000099)
  sharp = false,
  -- color_inactive =
  scale = 1.0,
  -- scale = 1.5
}

m.decoration.glow = {
  enabled = true,
  range = 2,
  render_power = 3,
  -- color = 0xee1a1a1a
  -- color_inactive = 0
}

hl.config(m)
--   {
--   general = general,
--   decoration = decoration,
-- })
