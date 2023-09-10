local get_icon = require("astronvim.utils").get_icon
return {
  "lewis6991/gitsigns.nvim",
  enabled = vim.fn.executable("git") == 1,
  event = "User AstroGitFile",
  opts = {
    signs = {
      add = { text = get_icon("GitSign") },
      change = { text = get_icon("GitSign") },
      delete = { text = get_icon("GitSign") },
      topdelete = { text = get_icon("GitSign") },
      changedelete = { text = get_icon("GitSign") },
      untracked = { text = get_icon("GitSign") },
    },
    worktrees = vim.g.git_worktrees,
  },
  {
    "NeogitOrg/neogit",
    enabled = vim.fn.executable("git") == 1,
    event = "User AstroGitFile",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    cmd = "Neogit",
    config = true,
    telescope_sorter = function()
      return require("telescope").extensions.fzf.native_fzf_sorter()
    end,
    -- kind = "vsplit",

    -- keys = {
    --   { "<Leader>gn", ":Neogit<CR>" },
    -- },
  },
}
