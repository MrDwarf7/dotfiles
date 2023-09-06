-- Functions here > 

-- Only highlight when searching
-- vim.api.nvim_create_autocmd("CmdlineEnter", {
--    callback = function()
--       local cmd = vim.v.event.cmdtype
--       if cmd == "/" or cmd == "?" then
--          vim.opt.hlsearch = true
--       end
--    end,
-- })
-- vim.api.nvim_create_autocmd("CmdlineLeave", {
--    callback = function()
--       local cmd = vim.v.event.cmdtype
--       if cmd == "/" or cmd == "?" then
--          vim.opt.hlsearch = false
--       end
--    end,
-- })

-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
   callback = function()
      vim.highlight.on_yank({ timeout = 70 })
   end,
})

-- Disable auto comment
vim.api.nvim_create_autocmd("BufEnter", {
   callback = function()
      vim.opt.formatoptions = { c = false, r = false, o = false }
   end,
})

-- Turn on spell check for markdown and text file
vim.api.nvim_create_autocmd("BufEnter", {
   pattern = { "*.md" },
   callback = function()
      vim.opt_local.spell = true
   end,
})

-- Tab format for .lua file
vim.api.nvim_create_autocmd("BufEnter", {
   pattern = { "*.lua" },
   callback = function()
      vim.opt.shiftwidth = 3
      vim.opt.tabstop = 3
      vim.opt.softtabstop = 3
      -- vim.opt_local.colorcolumn = {70, 80}
   end,
})

-- Keymap for .py file
-- May have to edit some thing here --
vim.api.nvim_create_autocmd("BufEnter", {
   pattern = { "*.py" },
   callback = function()
      vim.keymap.set(
         "n",
         "<Leader>rp",
         ":!py %<CR>",
         { silent = true }
      )
   end,
})
