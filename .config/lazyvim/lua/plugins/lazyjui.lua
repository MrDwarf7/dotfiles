-- Inspired by - "swaits/lazyjj.nvim" and the lazygit.nvim plugin
return {
  "lazyjui.nvim",
  lazy = false,
  dev = true,

  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    {
      "<Leader>aa",
      function()
        require("lazyjui").open()
      end,
    },
  },
  opts = {},
}
