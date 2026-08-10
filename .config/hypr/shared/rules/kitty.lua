--- Kitty terminal window rules.
--- TODO: verify class once installed/observed.

local bkt = require("shared.rules.buckets")
local v = bkt:get("terminals")

--- Old behavior (pre-bucket): float + center + size "1280 720" + borderless.
--- TODO: re-add float/center/size extras here if kitty should float, or leave tiled.
bkt.assign_bucket({ class = "^(kitty)$" }, v.bucket)
