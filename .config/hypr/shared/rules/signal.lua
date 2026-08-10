--- Signal window rules.

local bkt = require("shared.rules.buckets")
local v = bkt:get("private_comms")

bkt.assign_bucket({ class = "[sS]ignal" }, v.bucket)
