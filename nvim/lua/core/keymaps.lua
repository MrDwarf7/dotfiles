-- Easier to type: map for keymaps
local map_api = vim.api.nvim_set_keymap --Here to test it later
local map = vim.keymap.set

local opts = {
    noremap = true, --Non-recurse
    silent = true, --Don't show a message about it
}
vim.g.mapleader = " "

-- Helper Functions (Can be moved to it's own file later)



--------------
-- UNIVERSAL MODE KEYMAPS
--------------
map("n", "<esc>", ":nohl<CR>", {desc = "Clear search highlights"})
map("n", "<C-s>", ":w<CR>", opts)
map("n", "<C-S>", ":w!<CR>", opts)

map("n", "<leader>qq", ":qa!<CR>", opts, { desc = "Close everything" })


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

--Window Resize with ctrl + arrow key
--(-2 being 2 lines to resize by)
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize +2<CR>", opts)

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

--Bufferline
--map("n", "<Tab>", ":BufferLineCycleNext<CR>", opts, { desc = "BufferLine cycle Next" })
--map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts, { desc = "BufferLine cycle Prev" })

-- Better buf deletion
map("n", "<leader>bd", ":Bdelete<CR><tab>", {desc = "Buffer Delete" })
map("n", "<leader>x", ":Bdelete<CR><tab>", {desc = "Buffer Delete" })
map("n", "<leader>bw", ":Bwipeout<CR>", {desc = "Buffer Wipeout" })


-- Easier commenting
map("n", "<C-/>", "gcc", {desc = "Comment Toggle" })


-- LazyGit
map("n", "<leader>gg", ":LazyGit<CR>", {desc = "LazyGit Open" })

