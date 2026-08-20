--- AlecaFrame / Overwolf window rules.
--- Three distinct window types: quick launcher, spawn window, AlecaFrame.

local v = {
  class_rgx = "^(overwolf.exe)$",
  ws = "8 silent",
  opacity = "1.0 override 1.0 override",
}

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  --- Overwolf Quick Launcher.
  {
    name = "tag-overwolf-quick-launcher",
    match = {
      class = v.class_rgx,
      title = "^(Overwolf Quick Launcher)$",
      initial_class = v.class_rgx,
      initial_title = "^(Overwolf Quick Launcher)$",
    },
    tag = "+overwolf-overwolf-quick-launcher",
  },

  {
    name = "effect-overwolf-quick-launcher",
    match = { tag = "overwolf-overwolf-quick-launcher" },
    workspace = v.ws,
    opacity = v.opacity,
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
    workspace = v.ws,
    opacity = v.opacity,
  },

  --- AlecaFrame.
  {
    name = "tag-alecaframe",
    match = {
      class = v.class_rgx,
      title = "^(AlecaFrame)$",
      initial_class = v.class_rgx,
      initial_title = "^(AlecaFrame)$",
    },
    tag = "+overwolf-alecaframe",
  },

  {
    name = "effect-alecaframe",
    match = { tag = "overwolf-alecaframe" },
    workspace = v.ws,
    opacity = v.opacity,
    maximize = true,
  },
}

require("utils.lst").map(rules, hl.window_rule)
