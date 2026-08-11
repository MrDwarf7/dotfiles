---@class mywez
local M = {}

---@alias mywez.Mod.table table<mywez.Mod.options, any>
---@alias mywez.Mod.options string
---@alias mywez.Mod mywez.Mod.table | mywez.Mod.options

----@type mywez.Config
--local Config = require("config")

-- ---@type mywez.PluginManager
-- local PluginManager = require("plugins")
-- Config.plugin = PluginManager:init(Config)

-- ---@type Wezterm
-- local wezterm = require("wezterm")
-- Config:configs(wezterm, {
-- 	config_specs = {
-- 		appearance = "config.appearance",
-- 		bindings = "config.bindings",
-- 		domains = "config.domains",
-- 		fonts = "config.fonts",
-- 		general = "config.general",
-- 		launch = "config.launch",
-- 	},
-- 	plugin_sepcs = {
-- 		bars = "plugins.bars",
-- 		sessionizer = "plugins.sessionizer",
-- 	},
-- })

local Config = require("config") --
	:append("appearance")
	:append("bindings")
	:append("domains")
	:append("fonts")
	:append("general")
	:append("launch")

local wezterm = require("wezterm") ---@type Wezterm

---@type mywez.PluginManager
local PluginManager = require("plugins")

PluginManager:apply_to_config(wezterm, Config.options)

---@return mywez.Config
return Config.options
