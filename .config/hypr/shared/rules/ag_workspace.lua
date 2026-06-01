--- Aggregate workspace assignment rules.
--- Rules that send windows to specific workspaces.
--- Excludes: tag-based workspace assignments (those live in ag_tag.lua).

return {
  -- ════════════════════════════════════════════
  -- Docker Desktop
  -- workspace: 7
  -- ════════════════════════════════════════════
  {
    name = "workspace-docker-desktop",
    match = { class = "^(Docker Desktop)$" },
    workspace = "7 silent",
    no_initial_focus = true,
  },

  -- ════════════════════════════════════════════
  -- Obsidian
  -- workspace: 5
  -- ════════════════════════════════════════════
  {
    name = "workspace-obsidian",
    match = { class = "^([oO]bsidian)$" },
    float = false,
    workspace = "5 silent",
    persistent_size = true,
  },

  -- ════════════════════════════════════════════
  -- Signal + Telegram / QQ (common behaviours)
  -- workspace: 6, float, center, persistent_size, opacity
  -- ════════════════════════════════════════════
  {
    name = "workspace-messaging-common",
    match = { class = "^([sS]ignal|QQ|Telegram|org.telegram.desktop)$" },
    workspace = "6 silent",
    float = true,
    center = true,
    persistent_size = true,
    opacity = "1.0 override 1.0 override",
  },

  -- Signal-specific: larger size
  {
    name = "size-signal",
    match = { class = "^([sS]ignal)$" },
    size = "1600 1250",
  },

  -- ════════════════════════════════════════════
  -- Spotify
  -- workspace: 8
  -- ════════════════════════════════════════════
  {
    name = "workspace-spotify",
    match = { class = "^([sS]potify)$" },
    workspace = "8 silent",
    maximize = true,
  },
}
