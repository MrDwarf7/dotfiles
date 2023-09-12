-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.api.nvim_set_keymap

-- Exit insert and visual mode
map("i", "jj", "<Esc>", { noremap = true, silent = true })
map("v", "jk", "<Esc>", { noremap = true, silent = true })

-- buffers
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })

map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Mapping which-key things > plugin manager lazyvim
map("n", "<leader>p", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
