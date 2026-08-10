--- Obsidian window rules. Notes bucket + mini-window sub-tag.

local bkt = require("shared.rules.buckets")
local v = bkt:get("notes")

local rgx = "[oO]bsidian"

bkt.assign_bucket({ class = rgx }, v.bucket)

--- Mini window (title matches Obsidian itself): float + persistent size.
hl.window_rule({
  name = "tag-obsidian-mini",
  match = { class = rgx, title = rgx },
  tag = "+obsidianMini",
})
hl.window_rule({
  name = "effect-obsidian-mini",
  match = { tag = "obsidianMini" },
  float = true,
  persistent_size = true,
})
