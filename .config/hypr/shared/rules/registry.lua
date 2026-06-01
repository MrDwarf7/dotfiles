--- App registry: flat, minimal-pass window rule definitions.
---
--- All entries use named keys for clarity. Generators iterate with ipairs
--- and read fields by name, not position.
---
--- Attrs shorthand (boolean → full value):
---   opacity = true          → "1.0 override 1.0 override"
---   opacity = "X override"  → used as-is
---   persist = true          → persistent_size = true
---   no_float = true         → float = false
---   no_initial_focus = true → no_initial_focus = true
---   border_n = N            → border_size = N
---   maximize = true         → maximize = true
---   fullscreen = true       → fullscreen = true
---   pin = true              → pin = true

local M = {}

--------------------------------------------------------------------------------
-- Float + Center apps
-- All get tagged +floatCenter. Sizes applied via group rules in generator.
-- Fields: class, size, tag, attrs, subs
--------------------------------------------------------------------------------
-- stylua: ignore start

---@type HL.WindowRuleSpec
M.float_center = {
  { class = "blueman-manager",                  size = "1000 650"  },
  { class = "org.pulseaudio.pavucontrol",       size = "1000 650"  },
  { class = "io.github.Qalculate.qalculate-qt", size = "600 900"   },
  { class = "qt5ct",                            size = "960 540"   },
  { class = "AppImageLauncherSettings",         size = "1450 1000" },
  { class = "swappy",                           size = "2560 1200" },
  { class = "viewnior",                         size = "2560 1200" },
  { class = "keymapp",                          size = "1450 1000" },
  { class = "org\\.keepassxc\\.KeePassXC",      size = "1450 1000" },
  { class = "webapp-manager.py",                size = "1000 650"  },
  { class = "[tT]hunar|nemo|dolphin",           size = "1450 1000" },  -- Thunar, Nemo, Dolphin
  { class = "zmk-studio",                       size = "1450 1000" },
  { class = "WebApp-.*",                        size = "1450 1000" },

  { class = "org\\.kde\\.freedownloadmanager",  size = "1280 720",   tag = "kt" },
  { class = "xdg-desktop-portal-gtk",           size = "1680 1080",  tag = "portal_xdg" },
  { class = "com\\.danklinux\\.dms",            size = "1200 1250",  tag = "dms" },
  { class = "[fF]eh",                                                tag = "feh" },  -- feh

  {
    class = "waypaper",                         size = "1450 1000",
    attrs = { persist = true }
  },
  {
    class = "solaar",                           size = "1000 650",
    subs = {
      { title = "Solaar Rule Editor",           size = "600 500"   },
    },
  },
  {
    class = "polychromatic",                    size = "1050 950",    tag = "polychromatic",
    attrs = { opacity = true },
    subs = {
      { title = "Device Information", size = "200 400" },
    },
  },
  {
    class = "limo",                             size = "600 900",     tag = "limo",
    subs = {
      { title = "Install Mod",                  size = "800 600" },
    },
  },
  {
    class = "org\\.pwmt\\.zathura",             size = "1100 1300",   tag = "zathura",
    attrs = { opacity = true }
  },
}
-- stylua: ignore end

--------------------------------------------------------------------------------
-- Special float rules
-- Full rule tables, passed through verbatim by generator.
--------------------------------------------------------------------------------
M.special_float = {
  {
    name = "float-showmethekey",
    match = { class = "^(one.alynx.showmethekey|showmethekey-gtk)$" },
    float = true,
    pin = true,
  },
  {
    name = "center-wezterm",
    match = { class = "^(org\\.wezfurlong\\.wezterm)$" },
    center = true,
    size = "2280 1000",
  },
  {
    name = "float-media-players",
    match = { title = "^(imv|mpv|danmufloat|termfloat|nemo|ncmpcpp)$" },
    float = true,
    size = "960 540",
    move = { "monitor_w 25% - window_w / 2", "monitor_h 25% - window_h / 2" },
  },
  {
    name = "float-webapp-manager-title",
    match = { class = "^(webapp-manager.py)$", title = "^(Web Apps)$" },
    float = true,
    size = "1000 650",
  },
}

--------------------------------------------------------------------------------
-- Tag assignments + effects
-- Fields: class, tag, attrs, workspace, size, subs
-- subs = { { title, tag, attrs, workspace, size }, ... }
--------------------------------------------------------------------------------

-- stylua: ignore start
M.tags = {
  { class = "[cC]hromium",                                            tag = "chromium",            workspace = "1 silent",  size = "2660 1300",      attrs = { persist = true                                                                                                             }, subs = { { title = "Devtools",      tag = "chromiumDevtools",  attrs =  { persist = true, float = true, center = true  }                           } } },  -- Chromium
  { class = "dev\\.[zZ]ed\\.?[zZ]ed",                                 tag = "zedEditor",           workspace = "3 silent",  size = "2950 1350",      attrs = { persist = true, opacity = "1.00 override 0.85 override",    no_initial_focus = true                                        }, subs = { { title = "Zed.*Settings", tag = "zedEditorSettings", attrs =  { persist = true, float = true, opacity = true, size = " 1050 1050" }      } } },  -- Zed Editor
  { class = "ueberzugpp_.*",                                          tag = "ueberzugpp_nvim",                                                       attrs = { persist = true, opacity = "1.00 override 1.00 override",    no_initial_focus = true                                        }                                                                                                                                                          },
  { class = "org\\.qbittorrent\\.qBittorrent",                        tag = "torrent",                                                               attrs = { persist = true, opacity = "1.00 override 1.00 override",    float            = true,                                       }                                                                                                                                                          },
  { class = "vivaldi-.*-[dD]efault",                                  tag = "vivaldiWebapp",                                                         attrs = { persist = true, opacity = "1.00 override 1.00 override",    float            = true,                                       }                                                                                                                                                          },
  { class = "[oO]bsidian",                                            tag = "obsidian",            workspace = "5 silent",                           attrs = { persist = true,                                             no_float         = true                                        }, subs = { { title = "[oO]bsidian",   tag = "obsidianMini",      attrs =  { persist = true, float = true                 }                            } } },  -- Obsidian
  -- { class = "org.mozilla.Thunderbird",                                tag = "email",               workspace = "3 silent",                           attrs = { persist = true, opacity = true,    no_float         = true, center = false, stay_focused = false  }, subs = { { title = "Write:\\s.*",   tag = "thunderbird-write", attrs =  { persist = true, float = true, center = true, size = "1600 900" }          } } },  -- Thunerbird
  { class = "AFFiNE.*",                                               tag = "affine",              workspace = "5 silent",                           attrs = { persist = true, opacity = "1.00 override 1.00 override",    no_float         = true, center = true,                        }                                                                                                                                                          },
  { class = "com\\.mitchellh\\.ghostty",                              tag = "ghostty",                                      size = "2560 1330",      attrs = { persist = true, opacity = "1.00 override 1.00 override",    no_float         = true, center = true, border_n = 0           }                                                                                                                                                          },
  { class = "[rR]im[wW]orld[lL]inux",                                 tag = "rimworld",                                     size = "5120 1440",      attrs = { persist = true, opacity = "1.00 override 1.00 override",                     fullscreen     = true, border_n = 0           }                                                                                                                                                          },  -- RimWorld Linux
  { class = "[dD]iscord|[aA]rmcord|[wW]ebcord|[vV]encord|[vV]esktop", tag = "discordForksClass",   workspace = "9 silent",                           attrs = { persist = true, opacity = "0.90 override 0.60 override",                     maximize       = true                         }                                                                                                                                                          },  -- Discord, ArmCord, WebCord, Vencord, Vesktop
  { class = "com\\.github\\.th\\.ch\\.youtube.+",                     tag = "ytm",                 workspace = "8 silent",  size = "1250 850",       attrs = { persist = true, opacity = "1.00 override 1.00 override",                     maximize       = true                         }                                                                                                                                                          },
  { class = "[zZ]en(-?[bB]rowser)?",                                  tag = "zen",                 workspace = "1 silent",  size = "2030 1060",      attrs = { persist = true, opacity = "1.00 override 1.00 override",                                                                   }                                                                                                                                                          },  -- Zen Browser
  { class = "jetbrains-.+",                                           tag = "jb",                  workspace = "3 silent"                                                                                                                                                                                                                                                                                                                    },
}


--------------------------------------------------------------------------------
-- Workspace-only rules
-- Fields: class, workspace, attrs, size
--------------------------------------------------------------------------------
M.workspace = {
  { class = "Docker Desktop",                                                                      workspace = "7 silent",                           attrs = { persist = true,                                             no_initial_focus = true                                }                                                                                                                                                          },
  { class = "[sS]ignal",                                                                           workspace = "6 silent",  size = "1600 1250",      attrs = { persist = true,                                             no_initial_focus = true, float = false, center = true  }                                                                                                                                                          },  -- Signal
  { class = "QQ|Telegram|org\\.telegram\\.desktop",                                                workspace = "6 silent",  size = "1000 900",       attrs = { persist = true, opacity = "1.00 override 1.00 override",    no_initial_focus = true,                center = true  }                                                                                                                                                          },  -- QQ, Telegram
  { class = "[sS]potify",                                                                          workspace = "8 silent",                           attrs = { persist = true,                                                              maximize       = true                 }                                                                                                                                                          },  -- Spotify
}

--------------------------------------------------------------------------------
-- Popups and dialogs
--------------------------------------------------------------------------------
M.popups = {
  float = {
    { class = "^()$", title = "Save File|Open File" },
    { class = "xdg-desktop-portal-gtk|xdg-desktop-portal-kde|xdg-desktop-portal-hyprland|polkit-gnome-authentication-agent-1|hyprpolkitagent|org\\.org\\.kde\\.polkit-kde-authentication-agent-1|zenity" },
  },
  stay_focused = {
    { class = "pinentry-.*" },
    { class = "hyprpolkit(agent)?.*" },
  },
}

return M
-- stylua: ignore end
