--- Prepped from a_yoinked.lua — NOT YET INCLUDED IN INIT.LUA.
--- Generic floating rules, PiP, screen sharing, tearing fixes, launcher speed.
--- Overlaps with existing rules — needs manual review before inclusion.
---
--- OVERLAP NOTES:
--- - pavucontrol: ag_float_size.lua has static 1000x650; yoinked has dynamic (monitor_w*0.45)
---   → Keep yoinked (dynamic), comment out static in ag_float_size.lua
--- - file dialogs / xdg portals / polkit: ag_popups.lua covers these
---   → ag_popups.lua is more complete (includes pinentry, zenity, stay-focused)
---   → Yoinked file dialogs are redundant; PiP and screen sharing are NEW
--- - PiP: ag_pip.lua is broken (hl.window_rule direct call, never applied)
---   → Yoinked PiP rules would fix this
--- - blueberry.py, guifetch, plasmawindowed, kcm_*, bluedevilwizard: NEW, no conflict
--- - tearing fixes (.exe, minecraft, steam_app): NEW, no conflict
--- - screen sharing pin: NEW, no conflict
--- - gtk4-layer-shell no_anim: NEW, no conflict

return {
  -- ════════════════════════════════════════════
  -- File dialogs (title-based, empty class)
  -- OVERLAP: ag_popups.lua has similar rules — review before enabling
  -- ════════════════════════════════════════════
  --[[
  { match = { title = "^(Open File)(.*)$" },                       float = true, center = true },
  { match = { title = "^(Select a File)(.*)$" },                   float = true, center = true },
  { match = { title = "^(Choose wallpaper)(.*)$" },                float = true, center = true },
  { match = { title = "^(Choose wallpaper)(.*)$" },                size = {"(monitor_w*0.60)", "(monitor_h*0.65)"}  },
  { match = { title = "^(Open Folder)(.*)$" },                     float = true, center = true },
  { match = { title = "^(Save As)(.*)$" },                         float = true, center = true },
  { match = { title = "^(Library)(.*)$" },                         float = true, center = true },
  { match = { title = "^(File Upload)(.*)$" },                     float = true, center = true },
  { match = { title = "^(.*)(wants to save)$" },                   float = true, center = true },
  { match = { title = "^(.*)(wants to open)$" },                   float = true, center = true },
  --]]

  -- ════════════════════════════════════════════
  -- Generic floating apps (class-based)
  -- OVERLAP: pavucontrol conflicts with ag_float_size.lua static sizing
  -- ════════════════════════════════════════════
  { match = { class = "^(blueberry\\.py)$" },                      float = true },
  { match = { class = "^(guifetch)$" },                            float = true },
  --[[
  -- pavucontrol: dynamic sizing (preferred over ag_float_size.lua static 1000x650)
  { match = { class = "^(pavucontrol)$" },                         float = true, center = true },
  { match = { class = "^(pavucontrol)$" },                         size = {"(monitor_w*0.45)", "(monitor_h*0.45)"}  },
  { match = { class = "^(org.pulseaudio.pavucontrol)$" },          float = true, center = true },
  { match = { class = "^(org.pulseaudio.pavucontrol)$" },          size = {"(monitor_w*0.45)", "(monitor_h*0.45)"}  },
  --]]
  { match = { class = "^(nm-connection-editor)$" },                float = true, center = true },
  { match = { class = "^(nm-connection-editor)$" },                size = {"(monitor_w*0.45)", "(monitor_h*0.45)"}  },

  -- ════════════════════════════════════════════
  -- KDE / Plasma compatibility
  -- NEW: no conflicts
  -- ════════════════════════════════════════════
  { match = { class = ".*plasmawindowed.*" },                      float = true },
  { match = { class = "kcm_.*" },                                  float = true },
  { match = { class = ".*bluedevilwizard" },                       float = true },
  { match = { title = ".*Welcome" },                               float = true },
  { match = { title = ".*Shell conflicts.*" },                     float = true },
  { match = { class = "org.freedesktop.impl.portal.desktop.kde" }, float = true },
  { match = { class = "org.freedesktop.impl.portal.desktop.kde" }, size = {"(monitor_w*0.60)", "(monitor_h*0.65)"}  },

  -- ════════════════════════════════════════════
  -- Zotero
  -- NEW: no conflicts
  -- ════════════════════════════════════════════
  { match = { class = "^(Zotero)$" },                              float = true },
  { match = { class = "^(Zotero)$" },                              size = {"(monitor_w*0.45)", "(monitor_h*0.45)"}  },

  -- ════════════════════════════════════════════
  -- Picture-in-Picture (title-based)
  -- OVERLAP: ag_pip.lua is broken (never applied) — this would replace it
  -- ════════════════════════════════════════════
  --[[
  { match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" }, float = true },
  { match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" }, keep_aspect_ratio = true },
  { match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" }, move = {"(monitor_w*0.73)", "(monitor_h*0.72)"}  },
  { match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" }, size = {"(monitor_w*0.25)", "(monitor_h*0.25)"}  },
  { match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" }, float = true },
  { match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" }, pin = true },
  --]]

  -- ════════════════════════════════════════════
  -- Screen sharing indicator (pin to top)
  -- NEW: no conflicts
  -- ════════════════════════════════════════════
  { match = { title = ".*is sharing (a window|your screen).*" }, float = true },
  { match = { title = ".*is sharing (a window|your screen).*" }, pin = true },
  { match = { title = ".*is sharing (a window|your screen).*" }, move = {"(monitor_w*.5-window_w*.5)", "(monitor_h-window_h-12)"}  },

  -- ════════════════════════════════════════════
  -- Tearing fixes (force immediate rendering)
  -- NEW: no conflicts
  -- ════════════════════════════════════════════
  { match = { title = ".*\\.exe" }, immediate = true },
  { match = { title = ".*minecraft.*" }, immediate = true },
  { match = { class = "^(steam_app).*" }, immediate = true },

  -- ════════════════════════════════════════════
  -- Launcher speed (disable animations)
  -- NEW: no conflicts
  -- ════════════════════════════════════════════
  { match = { namespace = "gtk4-layer-shell" }, no_anim = true },
}
