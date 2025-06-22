return {
  "yanky.nvim",
  keys = {
    {
      "<Leader>'",
      function()
        if LazyVim.pick.picker.name == "telescope" then
          require("telescope").extensions.yank_history.yank_history({})
        else
          vim.cmd([[YankyRingHistory]])
        end
      end,
      mode = { "n", "x" },
      desc = "Open Yank History",
    },
  },
  opts = {
    highlight = {
      100,
    },
  },
}
