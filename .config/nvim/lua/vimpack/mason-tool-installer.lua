local utils = require("utils")
local map = vim.keymap.set

local M = {}

local module_opts = {
  --
  ensure_installed = {
    "lua_ls",
    "stylua",
    "hyprls",
    "tinymist",
    "typstyle",
    "taplo",
  },
}

---@param opts? any
M.setup = function(opts)
  opts = vim.tbl_deep_extend("force", module_opts, opts or {})
  -- TODO: @name - could write a cleaner/safer fn
  -- to expand the filename (assuming same as plugin)
  require("mason-tool-installer").setup(opts)
  return M
end

M.keys = function()
  -- map("n", "<Leader>e", "<cmd>Oil<CR>", { desc = "Oily" })
  -- map("n", "<C-w>E", "<cmd>lua =require('oil').open_float()<CR>", { silent = true, desc = "oil" } )
  -- map("n", "<Leader>fz", ":Oil ", { desc = "<cmd>Oil" } )
  return M
end

return M
