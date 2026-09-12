local bkt = require("shared.rules.buckets")
local v = bkt:get("browsers")

bkt.assign_bucket({ initial_class = "^([hH]elium)$" }, v.bucket)
bkt.assign_bucket({ class = "^([hH]elium)$" }, v.bucket)

-- TODO: [browser_floats] : need to add very broad/generic handling
-- for browser floats like sign-in windows and such at some point.

-- ---@type HyprConfig.HL.WindowRuleSpec[]
-- local rules = {
--   {
--   },
-- }
--
-- require("utils.lst").map(rules, hl.window_rule)
