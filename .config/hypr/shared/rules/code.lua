--- VS Code window rules.

local bkt = require("shared.rules.buckets")
local v = bkt:get("gui_editors")

--- gui_editors bucket covers WS3 + opacity + no_initial_focus + persistent size.
bkt.assign_bucket({ class = "^(code)$" }, v.bucket)
