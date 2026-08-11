-- Window 564510e14030 -> Functions — Qalculate!:
-- 	class: io.github.Qalculate.qalculate-qt
-- 	title: Functions — Qalculate!
-- 	initialClass: io.github.Qalculate.qalculate-qt
-- 	initialTitle: Functions — Qalculate!

local rgx = "^(io.github.[qQ]alculate.[qQ]alculate.*)$"

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {

  -- Core application
  {
    name = "tag-qalculate",
    match = { class = rgx },
    tag = "+qalculate",
  },
  {
    name = "effect-qalculate",
    match = { tag = "qalculate" },
    center = true,
    float = true,
    border_size = 0,
    no_anim = true,
    no_blur = true,
    opacity = "1.0 override 1.0 override",
    size = "600 900",
  },

  -- Functions sub-window
  {
    name = "tag-qalculate-functions",
    match = { class = rgx, title = "^(Functions.*)$" },
    tag = "+qalculate-functions",
  },
  {
    name = "effect-qalculate-functions",
    match = { tag = "qalculate-functions" },
    center = true,
    float = true,
    border_size = 0,
    no_anim = true,
    no_blur = true,
    opacity = "1.0 override 1.0 override",
    size = "780 960",
  },
}

require("utils.lst").map(rules, hl.window_rule)
