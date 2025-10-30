---@type LazyPluginBase
return {
  "mason-org/mason.nvim",
  -- lazy = false,
  lazy = true,
  -- ---@type LazyEventSpec
  -- event = "VeryLazy",
  ---@type LazyKeys
  keys = {
    {
      "<Leader>pm",
      function()
        vim.cmd("Mason")
      end,
      desc = "Mason",
    },
  },
  opts = {},
}
