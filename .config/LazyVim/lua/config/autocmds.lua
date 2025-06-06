-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

local function del_au(name)
  return vim.api.nvim_del_augroup_by_name("lazyvim_" .. name)
end

-- Deletions
del_au("highlight_yank")
-- del_au("resize_splits")

--

-- Recerate
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ timeout = 55 })
  end,
})

-- Added

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "sql",
  },
  callback = function()
    vim.b.dadbod_completion = true
    vim.cmd([[setlocal omnifunc=vim_dadbod_completion#omni]])
  end,
  -- Previously - not callback, and was set to command key
  -- command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "gitconfig",
    ".gitconfig",
  },
  -- commmand = vim.cmd([[ setlocal commentstring=#\ %s ]]),
  callback = function()
    local comment_str = vim.filetype.get_option("gitconfig", "commentstring")
    if comment_str ~= "#" then
      vim.cmd([[ setlocal commentstring=#\ %s ]])
    end
  end,
})

-- Hides copilot suggestions on menu open
vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuOpen",
  callback = function()
    require("copilot.suggestion").dismiss()
    vim.b.copilot_suggestion_hidden = true
  end,
})

-- re-shows copilot suggestions on menu close
vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuClose",
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})
