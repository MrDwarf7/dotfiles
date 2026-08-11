--- A set of extended vim 'std lib' style functions with
--- personal tweaks or slight differences
---@class VimExt
---@field lst VimExtLst|nil
---@field tbl VimExtTbl|nil
local vim_ext = {}
local here = "vim_ext"

local children = {
  "lst",
  "tbl",
}

for _, child in ipairs(children) do
  local fp = string.format("%s.%s", here, child)
  local ok, mod = pcall(require, fp)
  if ok then
    vim_ext[child] = mod
  else
    require("utils.output").warn(string.format("Failed to load module '%s': %s", fp, mod))
  end
end

setmetatable(vim_ext, {
  -- 'forward' any relevant calls though to the child module IF the requested fn exists on it/one of them/etc.
  __index = function(tbl, key)
    for _, child in ipairs(children) do
      local mod = tbl[child]
      if mod and type(mod[key]) == "function" then
        return mod[key]
      end
    end
    return nil
  end,
})

---@type VimExt
---@return VimExt
return vim_ext or {}
