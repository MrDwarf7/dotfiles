--- AlecaFrame / Overwolf window rules.
--- Three distinct window types: quick launcher, spawn window, AlecaFrame.

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  --- Overwolf Quick Launcher.
  {
    name = "tag-overwolf-quick-launcher",
    match = {
      class = "^(overwolf.exe)$",
      title = "^(Overwolf Quick Launcher)$",
      initial_class = "^(overwolf.exe)$",
      initial_title = "^(Overwolf Quick Launcher)$",
    },
    tag = "+overwolf-overwolf-quick-launcher",
  },

  {
    name = "effect-overwolf-quick-launcher",
    match = { tag = "overwolf-overwolf-quick-launcher" },
    workspace = "8 silent",
    opacity = "1.0 override 1.0 override",
  },

  {
    name = "tag-overwolf-spawn-window",
    match = {
      class = "^(explorer.exe)$",
      title = "^()$",
      initial_class = "^(explorer.exe)$",
      initial_title = "^()$",
    },
    tag = "+overwolf-spawn-window",
  },

  {
    name = "effect-overwolf-spawn-window",
    match = { tag = "overwolf-spawn-window" },
    workspace = "8 silent",
    opacity = "1.0 override 1.0 override",
  },

  --- AlecaFrame.
  {
    name = "tag-alecaframe",
    match = {
      class = "^(overwolf.exe)$",
      title = "^(AlecaFrame)$",
      initial_class = "^(overwolf.exe)$",
      initial_title = "^(AlecaFrame)$",
    },
    tag = "+overwolf-alecaframe",
  },

  {
    name = "effect-alecaframe",
    match = { tag = "overwolf-alecaframe" },
    workspace = "8 silent",
    opacity = "1.0 override 1.0 override",
    maximize = true,
  },
}

for _, rule in ipairs(rules) do
  hl.window_rule(rule)
end
