--- VS Code window rules.

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  -- TODO: [tags] : gui_editors

  {
    name = "opacity-code",
    match = { class = "^(code)$" },
    opacity = "1.0 override 1.0 override",
  },
}

for _, rule in ipairs(rules) do
  hl.window_rule(rule)
end
