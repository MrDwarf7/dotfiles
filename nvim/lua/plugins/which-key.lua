return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    window = {
        border = "shadow",
        winblend = 15,
    }
  },

      -- Which-Key reigster for Telescope group
   config = function()
      local wk = require("which-key")
      wk.register({
         f = {
            name = "Find(Telescope)", -- optional group name
            f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
            r = { "<cmd>Telescope oldfiles<cr>", "Find Recents", noremap = true}, -- additional options for creating the keymap
            b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
            g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
            h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
            j = { "<cmd>Telescope jumplist<cr>", "Jumplist" },
            z = { "<cmd>Telescope colorscheme<cr>", "Temp Colorscheme" },
            c = { "<cmd>Telescope grep_string<cr>", "Find Current Word" },

         },
      }, { prefix = "<leader>" })




      -- Which-Key reigster for Git group
      wk.register({
         g = {
            name = "Git",
            g = {"LazyGit" },
            n = { "<cmd>Neogit<CR>", "NeoGit" },
            cc = {"Comment"},



         }
      })


         -- { "<Leader>gn", ":Neogit<CR>" },




















   end,
}

