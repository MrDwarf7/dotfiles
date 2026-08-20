--- Thunderbird window rules. Email bucket + compose-window sub-rule.

local bkt = require("shared.rules.buckets")
local v = bkt:get("email")

local rgx = "^(org.mozilla.[tT]hunderbird)$"

bkt.assign_bucket({ class = rgx }, v.bucket)

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  --- Compose/write windows: float + center + size + opacity.
  {
    name = "tag-thunderbird-write",
    match = { class = rgx, title = "^(Write:\\s.*)$" },
    tag = "+thunderbird-write",
  },
  {
    name = "effect-thunderbird-write",
    match = { tag = "thunderbird-write" },
    center = true,
    float = true,
    opacity = "1.0 override 1.0 override",
    persistent_size = true,
    size = "1600 900",
  },
}

require("utils.lst").map(rules, hl.window_rule)
