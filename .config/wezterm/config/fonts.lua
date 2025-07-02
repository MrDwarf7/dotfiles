local wezterm = require("wezterm")
local platform = require("utils.platform")

-- local font = 'Maple Mono SC NF'
-- local font_family = "JetBrainsMono Nerd Font"
local font_family = "FiraCode Nerd Font Mono"
local font_size = 10.5
-- platform.is_linux and 12.0 or 11.0

return {
	font = wezterm.font(font_family, { weight = "Regular", italic = false }),
	font_size = font_size,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0", "zero" },
	-- There's a setting here for something along the lines of missing_unicode_fonts or similar we can set
	warn_about_missing_glyphs = true,

	text_background_opacity = 1.0, --0.6

	--ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
	-- freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
	-- freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
