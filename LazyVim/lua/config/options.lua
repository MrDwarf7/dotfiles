-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

local opt = vim.opt

opt.scrolloff = 8
opt.sidescrolloff = 4
opt.preserveindent = true
opt.backspace = "indent,eol,start"
opt.shell = "pwsh"
opt.shellcmdflag =
  "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
opt.shellquote = ""
opt.shellxquote = ""
