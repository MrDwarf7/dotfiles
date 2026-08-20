--- Obsidian window rules. Notes bucket + mini-window sub-tag.

-- TODO: Ensure regex! -- cannot check hyprctl currently!

local bkt = require("shared.rules.buckets")
local v = bkt:get("notes")

local rgx = "[oO]bsidian"

bkt.assign_bucket({ class = rgx }, v.bucket)

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  {
    name = "tag-obsidian-mini",
    match = { class = rgx, title = rgx },
    tag = "+obsidianMini",
  },
  {
    name = "effect-obsidian-mini",
    match = { tag = "obsidianMini" },
    float = true,
    persistent_size = true,
  },
}

require("utils.lst").map(rules, hl.window_rule)
