--- WezTerm terminal window rules.
--- TODO: verify class once installed/observed.

local bkt = require("shared.rules.buckets")
local v = bkt:get("terminals")

--- Old behavior (pre-bucket): float + center + size "2280 1000".
--- TODO: re-add float/center/size extras here if wezterm should float, or leave tiled.
bkt.assign_bucket({ class = "^(org.wezfurlong.wezterm)$" }, v.bucket)
