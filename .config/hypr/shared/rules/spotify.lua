--- Spotify window rules.

local bkt = require("shared.rules.buckets")
local v = bkt:get("music")

--- Music bucket covers WS8 + maximize (persist/center dropped from bucket).
bkt.assign_bucket({ class = "[sS]potify" }, v.bucket)
