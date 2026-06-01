return {

-- stylua: ignore start
-- Floating
-- { match = { title = "^(Open File)(.*)$" },                       center = true },
{ match = { title = "^(Open File)(.*)$" },                       float = true, center = true},
-- { match = { title = "^(Select a File)(.*)$" },                   center = true },
{ match = { title = "^(Select a File)(.*)$" },                   float = true, center = true},
-- { match = { title = "^(Choose wallpaper)(.*)$" },                center = true },
{ match = { title = "^(Choose wallpaper)(.*)$" },                float = true, center = true},
{ match = { title = "^(Choose wallpaper)(.*)$" },                size = {"(monitor_w*0.60)", "(monitor_h*0.65)"}  },
-- { match = { title = "^(Open Folder)(.*)$" },                     center = true },
{ match = { title = "^(Open Folder)(.*)$" },                     float = true, center = true},
-- { match = { title = "^(Save As)(.*)$" },                         center = true },
{ match = { title = "^(Save As)(.*)$" },                         float = true, center = true},
-- { match = { title = "^(Library)(.*)$" },                         center = true },
{ match = { title = "^(Library)(.*)$" },                         float = true, center = true},
-- { match = { title = "^(File Upload)(.*)$" },                     center = true },
{ match = { title = "^(File Upload)(.*)$" },                     float = true, center = true},
-- { match = { title = "^(.*)(wants to save)$" },                   center = true },
{ match = { title = "^(.*)(wants to save)$" },                   float = true, center = true},
-- { match = { title = "^(.*)(wants to open)$" },                   center = true },
{ match = { title = "^(.*)(wants to open)$" },                   float = true, center = true},
{ match = { class = "^(blueberry\\.py)$" },                      float = true },
{ match = { class = "^(guifetch)$" },                            float = true },
-- { match = { class = "^(pavucontrol)$" },                         center = true },
{ match = { class = "^(pavucontrol)$" },                         float = true, center = true},
{ match = { class = "^(pavucontrol)$" },                         size = {"(monitor_w*0.45)", "(monitor_h*0.45)"}  },
-- { match = { class = "^(org.pulseaudio.pavucontrol)$" },          center = true },
{ match = { class = "^(org.pulseaudio.pavucontrol)$" },          float = true, center = true},
{ match = { class = "^(org.pulseaudio.pavucontrol)$" },          size = {"(monitor_w*0.45)", "(monitor_h*0.45)"}  },
-- { match = { class = "^(nm-connection-editor)$" },                center = true },
{ match = { class = "^(nm-connection-editor)$" },                float = true, center = true},
{ match = { class = "^(nm-connection-editor)$" },                size = {"(monitor_w*0.45)", "(monitor_h*0.45)"}  },
{ match = { class = ".*plasmawindowed.*" },                      float = true },
{ match = { class = "kcm_.*" },                                  float = true },
{ match = { class = ".*bluedevilwizard" },                       float = true },
{ match = { title = ".*Welcome" },                               float = true },
{ match = { title = ".*Shell conflicts.*" },                     float = true },
{ match = { class = "org.freedesktop.impl.portal.desktop.kde" }, float = true },
{ match = { class = "org.freedesktop.impl.portal.desktop.kde" }, size = {"(monitor_w*0.60)", "(monitor_h*0.65)"}  },
{ match = { class = "^(Zotero)$" },                              float = true },
{ match = { class = "^(Zotero)$" },                              size = {"(monitor_w*0.45)", "(monitor_h*0.45)"}  },

-- Picture-in-Picture
{ match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" }, float = true },
{ match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" }, keep_aspect_ratio = true },
{ match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" }, move = {"(monitor_w*0.73)", "(monitor_h*0.72)"}  },
{ match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" }, size = {"(monitor_w*0.25)", "(monitor_h*0.25)"}  },
{ match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" }, float = true },
{ match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" }, pin = true },

-- Screen sharing
{ match = { title = ".*is sharing (a window|your screen).*" }, float = true },
{ match = { title = ".*is sharing (a window|your screen).*" }, pin = true },
{ match = { title = ".*is sharing (a window|your screen).*" }, move = {"(monitor_w*.5-window_w*.5)", "(monitor_h-window_h-12)"}  },

-- --- Tearing ---
{ match = { title = ".*\\.exe" }, immediate = true },
{ match = { title = ".*minecraft.*" }, immediate = true },
{ match = { class = "^(steam_app).*" }, immediate = true },

-- Launchers need to be FAST
{ match = { namespace = "gtk4-layer-shell" }, no_anim = true },

  -- stylua: ignore end
}
