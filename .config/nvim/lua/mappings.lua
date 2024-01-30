local silent_opts = {
	noremap = true,
	silent = true,
}

local loud_opts = {
	noremap = true,
	silent = false,
}

-- Base keymaps
vim.keymap.set("n", "<Leader>e", vim.cmd.Ex, { desc = "explorer" })

vim.keymap.set("n", "<Esc>", ":nohl<CR>", silent_opts)
vim.keymap.set("v", "<Esc>", "<Esc>:nohl<CR>", silent_opts)
vim.keymap.set("i", "jj", "<Esc>", { noremap = false })
vim.keymap.set("v", "p", '"_dP', silent_opts)

vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", silent_opts) -- Shifting lines down / move
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", silent_opts) -- Shifting lines up / move

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "n", "nzzzv", silent_opts)
vim.keymap.set("n", "N", "Nzzzv", silent_opts)

--vim.keymap.set("n", "<C-d>,", "<C-d>zz", silent_opts ) -- Laggy as
--vim.keymap.set("n", "<C-u>,", "<C-u>zz", silent_opts ) -- Laggy as

-- Header/From initial leader key press
vim.keymap.set("n", "<Leader>b", "+[b]uffers")
vim.keymap.set("n", "<Leader>p", "+[p]lugins", { desc = "+[p]lugins" })
vim.keymap.set("n", "<leader>g", "+[g]it", silent_opts, { desc = "+[g]it" })
vim.keymap.set("n", "<Leader>f", "+[f]ind", { desc = "+[f]ind" })
vim.keymap.set("n", "<Leader>w", "+[w]inShift", { desc = "+[w]inShift" })
vim.keymap.set("n", "<Leader>n", "+[n]Other", { desc = "+[n]Other/NoiceDismiss" })
vim.keymap.set("n", "<Leader>l", "+[l]sp", { desc = "+[l]sp" })

-- Subset headers, but only after an LSP attached - just defined here for naming convention
vim.keymap.set("n", "gd", "[d]efinition", { desc = "[d]efinition" })
vim.keymap.set("n", "gD", "[D]eclaration", { desc = "[D]eclaration" })
vim.keymap.set("n", "gr", "[r]eferences", { desc = "[r]eferences" })
vim.keymap.set("n", "<Leader>lr", "[r]ename", { desc = "[r]ename" })
vim.keymap.set("n", "<Leader>lR", "[R]ename (other)", { desc = "[R]ename (other)" })

vim.keymap.set("n", "<Leader>la", "[a]ction", { desc = "[a]ction" })
vim.keymap.set("n", "<Leader>lf", "[f]ormat", { desc = "[f]ormat" })
vim.keymap.set("n", "<Leader>lh", "[h]over", { desc = "[h]over" })

----------

vim.keymap.set("n", "<Left>", ":vertical resize +2<CR>", silent_opts)
vim.keymap.set("n", "<Right>", ":vertical resize -2<CR>", silent_opts)
vim.keymap.set("n", "<Down>", ":resize -2<CR>", silent_opts)
vim.keymap.set("n", "<Up>", ":resize +2<CR>", silent_opts)

vim.keymap.set("n", "<Leader>v", ":vsplit<CR>", silent_opts, { desc = "[v]-split" })
vim.keymap.set("n", "<Leader>s", ":split<CR>", silent_opts, { desc = "[s]plit" })
vim.keymap.set("n", "<C-w>e", "<C-w>=", silent_opts, { desc = "[e]qualize" }) -- ctrl + w + = : easier to hit to equalize the width of buffers

-- Navigational keymaps
vim.keymap.set("n", "<Leader>bn", ":bnext<CR>", silent_opts, { desc = "[n]ext" })
vim.keymap.set("n", "<Leader>bp", ":bprev<CR>", silent_opts, { desc = "[p]revious" })
vim.keymap.set("n", "<Leader>x", ":bdelete<CR>", silent_opts, { desc = "[X]close" })

vim.keymap.set("n", "H", "^", silent_opts)       -- Shift + h (Or just H) to jump to start of line
vim.keymap.set("n", "L", "$", silent_opts)       -- Shift + l (Or just L) to jump to end of line

vim.keymap.set("v", "H", "^", silent_opts)       -- Shift + h (Or just H) to jump to start of line
vim.keymap.set("v", "L", "$", silent_opts)       -- Shift + l (Or just L) to jump to end of line

vim.keymap.set("n", "y<S-h>", "y^", silent_opts) -- Same as above for yanking
vim.keymap.set("n", "y<S-l>", "y$", silent_opts) -- Same as above for yanking

vim.keymap.set("n", "d<S-h>", "d^", silent_opts) -- Same as above for yanking
vim.keymap.set("n", "d<S-l>", "d$", silent_opts) -- Same as above for yanking

vim.keymap.set("n", "<Leader>pl", ":Lazy<CR>", silent_opts, { desc = "[l]azy" })
vim.keymap.set("n", "<Leader>pm", ":Mason<CR>", silent_opts, { desc = "[m]ason" })

vim.keymap.set("n", "<Leader>gc", ':Git commit -m "', silent_opts)                                    -- Temp for the time being until lazygit // fugitive or something

vim.keymap.set("n", "<Leader>?", ":vsplit<CR>:terminal<CR>A", silent_opts, { desc = "Inbuilt Term" }) -- Temp for the time being until lazygit // fugitive or something

vim.keymap.set("n", '<Leader>"', ":Telescope neoclip<CR>", silent_opts, { desc = "Clipboard/Registers" })

-- MOVE INTO RELEVANT FILE
vim.keymap.set("n", "<Leader>nn", ":NoiceDismiss<CR>", loud_opts, { desc = "[n]oice dismiss" })
