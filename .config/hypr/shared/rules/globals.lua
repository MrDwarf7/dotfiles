--- Global window rules applied to all windows.

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  --- Disable maximize events globally.
  {
    name = "suppress-event",
    match = { class = ".*" },
    suppress_event = "maximize",
  },

  --- No border on floating windows.
  {
    name = "no-floating-border",
    match = { float = true },
    border_size = 0,
  },
}

require("utils.lst").map(rules, hl.window_rule)
