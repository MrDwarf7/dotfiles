---@alias BlinkModulesSubmodule "sources" | "completion" | "signature" | "cmdline" | "keymap"
---@alias BlinkModulesReturnable BlinkModules | BlinkModules.Sources | BlinkModules.Completion | BlinkModules.Signature | BlinkModules.Cmdline | BlinkModules.Keymap

---@class BlinkModules : blink.cmp.Config
---@field sources BlinkModules.Sources
---@field completion BlinkModules.Completion
---@field signature BlinkModules.Signature
---@field cmdline BlinkModules.Cmdline
---@field keymap BlinkModules.Keymap

-- ---@generic T:BlinkModulesReturnable
-- ---@field setup fun(mod?: BlinkModulesSubmodule): T|BlinkModulesReturnable
local M = {}

local submodules = {
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

--- Enables the usage of calling:
--- local bm = require("blink_modules")
---
--- -- and then using any of:
--- bm.completion
--- bm["completion"]
--- bm.setup("completion")
---
---@generic T:BlinkModulesReturnable
---@param mod? BlinkModulesSubmodule
---@return T
function M.setup(mod) ---@diagnostic disable-line: unused-local
  if type(mod) == "string" then
    print("Value of mod on modules call: ", vim.inspect(mod))
    if not rawget(M, mod) then
      rawset(M, mod, load_submodules(mod))
    end
    print("Value of M on modules call: ", vim.inspect(M))
    return M[arg]
  end

  for name in pairs(submodules) do
    if not rawget(M, name) then
      rawset(M, name, load_submodules(name))
    end
  end

  print("Value of M on modules call: ", vim.inspect(M))
  return M
end

-- ---@return BlinkModules

return M
