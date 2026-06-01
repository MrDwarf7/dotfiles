---@type Wezterm
local wezterm = require("wezterm")

---@type mywez.Platform
-- local Platform = require("utils.platform")

--- Lookup table to support multiple fonts
local fonts = {
	maple = "Maple Mono SC NF",
	jetbrainsmono = "JetBrainsMono Nerd Font",
	jetbrainsmono_mono = "JetBrainsMono Nerd Font Mono",
	firacode = "FiraCode Nerd Font Mono",
	mononoki = "Mononoki Nerd Font",
	mononoki_mono = "Mononoki Nerd Font Mono",
}

-- Check the pc name, if it contains 'book', we set font to 12.0, else 11.0
local font_size = 10.5

-- It's a laptop of somesort
if wezterm.hostname():find("book") then
	font_size = 13.0
end

-- platform.is_linux and 12.0 or 11.0

---@return FontFamilyExtendedAttributes
return {
	font = wezterm.font(
		--
		fonts.mononoki_mono,
		{ weight = "Regular", italic = false }
	),
	font_size = font_size,
	---@type FontFamilyExtendedAttributes
	harfbuzz_features = { "calt=0", "clig=0", "liga=0", "zero", "ss12=0", "ss13=0" },
	-- There's a setting here for something along the lines of missing_unicode_fonts or similar we can set
	warn_about_missing_glyphs = false,

	text_background_opacity = 1.0, --0.6

	--ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
	-- freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
	-- freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
