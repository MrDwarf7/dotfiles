--- Davinci Resolve rules.

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  {
    name = "tag-davinici-panels",
    match = { class = "^(Davinci Control Panels Setup)$" },
    tag = "+daviniciPanels",
  },
  {
    name = "effect-davinici-panels",
    match = { tag = "daviniciPanels" },
    center = true,
    float = true,
    opacity = "1.0 override 1.0 override",
    size = "1280 720",
  },
}

require("utils.lst").map(rules, hl.window_rule)
