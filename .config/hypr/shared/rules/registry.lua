--- Standalone window rules. No shared bucket behavior.
--- Exact official hl.window_rule() API shape: a table of rule tables,
--- looped and submitted as-is. No helpers, no DSL, no tag magic.
--- Anything that doesn't fit a bucket and is too messy for its own
--- tidy file lands here so it's all in one findable place.
---
--- NOTE: float_center items are inlined here on purpose (duplication is
--- intentional + accepted) so every float+center app is visible in one file.

---@type HyprConfig.HL.WindowRuleSpec[]
local registry = {
  -- The following 2 are the only ones
  -- that have a workspaces assignment in them
  -- but still sit here in the registry.
  -- Important for nvim-macro sorting etc.

  --- Discord forks (public_comms was dropped as a bucket: single group, no sub-windows).
  {
    name = "registry-discord",
    match = { class = "[dD]iscord|[aA]rmcord|[wW]ebcord|[vV]encord|[vV]esktop" },
    workspace = "9 silent",
    maximize = true,
    opacity = "0.90 override 0.60 override",
    persistent_size = true,
  },

  --- Docker Desktop.
  {
    name = "registry-docker",
    match = { class = "Docker(\\s+)?sDesktop" },
    workspace = "7 silent",
    no_initial_focus = true,
    opacity = "1.00 override 1.00 override",
    persistent_size = true,
  },

  --- qBittorrent.
  {
    name = "registry-qbittorrent",
    match = { class = "org.qbittorrent.qBittorrent" },
    float = true,
    persistent_size = true,
  },

  --- ueberzugpp (terminal image viewer overlay).
  {
    name = "registry-ueberzugpp",
    match = { class = "ueberzugpp_.*" },
    no_initial_focus = true,
    opacity = "1.00 override 1.00 override",
    persistent_size = true,
  },

  --- RimWorld (fullscreen, borderless).
  {
    name = "registry-rimworld",
    match = { class = "[rR]im[wW]orld[lL]inux" },
    border_size = 0,
    fullscreen = true,
    opacity = "1.00 override 1.00 override",
    size = "5120 1440",
  },

  ------------------------------------------------------------
  --- Inlined float_center items (float + center + size). Duplicated on purpose.
  ------------------------------------------------------------
  {
    name = "registry-cf-blueman-manager",
    match = { class = "^(blueman-manager)$" },
    center = true,
    float = true,
    size = "1000 650",
  },
  {
    name = "registry-cf-pavucontrol",
    match = { class = "^(org.pulseaudio.pavucontrol)$" },
    center = true,
    float = true,
    size = "1000 650",
  },
  {
    name = "registry-cf-qalculate",
    match = { class = "^(io.github.Qalculate.qalculate-qt)$" },
    center = true,
    float = true,
    size = "600 900",
  },
  {
    name = "registry-cf-qt5ct",
    match = { class = "^(qt5ct)$" },
    center = true,
    float = true,
    size = "960 540",
  },
  {
    name = "registry-cf-appimagelauncher",
    match = { class = "^(AppImageLauncherSettings)$" },
    center = true,
    float = true,
    size = "1450 1000",
  },
  {
    name = "registry-cf-swappy",
    match = { class = "^(swappy)$" },
    center = true,
    float = true,
    size = "2560 1200",
  },
  {
    name = "registry-cf-keymapp",
    match = { class = "^(keymapp)$" },
    center = true,
    float = true,
    size = "1450 1000",
  },
  {
    name = "registry-cf-webapp-manager",
    match = { class = "^(webapp-manager.py)$" },
    center = true,
    float = true,
    size = "1000 650",
  },
  {
    name = "registry-cf-webapp",
    match = { class = "^(WebApp-.*)$" },
    center = true,
    float = true,
    size = "1450 1000",
  },
  {
    name = "registry-cf-zmk-studio",
    match = { class = "^(zmk-studio)$" },
    center = true,
    float = true,
    size = "1450 1000",
  },
  {
    name = "registry-cf-feh",
    match = { class = "^([fF]eh)$" },
    center = true,
    float = true,
    size = "1680 1080",
  },
  {
    name = "registry-cf-freedownloadmanager",
    match = { class = "^(org.kde.freedownloadmanager)$" },
    center = true,
    float = true,
    size = "1280 720",
  },
  {
    name = "registry-cf-viewnior",
    match = { class = "^(viewnior)$" },
    center = true,
    float = true,
    size = "(monitor_w*0.40) (monitor_h*0.60)",
  },
  {
    name = "registry-cf-dms",
    match = { class = "^(com.danklinux.dms)$" },
    center = true,
    float = true,
    size = "(monitor_w*0.30) (monitor_h*0.80)",
  },
  {
    name = "registry-cf-keepassxc",
    match = { class = "^(org.keepassxc.[kK]ee[pP]ass[xX][cC])$" },
    center = true,
    float = true,
    size = "(monitor_w*0.30) (monitor_h*0.60)",
  },
  {
    name = "registry-cf-xdg-portal-gtk",
    match = { class = "^(xdg-desktop-portal-gtk)$" },
    center = true,
    float = true,
    size = "1680 1080",
  },

  -- TODO: Move to own file (more than 1 rule)
  --- Solaar (mouse/keyboard manager).
  {
    name = "registry-cf-solaar",
    match = { class = "^(solaar)$", title = "^([sS]olaar)$" },
    center = true,
    float = true,
    size = "1000 650",
  },
  {
    name = "registry-cf-solaar-rule-editor",
    match = { class = "^(solaar)$", title = "^([sS]olaar [rR]ule [eE]ditor)$" },
    center = true,
    float = true,
    size = "600 500",
  },

  -- Polychromatic (RGB controller).
  {
    name = "registry-cf-polychromatic",
    match = { class = "^(polychromatic)$" },
    center = true,
    float = true,
    size = "1050 950",
  },

  {
    name = "registry-cf-waypaper",
    match = { class = "^(waypaper)$" },
    center = true,
    float = true,
    persistent_size = true,
    -- size = "1450 1000",
  },

  -- Blueberry (bluetooth manager).
  {
    name = "registry-cf-blueberry",
    match = { class = "^(blueberry.py)$" },
    center = true,
    float = true,
  },
  ------------------------------------------------------------
  ------------------------------------------------------------

  {
    name = "registry-showmethekey",
    match = { class = "^(one.alynx.showmethekey|showmethekey-gtk)$" },
    float = true,
    pin = true,
  },

  {
    name = "registry-webapp-grok",
    match = { class = "^([vV]ivaldi)(-)(.*)(-)([dD]efault)$", title = "title ^([gG]rok)$" },
    -- size = "1000 1300",
    move = "20 95",
    persistent_size = true,
  },

  {
    name = "registry-polychromatic-dev",
    match = { class = "^(polychromatic)$", title = "^([dD]evice [iI]nformation - .+)$" },
    size = "200 400",
  },

  {
    name = "registry-zathura",
    match = { class = "^(org.pwmt.zathura)$" },
    -- size = "1100 1300",
    float = true,
    opacity = "1.00 override 1.00 override",
    persistent_size = true,
  },

  -- TODO: consider splitting into file+bucket (via 'file_managers')
  {
    name = "registry-bulk-media-players",
    match = { class = "^(imv|mpv|danmufloat|termfloat|nemo|ncmpcpp)$" },
    float = true,
    move = "(monitor_w*0.30) (monitor_h*0.10)",
    size = "(monitor_w*0.40) (monitor_h*0.65)",
  },

  -- TODO: Additional items for wine/MS specific items (such as explorer.exe etc. that are spawned within wine/proton envs)
}

require("utils.lst").map(registry, hl.window_rule)
