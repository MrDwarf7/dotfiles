--- Thunderbird window rules. Email bucket + compose-window sub-rule.

local bkt = require("shared.rules.buckets")
local v = bkt:get("email")

local rgx = "^(org.mozilla.[tT]hunderbird)$"

bkt.assign_bucket({ class = rgx }, v.bucket)

--- Compose/write windows: float + center + size + opacity.
hl.window_rule({
  name = "tag-thunderbird-write",
  match = { class = rgx, title = "^(Write:\\s.*)$" },
  tag = "+thunderbird-write",
})
hl.window_rule({
  name = "effect-thunderbird-write",
  match = { tag = "thunderbird-write" },
  center = true,
  float = true,
  opacity = "1.0 override 1.0 override",
  persistent_size = true,
  size = "1600 900",
})
