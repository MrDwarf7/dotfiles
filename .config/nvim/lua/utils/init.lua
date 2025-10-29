--
---@class utils.Utils
---@field arch utils.Arch
---@field converter utils.Converter
-- ---@field autofmt: utils.AutoFmt
---@field output utils.Output
---@field sudo utils.Sudo
---@field bufdel utils.BufDel
---@field list utils.List
local Utils = {
	arch = {},
	converter = {},
	-- autofmt = {}
	output = {},
	sudo = {},
	bufdel = {},
	list = {}
}

Utils.arch = require("utils.arch")
Utils.converter = require("utils.converter")
-- Utils.autofmt = require("utils.autofmt")
Utils.output = require("utils.output")
Utils.sudo = require("utils.sudo")
Utils.bufdel = require("utils.bufdel")
Utils.list = require("utils.list")


---@return utils.Utils
return Utils
