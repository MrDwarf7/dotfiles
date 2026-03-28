return {
  "julienvincent/hunk.nvim",
  lazy = true,
  cmd = { "DiffEditor" },
  opts = {
    keys = {
      diff = {
        -- prev_hunk = { "[h" },
        -- next_hunk = { "]h" },

        prev_hunk = { "[[" },
        next_hunk = { "]]" },
      },
    },
  },
  -- config = function()
  --   require("hunk").setup()
  -- end,
}
