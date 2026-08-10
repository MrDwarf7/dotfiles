--- Linear window rules. tickets bucket.
--- TODO: verify the class/regex below matches Linear's actual window class.

local bkt = require("shared.rules.buckets")
local v = bkt:get("tickets")

bkt.assign_bucket({ class = "[lL]inear" }, v.bucket)
