--- Steam window rules.
--- Main window -> gaming bucket (WS4). Child windows kept as separate tags.

local bkt = require("shared.rules.buckets")
local v = bkt:get("gaming")

local rgx = "^([sS]team)$"

bkt.assign_bucket({ class = rgx, title = rgx }, v.bucket)

--- Main window extras (not covered by bucket): opacity, borderless, no blur.
-- hl.window_rule({
--   name = "extra-steam-main",
--   match = { class = rgx, title = rgx },
--   opacity = "1.0 override 1.0 override",
--   border_size = 0,
--   no_blur = true,
-- })

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {

  --- Self-updater popup.
  {
    name = "tag-steam-updater",
    match = { title = "^(Steam - Self Updater)$" },
    tag = "+steamUpdater",
  },
  {
    name = "effect-steam-updater",
    match = { tag = "steamUpdater" },
    workspace = v.workspace,
    float = true,
    no_blur = true,
    no_initial_focus = true,
  },

  --- Sign-in window.
  {
    name = "tag-steam-signin",
    match = { class = rgx, title = "^(Sign in to [sS]team)$" },
    tag = "+steamSignIn",
  },
  {
    name = "effect-steam-signin",
    match = { tag = "steamSignIn" },
    workspace = v.workspace,
    center = true,
    float = true,
    no_blur = true,
    no_initial_focus = true,
    size = "850 720",
  },

  --- Settings window.
  {
    name = "tag-steam-settings",
    match = { class = rgx, title = "^([sS]team [sS]ettings)$" },
    tag = "+steamSettings",
  },
  {
    name = "effect-steam-settings",
    match = { tag = "steamSettings" },
    workspace = v.workspace,
    float = true,
    no_blur = true,
    opacity = "1.0 override 1.0 override",
    size = "850 720",
  },

  --- Special offers window.
  {
    name = "tag-steam-special-offers",
    match = { class = rgx, title = "^(Special Offers)$" },
    tag = "+steamSpecialOffers",
  },
  {
    name = "effect-steam-special-offers",
    match = { tag = "steamSpecialOffers" },
    workspace = v.workspace,
    float = true,
    no_blur = true,
  },
}

for _, rule in ipairs(rules) do
  hl.window_rule(rule)
end
