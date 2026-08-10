--- Chromium browser window rules. browsers bucket + devtools sub-window.

local bkt = require("shared.rules.buckets")
local v = bkt:get("browsers")

local rgx = "[cC]hromium"

bkt.assign_bucket({ class = rgx }, v.bucket)

--- Main window size (not covered by bucket).
hl.window_rule({ name = "size-chromium-main", match = { class = rgx }, size = "2660 1300" })

--- Devtools sub-window.
hl.window_rule({
  name = "tag-chromium-devtools",
  match = { class = rgx, title = "Devtools" },
  tag = "+chromiumDevtools",
})
hl.window_rule({
  name = "effect-chromium-devtools",
  match = { tag = "chromiumDevtools" },
  center = true,
  float = true,
  persistent_size = true,
})
