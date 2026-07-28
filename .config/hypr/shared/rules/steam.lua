--- Steam window rules.
--- Tag-then-effect pattern for different Steam window types.

---@type HyprConfig.HL.WindowRuleSpec[]
local rules = {
  -- TODO: [tags] : gaming

  --- Self-updater popup.
  {
    name = "tag-steam-updater",
    match = { title = "^(Steam - Self Updater)$" },
    tag = "+steamUpdater",
  },

  {
    name = "effect-steam-updater",
    match = { tag = "steamUpdater" },
    workspace = "4 silent",
    float = true,
    no_initial_focus = true,
    no_blur = true,
  },

  --- Sign-in window.
  {
    name = "tag-steam-signin",
    match = {
      class = "^([sS]team)$",
      title = "^(Sign in to [sS]team)$",
    },
    tag = "+steamSignIn",
  },

  {
    name = "effect-steam-signin",
    match = { tag = "steamSignIn" },
    workspace = "4 silent",
    no_initial_focus = true,
    float = true,
    center = true,
    no_blur = true,
    size = "850 720",
  },

  --- Main Steam window.
  {
    name = "tag-steam-main",
    match = {
      class = "^([sS]team)$",
      title = "^([sS]team)$",
    },
    tag = "+steamMain",
  },

  {
    name = "effect-steam-main",
    match = { tag = "steamMain" },
    workspace = "4 silent",
    opacity = "1.0 override 1.0 override",
    no_blur = true,
    border_size = 0,
  },

  --- Settings window.
  {
    name = "tag-steam-settings",
    match = {
      class = "^([sS]team)$",
      title = "^([sS]team [sS]ettings)$",
    },
    tag = "+steamSettings",
  },

  {
    name = "effect-steam-settings",
    match = { tag = "steamSettings" },
    workspace = "4 silent",
    opacity = "1.0 override 1.0 override",
    float = true,
    no_blur = true,
    size = "850 720",
  },

  --- Special offers window.
  {
    name = "tag-steam-special-offers",
    match = {
      class = "^([sS]team)$",
      title = "^(Special Offers)$",
    },
    tag = "+steamSpecialOffers",
  },

  {
    name = "effect-steam-special-offers",
    match = { tag = "steamSpecialOffers" },
    workspace = "4 silent",
    float = true,
    no_blur = true,
  },
}

for _, rule in ipairs(rules) do
  hl.window_rule(rule)
end
