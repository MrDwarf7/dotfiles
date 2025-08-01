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
  -- How to 'show' the config for people using auto-complete?
  opts = {
    cmd = { "jjui", "-r", "all()" },
    winblend = 0,
  },
}
