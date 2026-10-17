--- Spotify window rules.

local bkt = require("shared.rules.buckets")
local v = bkt:get("music")

local rgx = "[sS]potify|[sS]potifast"

--- Music bucket covers WS8 + maximize (persist/center dropped from bucket).
bkt.assign_bucket({ class = rgx }, v.bucket)
