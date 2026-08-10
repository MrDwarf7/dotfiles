--- Telegram window rules. private_comms bucket + persistent size extra.

local bkt = require("shared.rules.buckets")
local v = bkt:get("private_comms")

local rgx = "QQ|Telegram|org.telegram.desktop"

bkt.assign_bucket({ class = rgx }, v.bucket)

--- Persistent size (not covered by bucket).
hl.window_rule({
  name = "extra-telegram-persist",
  match = { class = rgx },
  persistent_size = true,
})
