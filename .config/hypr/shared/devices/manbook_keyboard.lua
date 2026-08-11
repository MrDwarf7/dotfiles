---@type HL.DeviceSpec
local device = {
  name = "apple-inc.-apple-internal-keyboard-/-trackpad",
  enabled = true,

  kb_model = "",
  kb_layout = "us",
  kb_variant = "",
  -- kb_options = "grp:alt_shift_toggle",
  kb_options = "caps:escape",
  -- kb_options = fkeys:basic_13-24
  kb_rules = "",
  kb_file = "",
  numlock_by_default = false,
  resolve_binds_by_sym = false,
  repeat_delay = 160,
  repeat_rate = 60,
  sensitivity = 1.00,
  -- accel_profile = "flat",
  accel_profile = "adaptive",
  left_handed = false,
  scroll_points = "",
  scroll_method = "",
  scroll_button = 0,
  scroll_button_lock = false,
  scroll_factor = 0.6,
  -- See below re focus
  -- touchpad = {
  natural_scroll = true,
  disable_while_typing = true,
  middle_button_emulation = false,
  tap_button_map = "",
  clickfinger_behavior = true,
  tap_to_click = true, -- Enable tap to click -- May want to remove this though
  drag_lock = 2,
  tap_and_drag = true,
  flip_x = false,
  flip_y = false,
  drag_3fg = 0,
  -- }
}

hl.device(device)

-- TODO: idk these are kinda janky tbh
--
-- hl.gesture({
--   fingers = 3,
--   direction = "up",
--   action = function()
--     hl.dsp.focus({ direction = "right" })
--   end,
-- })
--
-- hl.gesture({
--   fingers = 3,
--   direction = "down",
--   action = function()
--     hl.dsp.focus({ direction = "left" })
--   end,
-- })
