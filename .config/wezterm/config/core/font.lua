---@alias config.core.Font table

local wezterm = require("wezterm")

---@class Font: config.core.Font
---@field setup fun(): table
---@field font string
---@field harfbuzz_features table
---@field font_size number
local Font = {}
-- Font.__index = Font

function Font.setup()
	return {
		font = wezterm.font("Mononoki Nerd Font Mono", { weight = "Light", italic = false, stretch = "Normal" }),
		harfbuzz_features = { "calt=0", "clig=0", "liga=0", "zero" },
		font_size = 10.0,
	}
end

return Font.setup()

-- ---@type config.core.Font
-- return setmetatable({}, {
-- 	__call = function()
-- 		return Font.setup()
-- 	end,
-- 	__index = Font,
-- 	__path = (...):match("(.*[\\/])"),
-- })
