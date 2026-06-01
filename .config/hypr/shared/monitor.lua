-- See https://wiki.hyprland.org/Configuring/Monitors/
-- monitor = desc:Samsung Electric Company LS49AG95 HNTTB00033 (DP-1), 5120x1440@239.76, 0x0, 1,bitdepth,10,cm,hdr,sdrbrightness,1.45,sdrsaturation,0.98,

hl.monitor({
  output = "DP-1",
  -- description: Samsung Electric Company LS49AG95 HNTTB00033
  -- output = "desc:Samsung Electric Company LS49AG95 HNTTB00033",
  mode = "5120x1440@239.74",
  position = "0x0",
  scale = "1.0",
  transform = false,
  vrr = 3,
  bitdepth = 10,
  --# srgb for 8bpc, wide for 10bpc if supported (recommended)
  -- cm = auto
  --## wide color gamut, BT2020 primaries
  -- cm = wide
  --# primaries from edid (known to be inaccurate)
  -- cm = edid
  --## wide color gamut and HDR PQ transfer function (experimental)
  -- cm = hdr
  --# same as hdr with edid primaries (experimental)#
  cm = "hdredid",
  supports_wide_color = 1,
  -- sdrbrightness = 1.00
  -- sdrbrightness = 1.175
  -- sdrbrightness = 0.0895
  sdrbrightness = 0.2895,
  -- sdrbrightness = 1.125
  --#    # sdrsaturation = 0.98 # non hdr???? idk looks weird but web-pages etc. look normal
  sdrsaturation = 1.40,
  -- sdrsaturation = 1.650 # hdr
  sdr_min_luminance = 0.005,
  --#    sdr_max_luminance = 185
  --#################### having this value over 100 causes the blotchy wallpaper problems?
  --# It shouldnt.... 185 is almost identical to Windows handling
  -- sdr_max_luminance = 200
  -- sdr_max_luminance = 963
  sdr_max_luminance = 1000,
  --#
  --#    # sdr_max_luminance = 700
  --#    # min_luminance = 0.005
  --#    # max_luminance = 150
  -- min_luminance = 0.01  # Monitor's min luminance (float; based on your Neo G9 specs ~0.01 cd/m²)
  min_luminance = 0.005,
  max_luminance = 1000,
  max_avg_luminance = 400,
  -- Transfer function for displaying SDR apps.
  -- default - Use default value (Gamma 2.2),
  -- gamma22 - Gamma 2.2,
  -- srgb - sRGB piecewise
  sdr_eotf = "gamma22force",
})

-- monitor = desc:Acer Technologies KA242Y 1201028BF3W01 (HDMI-A-2), 1920x1080@74, 5120x300, 1

hl.monitor({
  output = "HDMI-A-2",
  -- description: Acer Technologies KA242Y 1201028BF3W01
  -- output = "desc:Acer Technologies KA242Y 1201028BF3W01",
  --# turn it on
  disabled = false,
  mode = "1920x1080@74",
  position = "5120x300",
  scale = "1.0",
  transform = false,
  bitdepth = 8,
  vrr = 0,
  -- cm = auto
  -- supports_wide_color = false
  -- sdrbrightness = 1.0
  -- sdrsaturation = 1.0
  -- sdr_min_luminance = 1.00
  -- sdr_max_luminance = 250
})

hl.workspace_rule({
  workspace = "1",
  monitor = "DP-1",
})

hl.workspace_rule({
  workspace = "2",
  monitor = "DP-1",
})

hl.workspace_rule({
  workspace = "3",
  monitor = "DP-1",
})

hl.workspace_rule({
  workspace = "4",
  monitor = "DP-1",
})

hl.workspace_rule({
  workspace = "5",
  monitor = "DP-1",
})

hl.workspace_rule({
  workspace = "6",
  monitor = "DP-1",
})

-- workspace = 7,monitor:DP-1
-- workspace = 8,monitor:DP-1

-- Misc-off-hand - eg: Chat, Discord, etc.
hl.workspace_rule({
  workspace = "7",
  monitor = "HDMI-A-2",
})

-- Off-hand tools - eg: Docker
hl.workspace_rule({
  workspace = "8",
  monitor = "HDMI-A-2",
})

-- Music - eg: Spotify, YouTube Music, etc.
hl.workspace_rule({
  workspace = "9",
  monitor = "HDMI-A-2",
})
