return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
   },

   config = function()
      local telescope = require("telescope")
      -- local builtin = require('telescope.builtin')
      local actions = require("telescope.actions")

      telescope.setup({
         defaults = {
            mappings = {
               i = {
                  ["<C-k>"] = actions.move_selection_previous, -- Move to prev result in listing
                  ["<C-j>"] = actions.move_selection_next, -- Move to next res
                  ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
               }
            }
         }
      })

      telescope.load_extension("fzf");

      -- local map = vim.keymap.set
      -- map("n", "<fc>", "<cmd>Telescope grep_string<cr>", { desc = "Find Current Word" })


      -- Which-Key reigster for group
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
   end,
}
