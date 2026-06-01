--- Aggregate float rules.
---
--- Architecture:
---   1. Tag assignment: big piped class match → tag = "+floatCenter"
---   2. Tag effect: match tag "floatCenter" → float = true, center = true
---   3. Size override groups apply per dimension (grouped where sizes match).
---   4. Special one-offs that don't fit the class-pipe pattern.
---
--- To add float+Center to a new app, just add its class to the pipe in
--- "float-center-tag" below. To change what float+Center means, edit the
--- "float-center-effect" rule.

return {
  -- ════════════════════════════════════════════
  -- Float + Center tag assignment
  -- All these classes get tagged +floatCenter.
  -- ════════════════════════════════════════════
  {
    name = "float-center-tag",
    match = {
      class = "^(blueman-manager|org.pulseaudio.pavucontrol|io.github.Qalculate.qalculate-qt|qt5ct|AppImageLauncherSettings|swappy|[vV]iewnior|waypaper|keymapp|org\\.keepassxc\\.KeePassXC|webapp-manager.py|solaar|WebApp-.*|DaVinci Control Panels Setup|org\\.kde\\.freedownloadmanager|polychromatic|limo|[fF]eh|org\\.pwmt\\.zathura|xdg-desktop-portal-gtk|[tT]hunar|nemo|dolphin|zmk-studio)$",
    },
    tag = "+floatCenter",
  },

  -- ════════════════════════════════════════════
  -- Float + Center effect (applied via tag)
  -- ════════════════════════════════════════════
  {
    name = "float-center-effect",
    match = { tag = "floatCenter" },
    float = true,
    center = true,
  },

  -- ════════════════════════════════════════════
  -- Size overrides (grouped by identical dimensions)
  -- ════════════════════════════════════════════

  -- 600x900
  {
    name = "size-600x900",
    match = { class = "^(io.github.Qalculate.qalculate-qt|limo)$" },
    size = "600 900",
  },

  -- 960x540
  {
    name = "size-960x540",
    match = { class = "^(qt5ct)$" },
    size = "960 540",
  },

  -- 1000x650
  {
    name = "size-1000x650",
    match = {
      class = "^(blueman-manager|org.pulseaudio.pavucontrol|webapp-manager.py|solaar)$",
    },
    size = "1000 650",
  },

  -- 1050x950 (polychromatic)
  {
    name = "size-1050x950",
    match = { class = "^(polychromatic)$" },
    size = "1050 950",
  },

  -- 1100x1300 (zathura)
  {
    name = "size-1100x1300",
    match = { class = "^(org.pwmt.zathura)$" },
    size = "1100 1300",
  },

  -- 1280x720 (kt, davinici panels)
  {
    name = "size-1280x720",
    match = {
      class = "^(org\\.kde\\.freedownloadmanager|DaVinci Control Panels Setup)$",
    },
    size = "1280 720",
  },

  -- 1450x1000
  {
    name = "size-1450x1000",
    match = {
      class = "^([tT]hunar|nemo|dolphin|AppImageLauncherSettings|waypaper|keymapp|zmk-studio|org\\.keepassxc\\.KeePassXC|WebApp-.*)$",
    },
    size = "1450 1000",
  },

  -- 1680x1080 (xdg-portal)
  {
    name = "size-1680x1080",
    match = { class = "^(xdg-desktop-portal-gtk)$" },
    size = "1680 1080",
  },

  -- 2560x1200 (swappy, viewnior)
  {
    name = "size-2560x1200",
    match = { class = "^(swappy|[vV]iewnior)$" },
    size = "2560 1200",
  },

  -- ════════════════════════════════════════════
  -- Special float rules (don't fit the class-pipe pattern)
  -- ════════════════════════════════════════════

  -- Show Me The Key: float + pin (no fixed size)
  {
    name = "float-showmethekey",
    match = { class = "^(one.alynx.showmethekey|showmethekey-gtk)$" },
    float = true,
    pin = true,
  },

  -- Media players (title-based match)
  {
    name = "float-media-players",
    match = { title = "^(imv|mpv|danmufloat|termfloat|nemo|ncmpcpp)$" },
    float = true,
    size = "960 540",
    move = { "monitor_w 25% - window_w / 2", "monitor_h 25% - window_h / 2" },
  },

  -- WezTerm: centered but NOT floating
  {
    name = "center-wezterm",
    match = { class = "^(org\\.wezfurlong\\.wezterm)$" },
    center = true,
    size = "2280 1000",
  },
}
