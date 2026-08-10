--- AFFiNE window rules. tickets bucket (corrected from notes).

local bkt = require("shared.rules.buckets")
local v = bkt:get("tickets")

bkt.assign_bucket({ class = "AFFiNE.*" }, v.bucket)
