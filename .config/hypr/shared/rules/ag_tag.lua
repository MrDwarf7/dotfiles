--- Aggregate tag → effect rules.
--- Pattern per app: tag assignment rule(s) first, then effect rules that match the tag.
--- Effects include: opacity, float, size, workspace, border, persistent_size, etc.

return {
  -- ════════════════════════════════════════════
  -- AFFiNE (document editor)
  -- class: AFFiNE.* → tag:affine
  -- ════════════════════════════════════════════
  {
    name = "tag-affine",
    match = {
      class = "^(AFFiNE.*)$",
      initial_class = "^(AFFiNE.*)$",
      title = "^(AFFiNE.*)$",
      initial_title = "^(AFFiNE.*)$",
    },
    tag = "+affine",
  },
  {
    name = "tagged-affine",
    match = { tag = "affine" },
    opacity = "1.0 override 1.0 override",
    persistent_size = true,
  },
  {
    name = "workspace-affine",
    match = { tag = "affine" },
    float = false,
    workspace = "5 silent",
    persistent_size = true,
  },

  -- ════════════════════════════════════════════
  -- Chromium
  -- class: chromium → tag:chromium | chromiumDevtools
  -- ════════════════════════════════════════════
  {
    name = "tag-chromium",
    match = { class = "^([cC]hromium)$" },
    tag = "+chromium",
  },
  {
    name = "workspace-tagged-chromium",
    match = { tag = "chromium" },
    workspace = "1 silent",
    size = "2660 1300",
    persistent_size = true,
  },
  {
    name = "tag-chromium-devtools",
    match = { class = "^([cC]hromium)$", initial_title = "^(Devtools)$" },
    tag = "+chromiumDevtools",
  },
  {
    name = "float-tagged-chromium-devtools",
    match = { tag = "chromiumDevtools" },
    float = true,
    center = true,
    size = "2030 1060",
    persistent_size = true,
  },

  -- ════════════════════════════════════════════
  -- DaVinci Control Panels
  -- class: DaVinci Control Panels Setup → tag:daviniciPanels
  -- NOTE: float+center+size handled by ag_float.lua catch-all + size group
  -- ════════════════════════════════════════════
  {
    name = "tag-davinici-panels",
    match = {
      class = "^(DaVinci Control Panels Setup)$",
      initial_class = "^(DaVinci Control Panels Setup)$",
      title = "^(DaVinci Control Panels Setup)$",
      initial_title = "^(DaVinci Control Panels Setup)$",
    },
    tag = "+daviniciPanels",
  },
  {
    name = "tagged-davinici-panels",
    match = { tag = "daviniciPanels" },
    opacity = "1.0 override 1.0 override",
  },

  -- ════════════════════════════════════════════
  -- Discord + forks
  -- class: discord | armcord | webcord | vencord | vesktop → tag:discordForksClass
  -- ════════════════════════════════════════════
  {
    name = "tag-discordForksClass",
    match = { class = "^([dD]iscord|[aA]rmcord|[wW]ebcord|[vV]encord|[vV]esktop)$" },
    tag = "+discordForksClass",
  },
  {
    name = "style-discordForksClass",
    match = { tag = "discordForksClass" },
    opacity = "0.90 override 0.60 override",
    workspace = "9 silent",
    maximize = true,
  },

  -- ════════════════════════════════════════════
  -- Free Download Manager (kt)
  -- class: org.kde.freedownloadmanager → tag:kt
  -- NOTE: float+center+size handled by ag_float.lua catch-all + size group
  -- ════════════════════════════════════════════
  {
    name = "tag-kt",
    match = { class = "^org\\.kde\\.freedownloadmanager$" },
    tag = "+kt",
  },

  -- ════════════════════════════════════════════
  -- Ghostty terminal
  -- class: com.mitchellh.ghostty → tag:ghostty
  -- ════════════════════════════════════════════
  {
    name = "tag-ghostty",
    match = { class = "^(com\\.mitchellh\\.ghostty)$" },
    tag = "+ghostty",
  },
  {
    name = "float-tagged-ghostty",
    match = { tag = "ghostty" },
    float = false,
    center = true,
    size = "2560 1330",
    persistent_size = true,
  },
  {
    name = "float-tagged-ghostty-no-border",
    match = { tag = "ghostty", float = true },
    border_size = 0,
  },
  {
    name = "tagged-ghostty-no-border",
    match = { tag = "ghostty" },
    border_size = 0,
  },

  -- ════════════════════════════════════════════
  -- JetBrains IDEs
  -- class: jetbrains-.+ → tag:jb
  -- ════════════════════════════════════════════
  {
    name = "tag-jb",
    match = { class = "^(jetbrains-.+)$" },
    tag = "+jb",
  },
  {
    name = "workspace-jb",
    match = { tag = "jb" },
    workspace = "3 silent",
  },
  {
    name = "jb-toolbox-menus-fix",
    match = { class = "^(.*jetbrains.*)$", title = "^(win.*)$" },
    no_initial_focus = true,
    no_focus = true,
  },
  {
    name = "jb-tab-dragging-fix",
    match = { class = "^(.*jetbrains.*)$", title = "^\\\\s$" },
    no_initial_focus = true,
    no_focus = true,
  },
  {
    name = "jb-tab-dragging-fix-2",
    match = { class = "^(jetbrains-.+)$", tag = "jb", float = 1 },
    stay_focused = true,
    no_initial_focus = true,
  },

  -- ════════════════════════════════════════════
  -- Limo (mod manager)
  -- class: limo → tag:limo
  -- NOTE: float+center+size handled by ag_float.lua catch-all + size group
  --       install-mod sub-rule kept here (title-based, not in catch-all)
  -- ════════════════════════════════════════════
  {
    name = "tag-limo",
    match = { class = "^(limo)$", initial_class = "^(limo)$" },
    tag = "+limo",
  },
  {
    name = "float-tagged-limo-install-mod",
    match = { class = "^(limo)$", title = "^(Install Mod)$" },
    size = "800 600",
  },

  -- ════════════════════════════════════════════
  -- Obsidian (mini-window float)
  -- class: obsidian + title obsidian → tag:obsidianMini
  -- ════════════════════════════════════════════
  {
    name = "tag-obsidian-mini",
    match = { class = "^([oO]bsidian)$", title = "^([oO]bsidian)$" },
    tag = "+obsidianMini",
  },
  {
    name = "float-tagged-obsidian-mini",
    match = { tag = "obsidianMini" },
    float = true,
    persistent_size = true,
  },

  -- ════════════════════════════════════════════
  -- Polychromatic (Razer config)
  -- class: polychromatic → tag:polychromatic
  -- NOTE: float+center+size handled by ag_float.lua catch-all + size group
  --       device-info sub-rule kept here (title-based, not in catch-all)
  -- ════════════════════════════════════════════
  {
    name = "tag-polychromatic",
    match = { class = "^(polychromatic)$" },
    tag = "+polychromatic",
  },
  {
    name = "size-polychromatic-device-info",
    match = { class = "^(polychromatic)$", title = "^(Device Information - .+)$" },
    size = "200 400",
  },

  -- ════════════════════════════════════════════
  -- qBittorrent
  -- class: org.qbittorrent.qBittorrent → tag:torrent
  -- ════════════════════════════════════════════
  {
    name = "float-qBittorrent-torrent",
    match = { class = "^(org.qbittorrent.qBittorrent)$" },
    tag = "+torrent",
  },
  {
    name = "float-qBittorrent-torrent-window",
    match = { tag = "torrent", initial_title = "^[(^qBittorrent v.*)]$" },
    float = true,
    persistent_size = true,
  },

  -- ════════════════════════════════════════════
  -- RimWorld
  -- class: RimWorldLinux → tag:rimworld
  -- ════════════════════════════════════════════
  {
    name = "tag-rimworld",
    match = { class = "^([rR]im[wW]orld[lL]inux)$" },
    tag = "+rimworld",
  },
  {
    name = "tagged-rimworld-generic",
    match = { tag = "rimworld" },
    opacity = "1.0 override 1.0 override",
    persistent_size = true,
    border_size = 0,
  },
  {
    name = "float-tagged-rimworld",
    match = { tag = "rimworld" },
    size = "5120 1440",
    fullscreen = true,
  },

  -- ════════════════════════════════════════════
  -- Thunderbird
  -- class + title Write: → tag:thunderbird-write
  -- class + initial_title Mozilla Thunderbird → tag:thunderbird-workspace
  -- ════════════════════════════════════════════
  {
    name = "tag-thunderbird-write",
    match = { class = "^(org.mozilla.Thunderbird)$", title = "^(Write:\\\\s.*)$" },
    tag = "+thunderbird-write",
  },
  {
    name = "tag-workspace-thunderbird",
    match = { class = "^(org.mozilla.Thunderbird)$", initial_title = "^(Mozilla\\\\sThunderbird)$" },
    tag = "+thunderbird-workspace",
  },
  {
    name = "tagged-thunderbird-write",
    match = { tag = "thunderbird-write" },
    opacity = "1.0 override 1.0 override",
    persistent_size = true,
  },
  {
    name = "workspace-thunderbird",
    match = { tag = "thunderbird-workspace" },
    workspace = "3 silent",
  },
  {
    name = "float-tagged-thunderbird-write",
    match = { tag = "thunderbird-write" },
    float = true,
    center = true,
    size = "1600 900",
  },

  -- ════════════════════════════════════════════
  -- ueberzugpp (image overlay for nvim)
  -- class: ueberzugpp_.* → tag:ueberzugpp_nvim
  -- ════════════════════════════════════════════
  {
    name = "tag-ueberzugpp",
    match = {
      class = "^(ueberzugpp_.*)$",
      initial_class = "^(ueberzugpp_.*)$",
      title = "^(ueberzugpp_.*)$",
      initial_title = "^(ueberzugpp_.*)$",
    },
    tag = "+ueberzugpp_nvim",
  },
  {
    name = "float-tagged-ueberzugpp",
    match = { tag = "ueberzugpp_nvim" },
    opacity = "1.0 override 1.0 override",
  },
  {
    name = "no-initial-focus-tagged-ueberzugpp",
    match = { tag = "ueberzugpp_nvim" },
    no_initial_focus = true,
    persistent_size = true,
  },

  -- ════════════════════════════════════════════
  -- XDG Desktop Portal (GTK)
  -- class: xdg-desktop-portal-gtk → tag:portal_xdg
  -- NOTE: float+center+size handled by ag_float.lua catch-all + size group
  -- ════════════════════════════════════════════
  {
    name = "tag-xdg-portal-gtk",
    match = {
      class = "^(xdg-desktop-portal-gtk)$",
      initial_class = "^(xdg-desktop-portal-gtk)$",
    },
    tag = "+portal_xdg",
  },

  -- ════════════════════════════════════════════
  -- YouTube Music
  -- class: com.github.th_ch.youtube → tag:ytm
  -- ════════════════════════════════════════════
  {
    name = "tag-ytm",
    match = { class = "^com\\.github\\.th\\.ch\\.youtube.+$" },
    tag = "+ytm",
  },
  {
    name = "workspace-tagged-ytm",
    match = { tag = "ytm" },
    workspace = "8 silent",
  },
  {
    name = "float-tagged-ytm",
    match = { tag = "ytm" },
    center = true,
    size = "1250 850",
    persistent_size = true,
    maximize = true,
  },

  -- ════════════════════════════════════════════
  -- Zathura PDF viewer
  -- class: org.pwmt.zathura → tag:zathura
  -- NOTE: float+center+size handled by ag_float.lua catch-all + size group
  -- ════════════════════════════════════════════
  {
    name = "tag-zathura",
    match = { class = "^(org.pwmt.zathura)$" },
    tag = "+zathura",
  },
  {
    name = "tagged-zathura-generic",
    match = { tag = "zathura" },
    opacity = "1.0 override 1.0 override",
    persistent_size = true,
  },

  -- ════════════════════════════════════════════
  -- Zed editor
  -- class: dev.zed.zed → tag:zedEditor | zedEditorSettings
  -- ════════════════════════════════════════════
  {
    name = "tag-zed-editor",
    match = { class = "^(dev.[zZ]ed\\\\.?[zZ]ed)$" },
    tag = "+zedEditor",
  },
  {
    name = "tag-zed-editor-settings",
    match = { class = "^(dev.[zZ]ed\\\\.?[zZ]ed)$", title = "^(Zed\\\\s(.*)[sS]ettings)$" },
    tag = "+zedEditorSettings",
  },
  {
    name = "workspace-zed-editor",
    workspace = "3 silent",
    no_initial_focus = true,
  },
  {
    name = "pseudo-zed-editor",
    match = { tag = "zedEditor" },
    persistent_size = true,
    size = "2950 1350",
    opacity = "1.0 override 0.85 override",
  },
  {
    name = "float-zed-editor-settings",
    match = { tag = "zedEditorSettings" },
    persistent_size = true,
    size = "1050 1050",
    float = true,
    opacity = "1.0 override 1.0 override",
  },

  -- ════════════════════════════════════════════
  -- Zen browser
  -- class: zen(-browser)? → tag:zbrowserInitClass
  -- ════════════════════════════════════════════
  {
    name = "tag-zed-browser",
    match = {
      class = "^[zZ]en(-?[bB]rowser)?$",
      title = "^[zZ]en(-?[bB]rowser)?$",
    },
    tag = "+zbrowserInitClass",
  },
  {
    name = "workspace-zed-browser",
    match = { tag = "zbrowserInitClass" },
    workspace = "1 silent",
  },
  {
    name = "opacity-zed-browser",
    match = { tag = "zbrowserInitClass" },
    opacity = "1.0 override 1.0 override",
  },

  -- ════════════════════════════════════════════
  -- Feh image viewer
  -- class: feh → tag:feh
  -- NOTE: float+center handled by ag_float.lua catch-all (no specific size)
  -- ════════════════════════════════════════════
  {
    name = "tag-feh",
    match = { class = "^(feh)$" },
    tag = "+feh",
  },

  -- ════════════════════════════════════════════
  -- Vivaldi webapp: Grok
  -- class: vivaldi-*-Default + title Grok → tag:vwebapp-grok
  -- ════════════════════════════════════════════
  {
    name = "tag-vivaldi-webapp-grok",
    match = {
      class = "^([vV]ivaldi)(-)(.*)(-)([dD]efault)$",
      initial_class = "^([vV]ivaldi)(-)(.*)(-)([dD]efault)$",
      title = "^([gG]rok)$",
      initial_title = "^([gG]rok)$",
    },
    tag = "+vwebapp-grok",
  },
  {
    name = "vivaldi-webapp-grok",
    match = { tag = "vwebapp-grok" },
    size = "1000 1300",
    move = "20 95",
    pseudo = false,
    float = false,
    persistent_size = true,
  },

  -- ════════════════════════════════════════════
  -- Vivaldi webapp: Calendly
  -- class: vivaldi-*-Default + title Calendly → tag:vivaldi_calendly
  -- ════════════════════════════════════════════
  {
    name = "tag-vivaldi-calendly",
    match = {
      class = "^(vivaldi-.*-[dD]efault)$",
      initial_class = "^(vivaldi-.*-[dD]efault)$",
      title = "^([cC]alendly.*)$",
      initial_title = "^([cC]alendly.*)$",
    },
    tag = "+vivaldi_calendly",
  },
  {
    name = "float-tagged-vivaldi-calendly",
    match = { class = "^(vivaldi-.*-[dD]efault)$", tag = "vivaldi_calendly" },
    float = true,
    center = true,
    size = "1105 1150",
  },
}
