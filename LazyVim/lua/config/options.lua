-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

local opt = vim.opt

opt.tabstop = 4
opt.tabstop = 4
opt.shiftwidth = 4

opt.scrolloff = 8
opt.sidescrolloff = 4
opt.preserveindent = true
opt.conceallevel = 0
opt.backspace = "indent,eol,start"
opt.shell = "pwsh"
opt.shellcmdflag =
  "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
opt.shellquote = ""
opt.shellxquote = ""
opt.writebackup = false
opt.fillchars = { eob = " " } -- disable `~` on nonexistent line
---@diagnostic disable-next-line: assign-type-mismatch
opt.foldcolumn = vim.fn.has("nvim-0.9") == 1 and "1" or nil
opt.showtabline = 2
