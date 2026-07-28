--- Tag + Effect pattern apps.
--- Two-step: assign tag by class, then apply effects by tag.
--- Only includes apps where tags genuinely reduce rule count.

---@type HyprConfig.TagEffectApp[]
local apps = {
  {
    -- TODO: [tags] : public_comms
    name = "workspace-discord",
    class = "[dD]iscord|[aA]rmcord|[wW]ebcord|[vV]encord|[vV]esktop",
    tag = "discordForks",
    workspace = "9 silent",
    opacity = "0.90 override 0.60 override",
    maximize = true,
  },
  {
    -- TODO: [tags] : notes
    name = "workspace-affine",
    class = "AFFiNE.*",
    tag = "affine",
    workspace = "5 silent",
    opacity = "1.00 override 1.00 override",
    persistent_size = true,
    no_float = true,
    center = true,
  },

  {
    name = "workspace-qbittorrent",
    class = "org.qbittorrent.qBittorrent",
    tag = "torrent",
    float = true,
    persistent_size = true,
  },
  {
    -- TODO: [tags] : music
    name = "workspace-ytm-pear", -- TODO: need to manage the 'pear' name as well
    class = "com.github.th_ch.youtube.+",
    -- tag = "ytm",
    tag = "music",
    workspace = "8 silent",
    size = "1250 850",
    persistent_size = true,
    maximize = true,
    center = true,
  },
  {
    -- TODO: [tags] : music
    name = "workspace-spotify", -- TODO: need to manage the 'pear' name as well
    class = "[sS]potify",
    -- tag = "spotify",
    tag = "music",
    workspace = "8 silent",
    persistent_size = true,
    maximize = true,
  },

  {
    class = "ueberzugpp_.*",
    tag = "ueberzugpp_nvim",
    opacity = "1.00 override 1.00 override",
    no_initial_focus = true,
    persistent_size = true,
  },
  {
    class = "[rR]im[wW]orld[lL]inux",
    tag = "rimworld",
    opacity = "1.00 override 1.00 override",
    persistent_size = true,
    border_size = 0,
    size = "5120 1440",
    fullscreen = true,
  },
  {
    -- TODO: [tags] : browsers
    name = "workspace-zen",
    class = "[zZ]en(-?[bB]rowser)?",
    tag = "zen",
    workspace = "1 silent",
    size = "2030 1060",
    persistent_size = true,
    opacity = "1.00 override 1.00 override",
  },

  {
    name = "workspace-docker",
    class = "Docker\\sDesktop",
    tag = "docker",
    workspace = "7 silent",
    no_initial_focus = true,
    persistent_size = true,
    opacity = "1.00 override 1.00 override",
  },
  {
    -- TODO: [tags] : private_comms
    name = "workspace-telegram",
    class = "QQ|Telegram|org.telegram.desktop",
    tag = "telegram",
    workspace = "6 silent",
    persistent_size = true,
  },
  {
    -- TODO: [tags] : private_comms
    name = "workspace-signal",
    class = "[sS]ignal",
    tag = "signal",
    workspace = "6 silent",
  },
  {
    -- TODO: [tags] : private_comms | email
    name = "workspace-thunderbird",
    class = "org.mozilla.[tT]hunderbird",
    -- initial_class = "org.mozilla.[tT]hunderbird",
    tag = "thunderbird",
    workspace = "3 silent",
  },
}

--- Creates a tag rule for the given app.
---@param app HyprConfig.TagEffectApp
---@return HyprConfig.HL.WindowRuleSpec
local make_tag = function(app)
  return {
    name = "tag-" .. app.tag,
    match = { class = "^(" .. app.class .. ")$" },
    tag = "+" .. app.tag,
  }
end

--- Creates an effect rule for the given app.
---@param app HyprConfig.TagEffectApp
---@return HyprConfig.HL.WindowRuleSpec
local make_effect = function(app)
  if not app.name then
    app.name = app.tag
  end
  local effect = {
    name = "effect-" .. app.name,
    match = { tag = app.tag },
  }
  local list = require("utils.list")

  --- Fields that can be applied to effects.
  --- Used to generate a unique name for rules that conform to 'Effect' types.
  ---@type EffectFields[]
  local effect_fields = {
    "workspace",
    "size",
    "persistent_size",
    "opacity",
    "no_float",
    "float",
    "center",
    "maximize",
    "border_size",
    "fullscreen",
    "no_initial_focus",
  }

  for _, field in ipairs(effect_fields) do
    if list.contains(field, app) then
      effect[field] = app[field]
    end
  end

  return effect
end

---@type HyprConfig.TagEffectApp
for _, app in ipairs(apps) do
  --- Step 1: tag assignment
  hl.window_rule(make_tag(app))
  --- Step 2: effect assignment
  hl.window_rule(make_effect(app))
end
