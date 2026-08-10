--- File managers bucket membership.
--- Behavior (float + monitor-relative size + opacity) lives in buckets.lua
--- under the "file_managers" bucket. No workspace assignment.

local bkt = require("shared.rules.buckets")
local v = bkt:get("file_managers")

-- Thunar, dolphin, Nemo, etc. (not exhaustive)
bkt.assign_bucket({ class = "^([tT]hunar|nemo|dolphin)$" }, v.bucket)
