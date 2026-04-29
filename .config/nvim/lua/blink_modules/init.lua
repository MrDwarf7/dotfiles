---@alias BlinkModulesSubmodule "sources" | "completion" | "signature" | "cmdline" | "keymap"
---@alias BlinkModulesReturnable BlinkModules | BlinkModules.Sources | BlinkModules.Completion | BlinkModules.Signature | BlinkModules.Cmdline | BlinkModules.Keymap

---@class BlinkModules : blink.cmp.Config
---@field setup? fun(mod?: BlinkModulesSubmodule): BlinkModulesReturnable
---@field sources BlinkModules.Sources
---@field completion BlinkModules.Completion
---@field signature BlinkModules.Signature
---@field cmdline BlinkModules.Cmdline
---@field keymap BlinkModules.Keymap
local BLINK = {}

-- ---@generic T:BlinkModulesReturnable
-- ---@class BlinkModules.Sources
-- ---@field setup? fun(mod?: BlinkModulesSubmodule): T

local submodules = {
  fuzzy = "blink_modules.fuzzy",
  sources = "blink_modules.sources",
  completion = "blink_modules.completion",
  signature = "blink_modules.signature",
  cmdline = "blink_modules.cmdline",
  keymap = "blink_modules.blink_keymap",
}

local function load_submodules(name)
  local modname = submodules[name]
  if not modname then
    require("utils.output").err("Invalid module name: " .. tostring(name))
  end

  local ok, cfg = pcall(require, modname)
  if not ok then
    require("utils.output").err("blink_modules: failed to load " .. modname .. "\n" .. cfg)
  end
  if type(cfg) ~= "table" then
    require("utils.output").err("blink_modules: " .. modname .. " must return a table")
  end

  return cfg
end

-- ---@generic T:BlinkModulesReturnable|blink.cmp.Config

--- Enables the usage of calling:
--- local bm = require("blink_modules")
---
--- -- and then using any of:
--- bm.completion
--- bm["completion"]
--- bm.setup("completion")
---
---@generic T:blink.cmp.Config
---@param mod? BlinkModulesSubmodule
---@return T
function BLINK.setup(mod) ---@diagnostic disable-line: unused-local
  if type(mod) == "string" then
    -- print("Value of mod on modules call: ", vim.inspect(mod))
    if not rawget(BLINK, mod) then
      rawset(BLINK, mod, load_submodules(mod))
    end
    -- print("Value of M on modules call: ", vim.inspect(BLINK))
    return BLINK[arg]
  end

  for name in pairs(submodules) do
    if not rawget(BLINK, name) then
      rawset(BLINK, name, load_submodules(name))
    end
  end

  -- print("Value of M on modules call: ", vim.inspect(BLINK))
  BLINK.setup = nil
  return BLINK
end

-- ---@return BlinkModules
-- return BLINK

---
---@return BlinkModules
return BLINK
