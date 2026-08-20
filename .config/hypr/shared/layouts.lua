--################
--## LAYOUT(s) ###
--################

local machine = require("utils.machine")

hl.config({
  ---@type HL.ConfigOpt.Layout
  layout = {
    -- Whenever only a single window is shown on a screen,
    -- add padding so that it conforms to the specified aspect ratio.
    --
    -- A value like 4 3 on a 16:9 screen will make it a 4:3 window in the middle with padding to the sides.
    -- Type: Vec2D
    -- Default: 0 0
    single_window_aspect_ratio = (machine.layout or {}).single_window_aspect_ratio or { 21, 9 },
    -- Sets a tolerance for single_window_aspect_ratio,
    -- so that if the padding that would have been added is smaller than the specified fraction of the height or width of the screen,
    -- it will not attempt to adjust the window size [0 - 1]
    -- Type: int
    -- Default: 0.1
    single_window_aspect_ratio_tolerance = 0.2,
  },
  -- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
  ---@type HL.ConfigOpt.Dwindle
  dwindle = {
    force_split = 2, -- default - 0 |  0 -> split follows mouse, 1 -> always split to the left (new = left or top) 2 -> always split to the right (new = right or bottom)
    preserve_split = true, -- You probably want this
    smart_split = false,
    smart_resizing = true,
    -- special_scale_factor = 0.8,
    use_active_for_splits = true,
    split_bias = 0,
  },
  -- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
  ---@type HL.ConfigOpt.Master
  master = {
    orientation = "center",
    slave_count_for_center_master = false,
    mfact = 0.6,
    new_on_top = false,
    -- new_on_active = before
    -- always_keep_position = true
    -- allow_small_split = true
    -- new_status = slave
  },
  ---@type HL.ConfigOpt.Scrolling
  scrolling = {
    -- Default: true
    fullscreen_on_one_column = (machine.scrolling or {}).fullscreen_on_one_column or false,
    -- Default: 0.5
    -- column_width = 0.333
    column_width = 0.433,
    -- When a column is focused, what method should be used to bring it into view. 0 = center, 1 = fit
    -- Default: 1
    focus_fit_method = 1,
    -- when a window is focused, should the layout move to bring it into view automatically
    -- Default: true
    -- TODO: This was false (prior to black-screen startup issue)
    follow_focus = true,
    -- Dictates when jumping (or spawning!) a new winodw, how far we will 'shift' or how far in an item must be
    -- for us to _consider_ shifting it into view.
    -- Type: float
    -- Default: 0.4
    follow_min_visible = 0.3333,
    -- Type: str (as a comma-separated list of floats)
    -- Default: 0.333, 0.5, 0.667, 1.0
    -- explicit_column_widths = 0.133, 0.333, 0.5, 0.667, 0.911 # , 1.0
    explicit_column_widths = "0.133, 0.233, 0.433, 0.5, 0.766, 0.911, 1.0",
    -- When enabled, causes layoutmsg focus l/r to wrap around at the beginning and end.
    wrap_focus = true,
    -- When enabled, causes layoutmsg swapcol l/r to wrap around at the beginning and end.
    wrap_swapcol = true,
    -- Default: right
    -- Available options: right, left, top, bottom
    -- This can also apply as a workspace rule too
    direction = "right",
    --# ## Layout Messages
    --#
    --# Dispatcher `layoutmsg` params:
    --#
    --# | name      | description                                                                                                                                                                                                            | params                         |
    --# | --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------ |
    --# | move      | move the layout horizontally, by either a relative logical px ( -200 , +200 ) or columns ( +col , -col )                                                                                                               | move data                      |
    --# | colresize | resize the current column, to either a value or by a relative value e.g. 0.5 , +0.2 , -0.2 or cycle the preconfigured ones with +conf or -conf . Can also be all (number) for resizing all columns to a specific width | relative float / relative conf |
    --# | fit       | executes a fit operation based on the argument. Available: active , visible , all , toend , tobeg                                                                                                                      | fit mode                       |
    --# | focus     | moves the focus and centers the layout, while also wrapping instead of moving to neighbring monitors.                                                                                                                  | direction                      |
    --# | promote   | moves a window to its own new column                                                                                                                                                                                   | none                           |
    --# | swapcol   | Swaps the current column with its neighbor to the left ( l ) or right ( r ). The swap wraps around (e.g., swapping the first column left moves it to the end).                                                         | l or r                         |
    --# | togglefit | Toggle the focus_fit_method (center, fit)                                                                                                                                                                              | none                           |
    --#
    --# - Example key bindings for your Hyprland config:
    --#
    --# ```hypr
    --# bind = $mainMod, period, layoutmsg, move +col
    --# bind = $mainMod, comma, layoutmsg, swapcol l
    --# ```
  },
  -- monocle {
  -- }
})
