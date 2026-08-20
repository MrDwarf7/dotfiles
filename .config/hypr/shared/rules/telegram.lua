--- Telegram window rules. private_comms bucket + persistent size extra.

local bkt = require("shared.rules.buckets")
local v = bkt:get("private_comms")

local rgx = "QQ|Telegram|org.telegram.desktop"

bkt.assign_bucket({ class = rgx }, v.bucket)

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  {
    name = "extra-telegram-persist",
    match = { class = rgx },
    persistent_size = true,
  },
}

require("utils.lst").map(rules, hl.window_rule)
