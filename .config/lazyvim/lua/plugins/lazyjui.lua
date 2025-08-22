-- Inspired by - "swaits/lazyjj.nvim" and the lazygit.nvim plugin
return {
  "mrdwarf7/lazyjui.nvim",
  lazy = true,
  -- dev = true,
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    {
      "<Leader>aa",
      function()
        require("lazyjui").open()
      end,
    },
  },
  ---@type lazyjui.Opts
  opts = {
    cmd = { "jjui", "-r", "all()" },
    winblend = 0,
  },
  -- config = function(_, opts)
  --   require("lazyjui").setup({
  --     cmd = { "jjui", "-r", "all()" },
  --     winblend = 20,
  --   })
  -- end,
}
