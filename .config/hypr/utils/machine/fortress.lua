---@type HyprConfig.Machine
return {
  kind = "desktop",
  -- "daggertooth.morray" is NOT here: manbook used the same alias (coin flip).
  aliases = {
    "Fortress",
    "fortress",
    "fortress.daggertooth.morray",
  },
  monitors = {
    {
      output = "DP-1",
      disabled = false,
      mode = "5120x1440@239.74",
      position = "0x0",
      scale = "1.0",
      transform = false,
      vrr = 3,
      bitdepth = 10,
      cm = "hdredid",
      supports_wide_color = 1,
      sdrbrightness = 0.2895,
      sdrsaturation = 1.40,
      sdr_min_luminance = 0.005,
      sdr_max_luminance = 1000,
      min_luminance = 0.005,
      max_luminance = 1000,
      max_avg_luminance = 400,
      sdr_eotf = "gamma22force",
    },
    {
      output = "HDMI-A-2",
      disabled = false,
      mode = "1920x1080@74",
      position = "5120x300",
      scale = "1.0",
      transform = false,
      bitdepth = 8,
      vrr = 0,
    },
  },
  workspace_rules = {
    -- stylua: ignore start
    { workspace = "1", monitor = "DP-1" },
    { workspace = "2", monitor = "DP-1" },
    { workspace = "3", monitor = "DP-1" },
    { workspace = "4", monitor = "DP-1" },
    { workspace = "5", monitor = "DP-1" },
    { workspace = "6", monitor = "DP-1" },
    { workspace = "7", monitor = "HDMI-A-2" },
    { workspace = "8", monitor = "HDMI-A-2" },
    { workspace = "9", monitor = "HDMI-A-2" },
    -- stylua: ignore end
  },
  layout = {
    single_window_aspect_ratio = { 21, 9 },
  },
}
