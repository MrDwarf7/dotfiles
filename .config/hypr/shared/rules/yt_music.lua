--- YouTube Music (and Pear fork) window rules.

local bkt = require("shared.rules.buckets")
local v = bkt:get("music")

--- Music bucket covers WS8 + maximize (size/persist/center dropped per bucket).
bkt.assign_bucket({ class = "com.github.th_ch.youtube.+" }, v.bucket)
