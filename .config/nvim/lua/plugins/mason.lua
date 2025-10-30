return {
  "mason-org/mason.nvim",
  -- lazy = false,
  lazy = true,
  -- event = "VeryLazy",
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
