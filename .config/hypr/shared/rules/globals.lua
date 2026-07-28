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

for _, rule in ipairs(rules) do
  hl.window_rule(rule)
end
