--
---@class utils.Utils
---@field arch utils.Arch
-- ---@field autofmt: utils.AutoFmt
---@field bufdel utils.BufDel
---@field converter utils.Converter
---@field list utils.List
---@field output utils.Output
---@field sudo utils.Sudo
---@field tsutils utils.TsUtils
--- Setup function for utils.Utils module.
---@field setup fun(): utils.Utils
local Utils = {
  arch = require("utils.arch"),
  -- autofmt =  require("utils.autofmt")
  bufdel = require("utils.bufdel"),
  converter = require("utils.converter"),
  list = require("utils.list"),
  output = require("utils.output"),
  sudo = require("utils.sudo"),
  tsutils = require("utils.tsutils"),
}

-- Utils.arch = require("utils.arch")
-- Utils.converter = require("utils.converter")
-- -- Utils.autofmt = require("utils.autofmt")
-- Utils.output = require("utils.output")
-- Utils.sudo = require("utils.sudo")
-- Utils.bufdel = require("utils.bufdel")
-- Utils.list = require("utils.list")

local has_init_utils = false

function Utils.setup()
  if has_init_utils then
    return Utils
  end

  if type(Utils) ~= "table" then
    -- loac the utils.Output module directly, and return an notify error
    require("utils.output").err("Something went wrong attempting to load the utils.Utils module!")
    has_init_utils = false
    return {}
  end

  has_init_utils = true
  return Utils
end

---@return utils.Utils
return Utils.setup()
