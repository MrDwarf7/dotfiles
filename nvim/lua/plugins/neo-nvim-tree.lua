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
            source_selector = {
                winbar = true,
            },
            filestystem = {
                filtered_items = {
                    visible = false, --default setting
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_hidden = true, --windows specific.
                    hide_by_name = {
                        -- "node_modules"
                    },
                    always_show = { -- remains visible even if other settings would normally hide it
                    "AppData",
                    --".gitignored",
                    },
                }
            }



        })
        local map = vim.keymap.set

        map("n", "<leader>et", ":Neotree toggle<CR>", { desc = "Neotree Toggle" })
        map("n", "<leader>e", ":Neotree focus<CR>", { desc = "Neotree" })



    end,
}
