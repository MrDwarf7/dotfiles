local utils = require("config.utils")
local font = require("config.core.font")
local helper = require("config.utils.vim_helpers")

---@alias config.core.Render table

---@class Render: config.core.Render
local Render = {}
-- Render.__index = Render

function Render.setup()
	return {
		max_fps = utils.envtoint("WZT_MAX_FPS"),
		animation_fps = utils.envtoint("WZT_ANIM_FPS"),
		front_end = utils.env("WZT_GPU_FRONTEND"),
		webgpu_power_preference = utils.env("WZT_GPU_POWER_PREF"), -- TODO: move to rendering or something
		color_scheme = "Tokyo Night Storm",
	}
end

return utils.tbl_deep_extend("force", {}, Render.setup(), font())

-- render = Render.setup,
-- font = font(),

-- ---@return config.core.Render
-- return setmetatable(Render, {
-- 	__call = function()
-- 		local t = {}
-- 		local m = helper.tbl_deep_extend("force", t, Render.setup(), font())
-- 		print("MMMMMMMMMMMMMMM:", m)
-- 		return m
-- 	end,
-- 	__index = Render,
-- 	__path = (...):match("(.*[\\/])"),
-- })
