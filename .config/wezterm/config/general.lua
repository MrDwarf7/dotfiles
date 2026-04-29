---@class mywez.General: Config
---@field window_close_confirmation "NeverPrompt" | "AlwaysPrompt" | "PromptOnExit"
---@field automatically_reload_config boolean
---@field swallow_mouse_click_on_pane_focus boolean
---@field audible_bell "Disabled" | "Visual" | "Audible"
---@field exit_behavior_messaging "Verbose" | "Quiet"
---@field enable_wayland boolean
---@field status_update_interval number
---@field scrollback_lines number
---@field enable_scroll_bar boolean
---@field hyperlink_rules HyperLinkRule[]

---@type mywez.General
return {
	window_close_confirmation = "NeverPrompt",
	automatically_reload_config = true,
	swallow_mouse_click_on_pane_focus = false,
	audible_bell = "Disabled",
	exit_behavior_messaging = "Verbose",

	enable_wayland = false,

	status_update_interval = 10000,

	scrollback_lines = 10000,
	enable_scroll_bar = true,

	---@type HyperLinkRule[]
	hyperlink_rules = {
		---@type HyperLinkRule
		-- Matches: a URL in parens: (URL)
		{
			regex = "\\((\\w+://\\S+)\\)",
			format = "$1",
			highlight = 1,
		},
		---@type HyperLinkRule
		-- Matches: a URL in brackets: [URL]
		{
			regex = "\\[(\\w+://\\S+)\\]",
			format = "$1",
			highlight = 1,
		},
		---@type HyperLinkRule
		-- Matches: a URL in curly braces: {URL}
		{
			regex = "\\{(\\w+://\\S+)\\}",
			format = "$1",
			highlight = 1,
		},
		---@type HyperLinkRule
		-- Matches: a URL in angle brackets: <URL>
		{
			regex = "<(\\w+://\\S+)>",
			format = "$1",
			highlight = 1,
		},
		---@type HyperLinkRule
		-- Then handle URLs not wrapped in brackets
		{
			regex = "\\b\\w+://\\S+[)/a-zA-Z0-9-]+",
			format = "$0",
		},
		---@type HyperLinkRule
		-- implicit mailto link
		{
			regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
			format = "mailto:$0",
		},
	},
}
