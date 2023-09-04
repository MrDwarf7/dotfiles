-- local autocmd = vim.api.nvim_create_autocmd
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
-- NvChad\Custom\init.lua
local opt = vim.opt
local g = vim.g
if vim.g.neovide then
  vim.o.guifont= "CaskaydiaCove Nerd Medium:h12"
  g.neovide_scale_factor = 0.8
  g.neovide_theme = "auto"
  g.neovide_remember_window_size = true
  g.neovide_cursor_animation_length = 0.2
  g.neovide_cursor_trail_size = 0.2
  g.neovide_hide_mouse_when_typing = false
  opt.termguicolors = true
end

vim.opt.relativenumber = true
vim.api.nvim_set_var("shell", "powershell.exe")
vim.api.nvim_set_var("shellxquote", "")
vim.api.nvim_set_var("shellcmdflag", "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command ")
vim.api.nvim_set_var("shellquote", "")
vim.api.nvim_set_var("shellpipe", "| Out-File -Encoding UTF8 %s")
vim.api.nvim_set_var("shellredir", "| Out-File -Encoding UTF8 %s")

