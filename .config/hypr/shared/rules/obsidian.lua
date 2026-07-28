--- Obsidian window rules.
--- Tag + subs pattern for mini window.

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  -- TODO: [tags] : notes

  {
    name = "tag-obsidian",
    match = { class = "[oO]bsidian" },
    tag = "+obsidian",
  },

  {
    name = "effect-obsidian",
    match = { tag = "obsidian" },
    workspace = "5 silent",
    persistent_size = true,
    float = false,
  },

  --- Mini window (title matches Obsidian itself).
  {
    name = "tag-obsidian-mini",
    match = {
      class = "[oO]bsidian",
      title = "[oO]bsidian",
    },
    tag = "+obsidianMini",
  },

  {
    name = "effect-obsidian-mini",
    match = { tag = "obsidianMini" },
    persistent_size = true,
    float = true,
  },
}

for _, rule in ipairs(rules) do
  hl.window_rule(rule)
end
