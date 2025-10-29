local utils = require("utils")
local map = vim.keymap.set

local M = {}

local module_opts = {
  --
}

---@param opts? any
M.setup = function(opts)
  opts = vim.tbl_deep_extend("force", module_opts, opts or {})
  -- TODO: @name - could write a cleaner/safer fn
  -- to expand the filename (assuming same as plugin)
  require("mason").setup(opts)
  return M
end

M.keys = function()
  map("n", "<Leader>pm", function()
    vim.cmd("Mason")
  end, { desc = "Mason" })
  return M
end

return M
