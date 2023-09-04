-- Easier to type: map for keymaps
local map_api = vim.api.nvim_set_keymap --Here to test it later
local map = vim.keymap.set

local opts = {
    noremap = true, --Non-recurse
    silent = true, --Don't show a message about it
}

-- Helper Functions (Can be moved to it's own file later)



--------------
-- UNIVERSAL MODE KEYMAPS
--------------
vim.g.mapleader = " "
map("n", "<esc>", ":nohl<CR>", {desc = "Clear search highlights"})


--------------
-- Interesting KEYMAPS
--------------
--These are a bit buggy :L 
--map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
--map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })


-- Allows for moving text when holding ALT + direction
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })


--------------
-- NORMAL MODE KEYMAPS
--------------
-- Window nav remappings
map("n", "<C-h>", "<C-w>h", opts, { desc = "Window Move Left" })
map("n", "<C-j>", "<C-w>j", opts, { desc = "Window Move Left" })
map("n", "<C-k>", "<C-w>k", opts, { desc = "Window Move Left" })
map("n", "<C-l>", "<C-w>l", opts, { desc = "Window Move Left" })

--Window Resize with alt + arrow key
--(-2 being 2 lines to resize by)
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)


-- Buffer controls
map("n", "<leader>bn", ":bnext<CR>", { desc = "Buffer Next" })
map("n", "<leader>bn", ":bNext<CR>", { desc = "Buffer Next" })

map("n", "<leader>bp", ":bPrevious<CR>", { desc = "Buffer Previous" })
map("n", "<leader>bp", ":bprev<CR>", { desc = "Buffer Previous" })


map("n", "<leader>bc", ":bdelete<CR>", {desc = "Buffer Close" })
map("n", "<leader>bwa", ":bwipeout<CR>", {desc = "Buffer Wipeout" })

--------------
-- INSERT MODE KEYMAPS
--------------
map("i", "jj", "<Esc>", opts) -- Double j to exit

--------------
-- VISUAL MODE KEYMAPS
--------------
--Better indenting
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

--------------
-- PLUGIN SPECIFIC KEYMAPS
--------------

-- All of these will likely get moved to a Which-Key/wk array at some stage anyway

-- Lazy Vim
map("n", "<leader>l", ":Lazy<CR>", { desc = "Lazy.Nvim" })
















