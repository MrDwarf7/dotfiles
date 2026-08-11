---@type HyprConfig.Machine
return {
  kind = "laptop",
  aliases = {
    "manbook",
    "manbook.daggertooth.morray",
  },
  monitors = {
    {
      output = "eDP-1",
      mode = "2560x1600",
      scale = "1.60",
      position = "0x0",
      transform = false,
    },
  },
  workspace_rules = {
    -- stylua: ignore start
    { workspace = "1", monitor = "eDP-1" },
    { workspace = "2", monitor = "eDP-1" },
    { workspace = "3", monitor = "eDP-1" },
    { workspace = "4", monitor = "eDP-1" },
    { workspace = "5", monitor = "eDP-1" },
    { workspace = "6", monitor = "eDP-1" },
    { workspace = "7", monitor = "eDP-1" },
    { workspace = "8", monitor = "eDP-1" },
    { workspace = "9", monitor = "eDP-1" },
    -- stylua: ignore end
  },
  layout = {
    single_window_aspect_ratio = { 16, 10 },
  },
  scrolling = {
    fullscreen_on_one_column = true,
  },
}
