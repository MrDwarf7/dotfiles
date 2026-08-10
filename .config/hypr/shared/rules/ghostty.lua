--- Ghostty terminal window rules.

local bkt = require("shared.rules.buckets")
local v = bkt:get("terminals")

--- Terminals bucket covers borderless + persistent size.
--- (Old effect had contradictory center=true/float=false on a tiled window; omitted.)
bkt.assign_bucket({ class = "com.mitchellh.ghostty" }, v.bucket)
