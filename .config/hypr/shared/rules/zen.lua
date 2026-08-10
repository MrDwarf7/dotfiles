--- Zen browser window rules.

local bkt = require("shared.rules.buckets")
local v = bkt:get("browsers")

bkt.assign_bucket({ class = "[zZ]en(-?[bB]rowser)?" }, v.bucket)
