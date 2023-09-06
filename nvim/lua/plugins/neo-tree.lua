return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
        local neotree = require("neo-tree").setup({
            opts = {
            source_selector = {
                winbar = true,
            },
            mappings = {
               ["<space>"] = {
                  "toggle_node",
                  nowait = false,
               },
               ["s"] = "open_split",
               ["v"] = "open_vsplit",
               ["<bs>"] = "close_node",
            },
            filestystem = {
            -- follow_current_file = { enabled = true },
                filtered_items = {
                  visible = false,
                  hide_dotfiles = false,
                  hide_gitignored = false,
                  show_hidden_count = true,
                  hide_hidden = true, --windows specific.
                  hide_by_name = {
                        -- "node_modules"
                        },
                  always_show = { -- remains visible even if other settings would normally hide it 
                     "AppData",
                     ".git",
                     ".gitignore",
                     ".gitignored",
                  },
               },
            follow_current_file = {
               enabled = true,
            },

               use_lubuv_file_watcher = true, -- Makes NeoTree use the OS level file watcher to detect changes
               window = {

                  mappings = {
                     ["<->"] = "navigate_up",
                  }
               },
            },

            buffers = {
               follow_current_file = {
                  enabled = true,
               },
            }
         }
      })
      local map = vim.keymap.set
      opts = {
         silent = true
      }
      map("n", "<leader>nt", ":Neotree toggle<CR>", opts, { desc = "Neotree Toggle" })
      map("n", "<leader>n", ":Neotree focus<CR>", opts, { desc = "Neotree" })
   end,
}

