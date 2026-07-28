--- Float + Center apps.
--- All follow the same pattern: match class, float, center, set size.
--- Loop over a data table instead of writing N identical rules.

---@type HyprConfig.FloatCenterApp[]
local apps = {
  -- stylua: ignore start
  { class = "blueman-manager",                      size = "1000 650" },
  { class = "org.pulseaudio.pavucontrol",           size = "1000 650" },
  { class = "io.github.Qalculate.qalculate-qt",     size = "600 900" },
  { class = "qt5ct",                                size = "960 540" },
  { class = "AppImageLauncherSettings",             size = "1450 1000" },
  { class = "swappy",                               size = "2560 1200" },
  { class = "keymapp",                              size = "1450 1000" },
  { class = "webapp-manager.py",                    size = "1000 650" },
  { class = "WebApp-.*",                            size = "1450 1000" },
  { class = "zmk-studio",                           size = "1450 1000" },
  { class = "[fF]eh",                               size = "1680 1080" }, -- feh
  { class = "org.kde.freedownloadmanager",          size = "1280 720" },
  { class = "viewnior",                             size = "(monitor_w*0.40) (monitor_h*0.60)" },
  { class = "com.danklinux.dms",                    size = "(monitor_w*0.20) (monitor_h*0.70)" },
  { class = "org.keepassxc.[kK]ee[pP]ass[xX][cC]",  size = "(monitor_w*0.30) (monitor_h*0.60)" }, -- keepassxc
  -- { class = "xdg-desktop-portal-gtk",               size = "(monitor_w*0.30) (monitor_h*0.60)" },
  { class = "xdg-desktop-portal-gtk",               size = "1680 1080" },
  -- stylua: ignore end
}

--- Creates a float + center rule for a given app. This is a helper function to reduce boilerplate.
---@param app HyprConfig.FloatCenterApp
---@return HyprConfig.HL.WindowRuleSpec
local make_float_center = function(app)
  return {
    name = "float-center-" .. app.class,
    match = {
      class = "^(" .. app.class .. ")$",
    },
    float = true,
    center = true,
    size = app.size,
  }
end

for _, app in ipairs(apps) do
  hl.window_rule(make_float_center(app))
end
