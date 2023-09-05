return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
config = function()
local bufferline = require("bufferline").setup{
            options = {
                offsets = {
                    {
                        filetype = "NvimTree",
                        textt = "File Explorer",
                        text_align = "left",
                        separator = true
                    }
                }
            }
        }
        --Other components for buffer management/deletion are in bufdelete.lua

        local map = vim.keymap.set
        -- NEXT
        map("n", "<leader>bn", ":bnext<CR>", { desc = "Buffer Next" })
            map("n", "<tab>", ":bnext<CR>", { desc = "Buffer Next" })

        -- PREV / PREVIOUS
        map("n", "<leader>bp", ":bPrevious<CR>", { desc = "Buffer Previous" })
        map("n", "<leader>bp", ":bprev<CR>", { desc = "Buffer Previous" })
            map("n", "<S-tab>", ":bprev<CR>", { desc = "Buffer Previous" })

        -- MOVING

        map("n", "<leader>bmn", ":BufferLineMoveNext<CR>", { desc = "Buffer Move Next" })
        map("n", "<leader>bmp", ":BufferLineMovePrev<CR>", { desc = "Buffer Move Previous" })

        -- DELETE and WIPE
        -- map("n", "<leader>bd", ":bdelete<CR><tab>", {desc = "Buffer Delete" })
        -- map("n", "<leader>bw", ":bwipeout<CR>", {desc = "Buffer Wipeout" })

        -- Tab controls
        map("n", "<leader><tab>]", ":tabNext<CR>", { desc = "Tab Next" })
        map("n", "<leader><tab>[", ":tabprevious<CR>", { desc = "Tab Previous" })
        map("n", "<leader><tab>a", ":tabnew<CR>", { desc = "Tab New" })
        map("n", "<leader><tab>c", ":tabclose<CR>", { desc = "Tab Close" })
    end,
}
