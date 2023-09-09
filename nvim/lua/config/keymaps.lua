-- Easier to type: map for keymaps
-- directly from Astro -
vim.opt.viewoptions:remove "curdir"             -- disable saving current directory with views
vim.opt.shortmess:append { s = true, I = true } -- disable search count wrap and startup messages
vim.opt.backspace:append { "nostop" }           -- don't stop backspace at insert
if vim.fn.has "nvim-0.9" == 1 then
    vim.opt.diffopt:append "linematch:60"       -- enable linematch diff algorithm
end
-- END directly from Astro -

local map_api = vim.api.nvim_set_keymap --Here to test it later
local map = vim.keymap.set

local opts = {
    noremap = true, --Non-recurse
    silent = true,  --Don't show a message about it
}
vim.g.mapleader = " "
vim.g.localleader = " "

-- Helper Functions (Can be moved to it's own file later)
-- --------------- WHICH KEY EXAMPLES CAN BE FOUND VIA
-- :h which-key.nvim.txt, then searching MAPPINGS, go to 12th instance.


--------------
-- UNIVERSAL MODE KEYMAPS
--------------


-- map.n["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "Move cursor down" }
-- map.n["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "Move cursor up" }


map("n", "<esc>", ":nohl<CR>", { desc = "Clear search highlights" })
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
map("i", "jk", "<ESC>", opts)

--------------
-- VISUAL MODE KEYMAPS
--------------
--Better indenting
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)


-- Paste over currently selected text without yanking it
map("v", "p", '"_dp')
map("v", "P", '"_dP')


--------------
-- PLUGIN SPECIFIC KEYMAPS
--------------
-- All of these will likely get moved to a Which-Key/wk array at some stage anyway
-- Lazy Vim
map("n", "<leader>p", ":Lazy<CR>", { desc = "Lazy.Nvim" })

--Bufferline
map("n", "<Tab>", ":BufferLineCycleNext<CR>", opts, { desc = "BufferLine cycle Next" })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts, { desc = "BufferLine cycle Prev" })

-- Better buf deletion
map("n", "<leader>x", ":Bdelete<CR><tab>", { desc = "Buffer Delete" })
map("n", "<leader>bw", ":Bwipeout<CR>", { desc = "Buffer Wipeout" })


-- Easier commenting
map("n", "<C-/>", "gcc", { desc = "Comment Toggle" })


-- LazyGit
map("n", "<leader>gg", ":LazyGit<CR>", { desc = "LazyGit Open" })



-- Bufferline keymaps

map("n", "<leader>bn", ":bnext<CR>", { desc = "Buffer Next" })
map("n", "<tab>", ":bnext<CR>", { desc = "Buffer Next" })

-- PREV / PREVIOUS
map("n", "<leader>bp", ":bPrevious<CR>", { desc = "Buffer Previous" })
map("n", "<leader>bp", ":bprev<CR>", { desc = "Buffer Previous" })
map("n", "<S-tab>", ":bprev<CR>", { desc = "Buffer Previous" })

-- MOVING
map("n", "<leader>bmn", ":BufferLineMoveNext<CR>", { desc = "Buffer Move Next" })
map("n", "<leader>bmp", ":BufferLineMovePrev<CR>", { desc = "Buffer Move Previous" })

-- Tab controls
map("n", "<leader><tab>]", ":tabNext<CR>", { desc = "Tab Next" })
map("n", "<leader><tab>[", ":tabprevious<CR>", { desc = "Tab Previous" })
map("n", "<leader><tab>a", ":tabnew<CR>", { desc = "Tab New" })
map("n", "<leader><tab>c", ":tabclose<CR>", { desc = "Tab Close" })
