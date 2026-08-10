--- Faugus Launcher window rules. gaming bucket.
--- TODO: verify class.

local bkt = require("shared.rules.buckets")
local v = bkt:get("gaming")

bkt.assign_bucket({ class = "[fF]augus" }, v.bucket)
