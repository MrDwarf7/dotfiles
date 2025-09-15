return {
  {
    "mistweaverco/kulala.nvim",
    -- lazy = false,
    -- event = "VeryLazy",
    ft = { "http", "rest" },
    keys = {
      { "<Leader>ra", desc = "Send request" },
      { "<Leader>ra", desc = "Send all requests" },
      { "<Leader>rb", desc = "Open scratchpad" },
      {
        "<Leader>rh",
        function()
          require("kulala").toggle_view()
        end,
        desc = "Toggle headers/body",
      },
    },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = "<Leader>r",
      kulala_keymaps_prefix = "",
      -- lsp = {
      --   keymaps = true,
      -- },
    },
  },

  -- {
  --   "rest-nvim/rest.nvim",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     opts = function(_, opts)
  --       opts.ensure_installed = opts.ensure_installed or {}
  --       table.insert(opts.ensure_installed, "http")
  --     end,
  --   },
  -- },

  -- {
  --   "oysandvik94/curl.nvim",
  --   cmd = { "CurlOpen" },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   -- config = true,
  -- opts = {}
  -- },
}
