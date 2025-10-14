local M = {}

local colorschemes = vim.fn.stdpath("config") .. "/lua/plugins/colorschemes/"
-- local current = "matteblack"
local current = "tokyonight"

--- This function loads a module given its path,
--- standard sourcing path (eg: thing.folder.module)
---
--- It ensures that the path ends with a '.'
--- and can be joined on via a module concatentation
---
---@param module_path string
---@return table | table<nil>
M.load_module = function(module_path)
  -- check if the module path ends with a '.' or '.lua'
  -- and:
  -- add the '.' if missing
  -- or
  -- strip the 'lua' if present

  -- doesn't already end with a dot, and isn't '.lua'
  if not module_path:sub(-1) == "." and not module_path:sub(-4) == ".lua" then
    module_path = module_path .. "."
  end

  -- if it does end with '.lua', strip it
  if module_path:sub(-4) == ".lua" then
    module_path = module_path:sub(1, -5)
  end

  local ok, module = pcall(require, module_path)
  if not ok then
    vim.notify("Error loading module: " .. module_path .. "\n\n" .. module, vim.log.levels.ERROR)
    local ok, snacks = pcall(require, "snacks")
    if not ok then
      return {}
    end
    Snacks.debug.backtrace()
    Snacks.debug.inspect(module)
    return {}
  end
  return module
end

setmetatable(M, {
  __index = function(_, key)
    local module = M.load_module("plugins.colorschemes." .. current)
    return module[key]
  end,
  __call = function(_, key)
    local module = M.load_module("plugins.colorschemes." .. current)
    return module[key]
  end,
  __metatable = "colorscheme",
})

return M.load_module("plugins.colorschemes." .. current)
