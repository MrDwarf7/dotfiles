-- ons can be tested out via :options
-- = OPTIONS

local options = {
    -- set to true or false etc.
    relativenumber = true,                                  -- sets vim.opt.relativenumber
    number = true,                                          -- sets vim.opt.number
    spell = false,                                          -- sets vim.opt.spell
    signcolumn = "yes",                                     -- sets vim.opt.signcolumn to auto
    wrap = false,                                           -- sets vim.opt.wrap
    breakindent = true,                                     -- wrap indent to match  line start
    clipboard = "unnamedplus",                              -- connection to the system clipboard
    completeopt = { "menu", "menuone", "noselect" },        -- Options for insert mode completion
    copyindent = true,                                      -- copy the previous indentation on autoindenting
    cursorline = true,                                      -- highlight the text line of the cursor
    expandtab = true,                                       -- enable the use of space in tab
    fileencoding = "utf-8",                                 -- file content encoding for the buffer
    fillchars = { eob = " " },                              -- disable `~` on nonexistent lines
    foldenable = true,                                      -- enable fold for nvim-ufo
    foldlevel = 99,                                         -- set high foldlevel for nvim-ufo
    foldlevelstart = 99,                                    -- start with all code unfolded
    foldcolumn = vim.fn.has "nvim-0.9" == 1 and "1" or nil, -- show foldcolumn in nvim 0.9
    history = 100,                                          -- number of commands to remember in a history table
    ignorecase = true,                                      -- case insensitive searching
    infercase = true,                                       -- infer cases in keyword completion
    laststatus = 3,                                         -- global statusline
    linebreak = true,                                       -- wrap lines at 'breakat'
    mouse = "a",                                            -- enable mouse support
    preserveindent = true,                                  -- preserve indent structure as much as possible
    pumheight = 10,                                         -- height of the pop up menu
    shiftwidth = 4,                                         -- number of space inserted for indentation
    showmode = false,                                       -- disable showing modes in command line
    showtabline = 2,                                        -- always display tabline
    smartcase = true,                                       -- case sensitive searching
    splitbelow = true,                                      -- splitting a new window below the current one
    splitright = true,                                      -- splitting a new window at the right of the current one
    tabstop = 4,                                            -- number of space in a tab
    termguicolors = true,                                   -- enable 24-bit RGB color in the TUI
    timeoutlen = 300,                                       -- shorten key timeout length a little bit for which-key
    undofile = true,                                        -- enable persistent undo
    updatetime = 100,                                       -- length of time to wait before triggering the plugin
    virtualedit = "block",                                  -- allow going past end of line in visual block mode
    writebackup = false,                                    -- disable making a backup before overwriting a file
    --
    incsearch = true,
    backup = false,
    cmdheight = 1,
    hlsearch = true,
    smartindent = true,
    splitkeep = "screen",
    swapfile = false,
    softtabstop = 4,
    numberwidth = 4,
    scrolloff = 10,  --Scrolloff maintains a margin at top or bottom of screen.,
    sidescrolloff = 10,
    showcmd = false, --May want to play around with this one
    ruler = false,
    guifont = "CaskaydiaCove Nerd Font Mono:h12",
    title = true,
    confirm = true,
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

local global = {
    autoformat_enabled = true,       -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    autopairs_enabled = true,        -- enable autopairs at start
    cmp_enabled = true,              -- enable completion at start
    codelens_enabled = true,         -- enable or disable automatic codelens refreshing for lsp that support it
    diagnostics_mode = 3,            -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    highlighturl_enabled = true,     -- highlight URLs by default
    icons_enabled = true,            -- disable icons in the UI (disable if no nerd font is available)
    inlay_hints_enabled = false,     -- enable or disable LSP inlay hints on startup (Neovim v0.10 only)
    lsp_handlers_enabled = true,     -- enable or disable default vim.lsp.handlers (hover and signature help)
    semantic_tokens_enabled = true,  -- enable or disable LSP semantic tokens on startup
    ui_notifications_enabled = true, -- disable notifications (TODO: rename to  notifications_enabled in AstroNvim v4)
    git_worktrees = nil,             -- enable git integration for detached worktrees (specify a table where each entry is of the form { toplevel = vim.env.HOME, gitdir=vim.env.HOME .. "/.dotfiles" })
    resession_enabled = false,       -- enable experimental resession.nvim session management (will be default in AstroNvim v4)
    -- from my original config
    loaded_netrw = 1,
    loaded_netrwPlugin = 1,

    mapleader = ' ',
    maplocalleader = ' ',
    loaded_netrw = 1,
    loaded_netrwPlugin = 1,
}

for k, v in pairs(global) do
    vim.g[k] = v
end

-- vim.g.maplocalleader = ' '
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

for k, v in pairs(options) do
    vim.opt[k] = v
end
