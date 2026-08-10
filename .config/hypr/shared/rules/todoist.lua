--- Todoist window rules. notes bucket.
--- TODO: confirm window class/regex for Todoist desktop and uncomment the bucket call.

local bkt = require("shared.rules.buckets")
local v = bkt:get("notes")

-- bkt.assign_bucket({ class = "TODO_TODOIST_CLASS" }, v.bucket)
