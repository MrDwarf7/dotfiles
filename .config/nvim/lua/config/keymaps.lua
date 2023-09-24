--
-- copied from lazyvim keymaps.lua:
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  ---@diagnostic disable-next-line: missing-fields
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

--------------------------------------------------------------------------
-- Delete mappings, making l, w and q menus available
--------------------------------------------------------------------------
for _, key in pairs({
  -- "<c-/>", -- dummy which key, lazyterm
  "<S-h>", -- bprev
  "<S-l>", -- bnext
  "<leader>l", -- lazy, now harpoon 4
  "<leader>L", -- lazy changelog
  "<leader>wd", -- delete window, <C-W>c, now just quit
  "<leader>ww", -- other window, <C-W>p, not necessary
  "<leader>w-", -- duplicate split window <C-W>s
  "<leader>w|", -- duplicate split window <C-W>v
  -- "<leader>qq", -- quit all
}) do
  vim.keymap.del("n", key)
end

--------------------------------------------------------------------------
-- Change mappings
--------------------------------------------------------------------------

------------ START BUFFERS ------------

map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>")
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>")

map("n", "<S-Tab>", "<cmd>bprevious<cr>")
map("n", "<Tab>", "<cmd>bnext<cr>")

map("n", "<S-Tab>", "<cmd>bprevious<cr>")
map("n", "<Tab>", "<cmd>bnext<cr>")
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
------------ END BUFFERS ------------

-- Mapping which-key things > plugin manager lazyvim
map("n", "<leader>pp", "<cmd>Lazy<cr>", { desc = "Lazy [P]lugins" })
map("n", "<leader>pm", "<cmd>Mason<cr>", { desc = "[M]ason" })

--------------------------------------------------------------------------
-- Add mappings
--------------------------------------------------------------------------

------------ GENERAL ------------
-- Exit insert and visual mode
map("i", "jj", "<Esc>", { noremap = true, silent = true })
-- map("v", "jk", "<Esc>", { noremap = true, silent = true }) -- Feels bad

-- Not compatible with mini.animate:
-- For centering the screen after scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("v", "<C-d>", "<C-d>zz")
map("v", "<C-u>", "<C-u>zz")
------------ END GENERAL ------------

------------ BETTER LINE NAVIGATION ------------
map("n", "<S-h>", "^", { noremap = true, silent = true })
map("n", "<S-l>", "$", { noremap = true, silent = true })
map("v", "<S-h>", "^", { noremap = true, silent = true })
map("v", "<S-l>", "$", { noremap = true, silent = true })
------------ BETTER LINE NAVIGATION ------------

-- Add show tabs to tabs submenu
map("n", "<leader><tab>s", "<cmd>tabs<cr>", { desc = "[S]how Tabs" })

-- map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
-- The \ was mapped to something else, need to check what
