--#############
--## CURSOR ###
--#############

hl.config({
  cursor = {
    sync_gsettings_theme = true,
    no_hardware_cursors = 2,
    no_break_fs_vrr = 2,
    min_refresh_rate = 24,
    hotspot_padding = 1,
    inactive_timeout = 0,
    no_warps = false,
    persistent_warps = true,
    warp_on_change_workspace = 1,
    warp_on_toggle_special = 0,
    default_monitor = "DP-1", -- TODO: we need to be able to check the env for stuff as well so we can do `require("utils.machines").desktop and "DP-1" or "eDP-1"` etc.
    zoom_factor = 1.0,
    zoom_rigid = false,
    enable_hyprcursor = true,
    hide_on_key_press = true,
    hide_on_touch = true,
    use_cpu_buffer = 2,
    warp_back_after_non_mouse_input = false,
  },
})
