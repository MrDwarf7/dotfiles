return {
  "linux-cultist/venv-selector.nvim",
  lazy = true,
  ft = { "python" },
  branch = "regexp", -- This is the regexp branch, use this for the new version
  dependencies = {
    { "neovim/nvim-lspconfig", lazy = true },
    { "mfussenegger/nvim-dap", lazy = true },
    { "mfussenegger/nvim-dap-python", lazy = true }, --optional
    {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      dependencies = { "nvim-lua/plenary.nvim", lazy = true },
      lazy = true,
    },
  },
  keys = {
    { "<Leader>lv", "<cmd>VenvSelect<cr>" },
    { "<Leader>fv", "<cmd>VenvSelect<cr>" },
  },
  opts = {
    -- debug = true,
  },
  -- config = function()
  -- 	require("venv-selector").setup()
  -- end,
}
