-- ons can be tested out via :options
-- = OPTIONS

local options = {
    incsearch = true,
    backup = false,
    clipboard = "unnamedplus",
    cmdheight = 1,
    completeopt = { "menuone", "noselect" },
    fileencoding = "utf-8",
    hlsearch = true,
    ignorecase = true,
    mouse = "a",
    pumheight = 10,
    showmode = false, -- TEMP - On until install of lua line/buffline etc etc.
    showtabline = 0,
    smartcase = true,
    smartindent = true,
    splitbelow = true,
    splitright = true,
    splitkeep = "screen",
    swapfile = false,
    termguicolors = true,
    timeoutlen = 300, -- Time to wait for mapped sequence to comp.,
    undofile = true,
    updatetime = 100,
    writebackup = false,
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
    cursorline = true,
    softtabstop = 4,
    number = true,
    relativenumber = true,
    numberwidth = 4,
    signcolumn = "yes",
    wrap = false,
    scrolloff = 10, --Scrolloff maintains a margin at top or bottom of screen.,
    sidescrolloff = 10,
    laststatus = 0,
    showcmd = false, --May want to play around with this one
    ruler = false,
    guifont = "CaskaydiaCove Nerd Font Mono:h12",
    title = true,
    confirm = true,
    fillchars = { eob = " " },
    list = true,

    cursorlineopt = "line",
    background = "dark",
    backspace = "indent,eol,start",

    shell = "pwsh",
    shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
}

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

for k, v in pairs(options) do
    vim.opt[k] = v
end
