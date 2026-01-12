local opt = vim.opt

opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-- Global
opt.fillchars = {
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.listchars = {
  tab = ">>>",
  trail = "·",
  nbsp = "␣",
}

opt.scrolloff = 6
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldnestmax = 4

-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.linebreak = true -- wrap at a character in 'breakat' rather than at the last character that fits on the screen.wrap at 'co

opt.pumblend = 15 -- Popup blend
opt.pumheight = 30 -- Maximum number of entries in a popup

-- opt.autowrite = true -- Enable auto write, so that modified buffers are written when switching buffers.
opt.conceallevel = 0
opt.formatoptions = "jcroqlnt" -- tcqj
opt.inccommand = "nosplit" -- preview incremental substitute
-- opt.jumpoptions = "view" -- Define how the jumplist attempts to restore the cursor position
opt.shiftround = true -- Round indent
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 6 -- Minimum window width
vim.g.markdown_recommended_style = 0
opt.sessionoptions = {
  --
  -- "blank", -- not needed.
  "buffers",
  "curdir",
  "folds",
  "globals",
  "help",
  -- "localoptions", -- not needed.
  -- "options", -- not needed.
  "skiprtp", -- Not sure if needed, but I assume this will be loaded regardless due to Lazy pkg manager.
  "resize", -- lines & columns restoration.
  -- "sesdir", -- directory where sessions are saved becomes the CWD.
  "tabpages", -- tabpages, without this only 'current' tab is restored.
  -- "terminal", -- not needed.
  -- "winpos", -- not needed.
  "winsize",
  --
  -- "slash", -- deprecated
  -- "unix", -- deprecated
}

-- opt.showtabline = 2
opt.mouse = "a"
opt.backupcopy = "yes"
opt.undolevels = 10000
-- opt.shortmess = { c = true, s = true, C = true, F = true, I = true, S = true, W = true, w = true, a = true, l = true }
-- opt.showmode = false
opt.showmode = false
opt.hidden = true
opt.splitright = true
opt.splitbelow = true
opt.wrapscan = true
opt.wrap = false -- Added, test with other plugins etc
opt.backup = false
opt.writebackup = false
opt.showcmd = true
-- opt.showcmdloc = "statusline"
opt.showmatch = true
opt.ignorecase = true
opt.hlsearch = true
opt.smartcase = true
opt.errorbells = false
opt.joinspaces = false
opt.title = true
opt.backspace = "indent,eol,start" -- Added
opt.encoding = "UTF-8"
opt.completeopt = "menu,menuone,noselect"

-- vim.cmd([[
-- set cmdheight=0
-- set shortmess+=csCFISWwal
-- ]])

-- opt.cmdheight = 0

opt.shortmess:append({
  W = true,
  I = true,
  c = true,
  C = true,
  s = true,
  F = true,
  -- S = true, -- when noice/nui is on, handles the virtual text for searching ( [N/K] where N is current of, and K is total of search)
  w = true,
  a = true,
  l = true,
})

-- opt.laststatus = 3
opt.timeoutlen = 350
if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "topline"
end

-- tabs / shift / indent
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.expandtab = true
opt.shiftwidth = 2

-- Buffer
opt.fileformat = "unix"
opt.spelllang = "en"
opt.swapfile = false
opt.undofile = true

---@diagnostic disable-next-line: assign-type-mismatch
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Window
opt.number = true
opt.colorcolumn = "+1"
opt.list = true
opt.signcolumn = "yes"
opt.relativenumber = true
opt.cursorline = true

-- if vim.fn.has("nvim-0.10") == 1 then
opt.smoothscroll = true
-- end

-- Use ripgrep as grep tool
vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
vim.o.grepprg = "rg --vimgrep --no-heading --smartcase --hidden"

--------------------------------
vim.o.winborder = "single"
vim.g.mapleader = " "
--------------------------------

-- New things I added from his config
vim.o.breakindent = true
-- vim.wo.number = true
vim.o.updatetime = 250
--vim.wo.signcolumn = "yes"
vim.o.termguicolors = true -- Disabled as moved to init for lazy/notfiy
-- g.skip_ts_context_commentstring_module = true

vim.o.background = "dark"

vim.cmd("colorscheme default")
-- vim.cmd(":hi statusline guibg=NONE")
