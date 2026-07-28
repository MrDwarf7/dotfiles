--- Ghostty terminal window rules.

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  -- TODO: [tags] : terminals

  {
    name = "tag-ghostty",
    match = { class = "com\\.mitchellh\\.ghostty" },
    tag = "+ghostty",
  },

  {
    name = "effect-ghostty",
    match = { tag = "ghostty" },
    -- size = "2560 1330",
    persistent_size = true,
    -- opacity = "1.00 override 1.00 override",
    float = false,
    center = true,
    border_size = 0,
  },
}

for _, rule in ipairs(rules) do
  hl.window_rule(rule)
end
