hl.curve("fluid", {
  type = "bezier",
  points = {
    { 0.15, 0.85 },
    { 0.25, 1 },
  },
})

hl.curve("snappy", {
  type = "bezier",
  points = {
    { 0.3, 1 },
    { 0.4, 1 },
  },
})

-- https://wiki.hyprland.org/Configuring/Variables/#animations

-- NOTE: This _ALSO_ controls the speed
-- not just of _SPAWNING_ winodws.... but also
-- the speed of changing windows when using the `scrolling` layout option :L
--
hl.animation({
  leaf = "windows",
  enabled = true,
  -- speed = 3,
  speed = 2,
  -- bezier = "fluid",
  bezier = "snappy",
  -- style = "popin 5%",
  style = "popin 15%",
  -- style = "popin 0%",
})
hl.animation({
  leaf = "windowsOut",
  enabled = true,
  speed = 2.5,
  bezier = "snappy",
})
hl.animation({
  leaf = "fade",
  enabled = true,
  speed = 4,
  bezier = "snappy",
})
hl.animation({
  leaf = "workspaces",
  enabled = true,
  -- speed = 1.7,
  -- speed = 2.25,
  speed = 1.25,
  bezier = "snappy",
  style = "slide",
})

hl.animation({
  leaf = "specialWorkspace",
  enabled = true,
  speed = 4,
  bezier = "fluid",
  style = "slidefadevert -35%",
})
hl.animation({
  leaf = "layers",
  enabled = true,
  -- speed = 1,
  speed = 2,
  bezier = "snappy",
  style = "popin 70%",
})
hl.animation({
  leaf = "layersIn",
  enabled = true,
  speed = 2,
  bezier = "fluid",
  style = "popin 70%",
})
hl.animation({
  leaf = "layersOut",
  enabled = true,
  speed = 0.8,
  bezier = "snappy",
  style = "popin 70%",
})
hl.animation({
  leaf = "fadePopups",
  enabled = true,
  speed = 2.5,
  bezier = "snappy",
})

hl.config({
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
})
