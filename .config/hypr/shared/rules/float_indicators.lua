--- Float indicators bucket membership (screen share overlays).
--- Behavior (float + pin) lives in buckets.lua under "float_indicators".
--- The screen-share position rule is extra (not part of the bucket), kept here.

local bkt = require("shared.rules.buckets")
local v = bkt:get("float_indicators")

local share_title = ".*is sharing (a window|your screen).*"

bkt.assign_bucket({ title = share_title }, v.bucket)

hl.window_rule({
  name = "position-screen-share",
  match = { title = share_title },
  move = { "(monitor_w*.5-window_w*.5)", "(monitor_h-window_h-12)" },
})
