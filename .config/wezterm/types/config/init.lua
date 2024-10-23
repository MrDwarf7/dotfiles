---@meta

---@class Config
---@field font FontAttributes The baseline font to use
---@field dpi_by_screen { [string]: f64 }
---@field colors Palette The color palette
---@field switch_to_last_active_tab_when_closing_tab bool
---@field window_frame WindowFrameConfig
---@field char_select_font_size f64
---@field char_select_fg_color RgbaColor
---@field char_select_bg_color RgbaColor
---@field command_palette_font_size f64
---@field command_palette_fg_color RgbaColor
---@field command_palette_bg_color RgbaColor
---@field pane_select_font_size f64
---@field pane_select_fg_color RgbaColor
---@field pane_select_bg_color RgbaColor
---@field tab_bar_style TabBarStyle
---@field resolved_palette Palette
---@field color_scheme String
--     -- Use a named color scheme rather than the palette specified
--     -- by the colors setting.
---@field color_schemes {[String]: Palette}
--     -- Named color schemes
---@field scrollback_lines usize
--     -- How many lines of scrollback you want to retain
---@field default_prog String[]
--     -- If no `prog` is specified on the command line, use this
--     -- instead of running the user's shell.
--     -- For example, to have `wezterm` always run `top` by default
--     -- you'd use this:
--     --
--     -- ```toml
--     -- ```
--     --
--     -- `default_prog` is implemented as an array where the 0th element
--     -- is the command to run and the rest of the elements are passed
--     -- as the positional arguments to that command.
---@field default_gui_startup_args String[]
---@field default_cwd PathBuf
--     -- Specifies the default current working directory if none is specified
--     -- through configuration or OSC 7 (see docs for `default_cwd` for more
--     -- info!)
---@field exit_behavior ExitBehavior
---@field exit_behavior_messaging ExitBehaviorMessaging
---@field clean_exit_codes u32[]
---@field detect_password_input bool
---@field set_environment_variables {[String]: String}
--     -- Specifies a map of environment variables that should be set
--     -- when spawning commands in the local domain.
--     -- This is not used when working with remote domains.
---@field initial_rows u16
--     -- Specifies the height of a new window, expressed in character cells.
---@field enable_kitty_graphics bool
---@field enable_kitty_keyboard bool
---@field enable_title_reporting bool
--     -- Whether the terminal should respond to requests to read the
--     -- title string.
--     -- Disabled by default for security concerns with shells that might
--     -- otherwise attempt to execute the response.
--     -- <https://marc.info/?l=bugtraq&m=104612710031920&w=2>
---@field initial_cols u16
--     -- Specifies the width of a new window, expressed in character cells
---@field hyperlink_rules HyperlinkRule[]
---@field term String
--     -- What to set the TERM variable to
---@field font_locator FontLocatorSelection
---@field font_rasterizer FontRasterizerSelection
---@field font_shaper FontShaperSelection
---@field display_pixel_geometry DisplayPixelGeometry
---@field freetype_load_target FreeTypeLoadTarget
---@field freetype_render_target FreeTypeLoadTarget
---@field freetype_load_flags FreeTypeLoadFlags
---@field freetype_interpreter_version u32
--     -- Selects the freetype interpret version to use.
--     -- Likely values are 35, 38 and 40 which have different
--     -- characteristics with respective to subpixel hinting.
--     -- See https://freetype.org/freetype2/docs/subpixel-hinting.html
---@field freetype_pcf_long_family_names bool
---@field harfbuzz_features String[]
--     -- Specify the features to enable when using harfbuzz for font shaping.
--     -- There is some light documentation here:
--     -- <https://harfbuzz.github.io/shaping-opentype-features.html>
--     -- but it boils down to allowing opentype feature names to be specified
--     -- using syntax similar to the CSS font-feature-settings options:
--     -- <https://developer.mozilla.org/en-US/docs/Web/CSS/font-feature-settings>.
--     -- The OpenType spec lists a number of features here:
--     -- <https://docs.microsoft.com/en-us/typography/opentype/spec/featurelist>
--     --
--     -- Options of likely interest will be:
--     --
--     -- * `calt` - <https://docs.microsoft.com/en-us/typography/opentype/spec/features_ae#tag-calt>
--     -- * `clig` - <https://docs.microsoft.com/en-us/typography/opentype/spec/features_ae#tag-clig>
--     --
--     -- If you want to disable ligatures in most fonts, then you may want to
--     -- use a setting like this:
--     --
--     -- ```toml
--     -- harfbuzz_features ["calt=0", "clig=0", "liga=0"]
--     -- ```
--     --
--     -- Some fonts make available extended options via stylistic sets.
--     -- If you use the [Fira Code font](https://github.com/tonsky/FiraCode)
--     -- it lists available stylistic sets here:
--     -- <https://github.com/tonsky/FiraCode/wiki/How-to-enable-stylistic-sets>
--     --
--     -- and you can set them in wezterm:
--     --
--     -- ```toml
--     -- # Use this for a zero with a dot rather than a line through it
--     -- # when using the Fira Code font
--     -- harfbuzz_features ["zero"]
--     -- ```
---@field front_end FrontEndSelection
---@field webgpu_power_preference WebGpuPowerPreference
--     -- Whether to select the higher powered discrete GPU when
--     -- the system has a choice of integrated or discrete.
--     -- Defaults to low power.
---@field webgpu_force_fallback_adapter bool
---@field webgpu_preferred_adapter GpuInfo
---@field wsl_domains WslDomain[]
---@field exec_domains ExecDomain[]
---@field serial_ports SerialDomain[]
---@field unix_domains UnixDomain[]
--     -- The set of unix domains
---@field ssh_domains SshDomain[]
---@field ssh_backend SshBackend
---@field tls_servers TlsDomainServer[]
--     -- When running in server mode, defines configuration for
--     -- each of the endpoints that we'll listen for connections
---@field tls_clients TlsDomainClient[]
--     -- The set of tls domains that we can connect to as a client
---@field ratelimit_mux_line_prefetches_per_second u32
--     -- Constrains the rate at which the multiplexer client will
--     -- speculatively fetch line data.
--     -- This helps to avoid saturating the link between the client
--     -- and server if the server is dumping a large amount of output
--     -- to the client.
---@field mux_output_parser_buffer_size usize
--     -- The buffer size used by parse_buffered_data in the mux module.
--     -- This should not be too large, otherwise the processing cost
--     -- of applying a batch of actions to the terminal will be too
--     -- high and the user experience will be laggy and less responsive.
---@field mux_output_parser_coalesce_delay_ms u64
--     -- How many ms to delay after reading a chunk of output
--     -- in order to try to coalesce fragmented writes into
--     -- a single bigger chunk of output and reduce the chances
--     -- observing "screen tearing" with un-synchronized output
---@field mux_env_remove String[]
---@field keys Key[]
---@field key_tables {[String]: Key[]}
---@field bypass_mouse_reporting_modifiers Modifiers
---@field debug_key_events bool
---@field normalize_output_to_unicode_nfc bool
---@field disable_default_key_bindings bool
---@field leader LeaderKey
---@field disable_default_quick_select_patterns bool
---@field quick_select_patterns String[]
---@field quick_select_alphabet String
---@field mouse_bindings Mouse[]
---@field disable_default_mouse_bindings bool
---@field daemon_options DaemonOptions
---@field send_composed_key_when_left_alt_is_pressed bool
---@field send_composed_key_when_right_alt_is_pressed bool
---@field macos_forward_to_ime_modifier_mask Modifiers
---@field treat_left_ctrlalt_as_altgr bool
---@field swap_backspace_and_delete bool
--     -- If true, the `Backspace` and `Delete` keys generate `Delete` and `Backspace`
--     -- keypresses, respectively, rather than their normal keycodes.
--     -- On macOS the default for this is true because its Backspace key
--     -- is labeled as Delete and things are backwards.
---@field enable_tab_bar bool
--     -- If true, display the tab bar UI at the top of the window.
--     -- The tab bar shows the titles of the tabs and which is the
--     -- active tab.  Clicking on a tab activates it.
---@field use_fancy_tab_bar bool
---@field tab_bar_at_bottom bool
---@field mouse_wheel_scrolls_tabs bool
---@field show_tab_index_in_tab_bar bool
--     -- If true, tab bar titles are prefixed with the tab index
---@field show_tabs_in_tab_bar bool
---@field show_new_tab_button_in_tab_bar bool
---@field tab_and_split_indices_are_zero_based bool
--     -- If true, show_tab_index_in_tab_bar uses a zero-based index.
--     -- The default is false and the tab shows a one-based index.
---@field tab_max_width usize
--     -- Specifies the maximum width that a tab can have in the
--     -- tab bar.  Defaults to 16 glyphs in width.
---@field hide_tab_bar_if_only_one_tab bool
--     -- If true, hide the tab bar if the window only has a single tab.
---@field enable_scroll_bar bool
---@field min_scroll_bar_height Dimension
---@field enable_wayland bool
--     -- If false, do not try to use a Wayland protocol connection
--     -- when starting the gui frontend, and instead use X11.
--     -- This option is only considered on X11/Wayland systems and
--     -- has no effect on macOS or Windows.
--     -- The default is true.
---@field enable_zwlr_output_manager bool
--     -- driver updates without breaking and losing your work.
--     -- Whether to prefer EGL over other GL implementations.
--     -- EGL on Windows has jankier resize behavior than WGL (which
--     -- is used if EGL is unavailable), but EGL survives graphics
---@field prefer_egl bool
---@field custom_block_glyphs bool
---@field anti_alias_custom_block_glyphs bool
---@field window_padding WindowPadding
--     -- Controls the amount of padding to use around the terminal cell area
---@field window_background_image PathBuf
--     -- Specifies the path to a background image attachment file.
--     -- The file can be any image format that the rust `image`
--     -- crate is able to identify and load.
--     -- A window background image is rendered into the background
--     -- of the window before any other content.
--     --
--     -- The image will be scaled to fit the window.
---@field window_background_gradient Gradient
---@field window_background_image_hsb HsbTransform
---@field foreground_text_hsb HsbTransform
---@field background BackgroundLayer[]
---@field macos_window_background_blur i64
--     -- Only works on MacOS
---@field win32_system_backdrop SystemBackdrop
--     -- Only works on Windows
---@field win32_acrylic_accent_color RgbaColor
---@field window_background_opacity f32
--     -- Specifies the alpha value to use when rendering the background
--     -- of the window.  The background is taken either from the
--     -- window_background_image, or if there is none, the background
--     -- color of the cell in the current position.
--     -- The default is 1.0 which is 100% opaque.  Setting it to a number
--     -- between 0.0 and 1.0 will allow for the screen behind the window
--     -- to "shine through" to varying degrees.
--     -- This only works on systems with a compositing window manager.
--     -- Setting opacity to a value other than 1.0 can impact render
--     -- performance.
---@field inactive_pane_hsb HsbTransform
--     -- inactive_pane_hue, inactive_pane_saturation and
--     -- inactive_pane_brightness allow for transforming the color
--     -- of inactive panes.
--     -- The pane colors are converted to HSV values and multiplied
--     -- by these values before being converted back to RGB to
--     -- use in the display.
--     --
--     -- The default is 1.0 which leaves the values as-is.
--     --
--     -- Modifying the hue changes the hue of the color by rotating
--     -- it through the color wheel.  It is not as useful as the
--     -- other components, but is available "for free" as part of
--     -- the colorspace conversion.
--     --
--     -- Modifying the saturation can add or reduce the amount of
--     -- "colorfulness".  Making the value smaller can make it appear
--     -- more washed out.
--     --
--     -- Modifying the brightness can be used to dim or increase
--     -- the perceived amount of light.
--     --
--     -- The range of these values is 0.0 and up; they are used to
--     -- multiply the existing values, so the default of 1.0
--     -- preserves the existing component, whilst 0.5 will reduce
--     -- it by half, and 2.0 will double the value.
--     --
--     -- A subtle dimming effect can be achieved by setting:
--     -- inactive_pane_saturation 0.9
--     -- inactive_pane_brightness 0.8
---@field text_background_opacity f32
---@field cursor_blink_rate u64
--     -- Specifies how often a blinking cursor transitions between visible
--     -- and invisible, expressed in milliseconds.
--     -- Setting this to 0 disables blinking.
--     -- Note that this value is approximate due to the way that the system
--     -- event loop schedulers manage timers; non-zero values will be at
--     -- least the interval specified with some degree of slop.
---@field cursor_blink_ease_in EasingFunction
---@field cursor_blink_ease_out EasingFunction
---@field animation_fps u8
---@field force_reverse_video_cursor bool
---@field default_cursor_style DefaultCursorStyle
--     -- Specifies the default cursor style.  various escape sequences
--     -- can override the default style in different situations (eg:
--     -- an editor can change it depending on the mode), but this value
--     -- controls how the cursor appears when it is reset to default.
--     -- The default is `SteadyBlock`.
--     -- Acceptable values are `SteadyBlock`, `BlinkingBlock`
--     -- `SteadyUnderline`, `BlinkingUnderline`, `SteadyBar`
--     -- and `BlinkingBar`.
---@field text_blink_rate u64
--     -- Specifies how often blinking text (normal speed) transitions
--     -- between visible and invisible, expressed in milliseconds.
--     -- Setting this to 0 disables slow text blinking.  Note that this
--     -- value is approximate due to the way that the system event loop
--     -- schedulers manage timers; non-zero values will be at least the
--     -- interval specified with some degree of slop.
---@field text_blink_ease_in EasingFunction
---@field text_blink_ease_out EasingFunction
---@field text_blink_rate_rapid u64
--     -- Specifies how often blinking text (rapid speed) transitions
--     -- between visible and invisible, expressed in milliseconds.
--     -- Setting this to 0 disables rapid text blinking.  Note that this
--     -- value is approximate due to the way that the system event loop
--     -- schedulers manage timers; non-zero values will be at least the
--     -- interval specified with some degree of slop.
---@field text_blink_rapid_ease_in EasingFunction
---@field text_blink_rapid_ease_out EasingFunction
---@field hide_mouse_cursor_when_typing bool
--     -- If true, the mouse cursor will be hidden while typing.
--     -- This option is true by default.
---@field periodic_stat_logging u64
--     -- If non-zero, specifies the period (in seconds) at which various
--     -- statistics are logged.  Note that there is a minimum period of
--     -- 10 seconds.
---@field scroll_to_bottom_on_input bool
--     -- If false, do not scroll to the bottom of the terminal when
--     -- you send input to the terminal.
--     -- The default is to scroll to the bottom when you send input
--     -- to the terminal.
---@field use_ime bool
---@field xim_im_name String
---@field ime_preedit_rendering ImePreeditRendering
---@field use_dead_keys bool
---@field launch_menu SpawnCommand[]
---@field use_box_model_render bool
---@field automatically_reload_config bool
--     -- When true, watch the config file and reload it automatically
--     -- when it is detected as changing.
---@field check_for_updates bool
---@field show_update_window bool
---@field check_for_updates_interval_seconds u64
---@field enable_csi_u_key_encoding bool
--     -- When set to true, use the CSI-U encoding scheme as described
--     -- in http://www.leonerd.org.uk/hacks/fixterms/
--     -- This is off by default because @wez and @jsgf find the shift-space
--     -- mapping annoying in vim :-p
---@field window_close_confirmation WindowCloseConfirmation
---@field native_macos_fullscreen_mode bool
---@field selection_word_boundary String
---@field enq_answerback String
---@field adjust_window_size_when_changing_font_size bool
---@field tiling_desktop_environments String[]
---@field use_resize_increments bool
---@field alternate_buffer_wheel_scroll_speed u8
---@field status_update_interval u64
---@field experimental_pixel_positioning bool
---@field bidi_enabled bool
---@field bidi_direction ParagraphDirectionHint
---@field skip_close_confirmation_for_processes_named String[]
---@field quit_when_all_windows_are_closed bool
---@field warn_about_missing_glyphs bool
---@field sort_fallback_fonts_by_coverage bool
---@field search_font_dirs_for_fallback bool
---@field use_cap_height_to_scale_fallback_fonts bool
---@field swallow_mouse_click_on_pane_focus bool
---@field swallow_mouse_click_on_window_focus bool
---@field pane_focus_follows_mouse bool
---@field unzoom_on_switch_pane bool
---@field max_fps u8
---@field shape_cache_size usize
---@field line_state_cache_size usize
---@field line_quad_cache_size usize
---@field line_to_ele_shape_cache_size usize
---@field glyph_cache_image_cache_size usize
---@field visual_bell VisualBell
---@field audible_bell AudibleBell
---@field canonicalize_pasted_newlines NewlineCanon
---@field unicode_version u8
---@field treat_east_asian_ambiguous_width_as_wide bool
---@field allow_download_protocols bool
---@field allow_win32_input_mode bool
---@field default_domain String
---@field default_mux_server_domain String
---@field default_workspace String
---@field xcursor_theme String
---@field xcursor_size u32
---@field key_map_preference KeyMapPreference
---@field quote_dropped_files DroppedFileQuoting
---@field ui_key_cap_rendering UIKeyCapRendering
---@field palette_max_key_assigments_for_action usize
---@field ulimit_nofile u64
---@field ulimit_nproc u64
local WeztermConfig = {
	-- The font size, measured in points
	font_size = 12.0,

	-- must be greater than 0
	line_height = 1.0,

	-- default = "default_one_point_oh_f64"
	cell_width = 1.0,

	---@type Dimension
	-- specified by underline_thickness
	cursor_thickess = 2.0,

	---@type Dimension
	-- specified by font
	underline_thickness = 2.0,

	---@type Dimension
	underline_position = -2,

	---@type Dimension
	strikethrough_position = 2.0,

	---@type "Allow" | "Never" | "WhenFollowedBySpace"
	allow_square_glyphs_to_overflow_width = "Never",

	---@type WindowDecorations
	window_decorations = "TITLE | RESIZE",

	---@type IntegratedTitleButton[]
	integrated_title_buttons = { "Hide", "Maximize", "Close" },

	log_unknown_escape_sequences = false,

	---@type IntegratedTitleButtonAlignment
	integrated_title_button_alignment = "Right",

	---@type IntegratedTitleButtonStyle
	-- default is MacOsNative no Mac, Windows on all others
	integrated_title_button_style = "Windows",

	-- Auto or custom color like "red"
	integrated_title_button_color = "Auto",

	-- When using FontKitXXX font systems, a set of directories to search ahead of the standard font locations for fonts.
	-- Relative paths are taken to be relative to the directory from which the config was loaded.
	-- This tells wezterm to look first for fonts in the directory named `fonts` that is found alongside your `wezterm.lua` file.
	-- As this option is an array, you may list multiple locations if you wish.
	font_dirs = { "fonts" },
	color_scheme_dirs = { "colorschemes" },

	-- The DPI to assume
	-- Override the detected DPI (dots per inch) for the display.
	-- This can be useful if the detected DPI is inaccurate and the text appears either blurry or too small (especially if you are using a 4K display on X11 or Wayland).
	-- The default value is system specific:
	dpi = 96,

	---@type BoldBrightening
	-- When true ("BrightAndBold"), PaletteIndex 0-7 are shifted to bright when the font intensity is bold.
	-- The brightening doesn't apply to text that is the default color.
	-- can also use true or false for backwards compatibility
	bold_brightens_ansi_colors = "BrightAndBold",
}

-- TODO: finish less commonly used conig options (maybe set the defaults, might be too much time)
--     -- An optional set of style rules to select the font based
--     -- on the cell attributes
--     font_rules = Vec<StyleRule>,