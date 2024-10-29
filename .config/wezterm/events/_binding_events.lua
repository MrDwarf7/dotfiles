local wezterm = require("wezterm")

wezterm.on("more-opaque", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if overrides.opacity then
		overrides.opacity = math.min(1.0, overrides.opacity + 0.1)
	else
		overrides.opacity = 0.9
	end

	return overrides
end)

wezterm.on("less-opaque", function(window, pane)
	local overrides = window:get_config_overrides() or {}
end)
