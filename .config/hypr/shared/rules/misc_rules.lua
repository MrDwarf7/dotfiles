--- Miscellaneous rules that don't fit neatly into a loop pattern.

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  -- TODO: [tags] : file_managers

  --- File managers (Thunar, Nemo, Dolphin) - monitor-relative sizing.
  {
    name = "float-file-managers",
    match = { class = "[tT]hunar|nemo|dolphin" },
    float = true,
    size = "(monitor_w*0.40) (monitor_h*0.65)",
  },

  -- TODO: [tags] : float_indicators

  --- Screen sharing indicator (pin to bottom center).
  {
    name = "float-screen-share",
    match = { title = ".*is sharing (a window|your screen).*" },
    float = true,
  },

  -- TODO: [tags] : float_indicators
  {
    name = "pin-screen-share",
    match = { title = ".*is sharing (a window|your screen).*" },
    pin = true,
  },

  -- TODO: [tags] : float_indicators
  {
    name = "position-screen-share",
    match = { title = ".*is sharing (a window|your screen).*" },
    move = { "(monitor_w*.5-window_w*.5)", "(monitor_h-window_h-12)" },
  },

  --- Tearing fixes (force immediate rendering for games).
  {
    name = "tearing-wine",
    match = { title = ".*\\.exe" },
    immediate = true,
  },

  {
    name = "tearing-minecraft",
    match = { title = ".*minecraft.*" },
    immediate = true,
  },

  {
    name = "tearing-steam-games",
    match = { class = "^(steam_app).*" },
    immediate = true,
  },

  --- KDE/Plasma compatibility floats.
  {
    name = "float-kde-plasmawindowed",
    match = { class = ".*plasmawindowed.*" },
    float = true,
  },

  {
    name = "float-kde-settings",
    match = { class = "kcm_.*" },
    float = true,
  },

  {
    name = "float-kde-wizard",
    match = { class = ".*bluedevilwizard" },
    float = true,
  },

  {
    name = "float-kde-welcome",
    match = { title = ".*Welcome" },
    float = true,
  },

  {
    name = "float-kde-shell-conflicts",
    match = { title = ".*Shell conflicts.*" },
    float = true,
  },

  {
    name = "float-kde-portal",
    match = { class = "org.freedesktop.impl.portal.desktop.kde" },
    float = true,
  },

  {
    name = "size-kde-portal",
    match = { class = "org.freedesktop.impl.portal.desktop.kde" },
    size = { "(monitor_w*0.60)", "(monitor_h*0.65)" },
  },

  --- Zotero.
  {
    name = "float-zotero",
    match = { class = "^(Zotero)$" },
    float = true,
  },

  {
    name = "size-zotero",
    match = { class = "^(Zotero)$" },
    size = { "(monitor_w*0.45)", "(monitor_h*0.45)" },
  },

  --- Misc floating apps.
  {
    name = "float-blueberry",
    match = { class = "^(blueberry\\\\.py)$" },
    float = true,
  },

  {
    name = "float-guifetch",
    match = { class = "^(guifetch)$" },
    float = true,
  },

  {
    name = "float-nm-editor",
    match = { class = "^(nm-connection-editor)$" },
    float = true,
    center = true,
    size = { "(monitor_w*0.45)", "(monitor_h*0.45)" },
  },

  --- Launchers need to be FAST (no animation).
  {
    name = "no-anim-launchers",
    match = { namespace = "gtk4-layer-shell" },
    -- no_anim = true,
  },

  {
    name = "float-showmethekey",
    match = {
      class = "^(one.alynx.showmethekey|showmethekey-gtk)$",
    },
    float = true,
    pin = true,
  },

  {
    name = "float-media-players",
    match = {
      class = "^(imv|mpv|danmufloat|termfloat|nemo|ncmpcpp)$",
    },
    float = true,
    size = "(monitor_w*0.35) (monitor_h*0.65)",
    persistent_size = true,
    center = true,
  },
}

for _, rule in ipairs(rules) do
  hl.window_rule(rule)
end
