---@type HyprConfig.Curve[]
local curves = {
  {
    name = "fluid",
    type = "bezier",
    points = {
      { 0.15, 0.85 },
      { 0.25, 1 },
    },
  },

  {
    name = "snappy",
    type = "bezier",
    points = {
      { 0.3, 1 },
      { 0.4, 1 },
    },
  },
}

for _, curve in ipairs(curves) do
  hl.curve(curve.name, {
    type = curve.type,
    points = curve.points,
  })
end

-- hl.curve("fluid", {
--   type = "bezier",
--   points = {
--     { 0.15, 0.85 },
--     { 0.25, 1 },
--   },
-- })

-- hl.curve("snappy", {
--   type = "bezier",
--   points = {
--     { 0.3, 1 },
--     { 0.4, 1 },
--   },
-- })

---@type HyprConfig.Animation[]
local animations = {
  {
    leaf = "windows",
    enabled = true,
    -- speed = 3,
    speed = 2,
    -- bezier = "fluid",
    bezier = "snappy",
    -- style = "popin 5%",
    style = "popin 15%",
    -- style = "popin 0%",
  },
  {
    leaf = "windowsOut",
    enabled = true,
    speed = 2.5,
    bezier = "snappy",
  },
  {
    leaf = "fade",
    enabled = true,
    speed = 4,
    bezier = "snappy",
  },
  {
    leaf = "workspaces",
    enabled = true,
    -- speed = 1.7,
    -- speed = 2.25,
    speed = 1.25,
    bezier = "snappy",
    style = "slide",
  },

  {
    leaf = "specialWorkspace",
    enabled = true,
    speed = 4,
    bezier = "fluid",
    style = "slidefadevert -35%",
  },
  {
    leaf = "layers",
    enabled = true,
    -- speed = 1,
    speed = 2,
    bezier = "snappy",
    style = "popin 70%",
  },
  {
    leaf = "layersIn",
    enabled = true,
    speed = 2,
    bezier = "fluid",
    style = "popin 70%",
  },
  {
    leaf = "layersOut",
    enabled = true,
    speed = 0.8,
    bezier = "snappy",
    style = "popin 70%",
  },
  {
    leaf = "fadePopups",
    enabled = true,
    speed = 2.5,
    bezier = "snappy",
  },
}

-- https://wiki.hyprland.org/Configuring/Variables/#animations

-- NOTE: This _ALSO_ controls the speed
-- not just of _SPAWNING_ winodws.... but also
-- the speed of changing windows when using the `scrolling` layout option :L
--

for _, anim in ipairs(animations) do
  hl.animation(anim)
end

---@type HL.ConfigOpt
local animation_config = {
  ---@type HL.ConfigOpt.Animations
  animations = {
    enabled = true,
    workspace_wraparound = true,

    -- Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
    -- bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    -- bezier = easeOutQuint,0.23,1,0.32,1
    -- bezier = easeInOutCubic,0.65,0.05,0.36,1
    -- bezier = linear,0,0,1,1
    -- bezier = almostLinear,0.5,0.5,0.75,1.0
    -- bezier = quick,0.15,0,0.1,1
    --
    -- animation = global, 1, 10, default
    -- animation = border, 1, 5.39, easeOutQuint
    -- animation = windows, 1, 4.79, easeOutQuint
    -- animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
    -- animation = windowsOut, 1, 1.49, linear, popin 87%
    -- animation = fadeIn, 1, 1.73, almostLinear
    -- animation = fadeOut, 1, 1.46, almostLinear
    -- animation = fade, 1, 3.03, quick
    -- animation = layers, 1, 3.81, easeOutQuint
    -- animation = layersIn, 1, 4, easeOutQuint, fade
    -- animation = layersOut, 1, 1.5, linear, fade
    -- animation = fadeLayersIn, 1, 1.79, almostLinear
    -- animation = fadeLayersOut, 1, 1.39, almostLinear
    -- animation = workspaces, 1, 1.94, almostLinear, fade
    -- animation = workspacesIn, 1, 1.21, almostLinear, fade
    -- animation = workspacesOut, 1, 1.94, almostLinear, fade
  },
}

---@type HL.ConfigOpt
hl.config(animation_config)
