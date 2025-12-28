-- Inspired by - "swaits/lazyjj.nvim" and the lazygit.nvim plugin
---@type LazyPluginBase
return {
  -- -- from github pull -- --
  -- "mrdwarf7/lazyjui.nvim",
  -- branch = "dev",

  -- -- from local FS / Dev --
  "lazyjui.nvim",
  branch = "dev",
  dev = true,

  lazy = true,
  dependencies = "nvim-lua/plenary.nvim",
  ---@type LazyKeys
  keys = {
    -- stylua: ignore start
    { "<Leader>aa", function() require("lazyjui").open() end, desc = "LazyJui [a]ll" },
    -- stylua: ignore end
  },
  ---@type lazyjui.Opts
  opts = {
    -- Optionally:
    -- border_chars = {},
    -- border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    -- border_thickness = 2,
    cmd = { "jjui", "-r", "all()" },
    height = 0.8, -- default is 0.8,
    width = 0.7, -- default is 0.9,
    winblend = 0, -- default is 0 (fully opaque). Set to 100 for fully transparent (not recommended though).
  },
  -- config = function(_, opts)
  --   require("lazyjui").setup({
  --     cmd = { "jjui", "-r", "all()" },
  --     winblend = 20,
  --   })
  -- end,
}
