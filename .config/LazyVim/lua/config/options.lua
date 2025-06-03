-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local folding = require("utils.folding")

local opt = vim.opt

-- vim.g.snacks_animate = true
vim.lsp.inlay_hint.enable()

vim.g.lazyvim_python_lsp = "basedpyright" -- Also can use "basedpyright"
vim.g.lazyvim_python_ruff = "ruff" -- Also supports "ruff-lsp" for the old version

vim.g.os = require("utils.arch").get_os()
vim.g.lazyvim_prettier_needs_config = true
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"
vim.g.rust_diagnostics = "rust-analyzer" -- Not realy needed, but nice if I want to transition away from LazyVim

-- DOC BORDER -- Off because which-key ends up with a really thick border, even on "single"
-- if vim.fn.has("nvim-0.11") == 0 then
--   vim.o.winborder = "single"
-- end

opt.conceallevel = 0

--- Originals
opt.fillchars = {
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldcolumn = "1"
opt.foldenable = true

opt.listchars = {
  tab = ">>>",
  trail = "·",
  nbsp = "␣",
}

--- Default LazyVim's
-- opt.fillchars = {
--   fold = " ",
--   foldopen = "",
--   foldclose = "",
--   foldsep = " ",
--   diff = "╱",
--   eob = " ",
-- }

opt.formatexpr = "v:lua.require('lazyvim.util').format.formatexpr()"

-- Different to default LazyVim
opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
opt.grepprg = "rg --vimgrep --no-heading --smartcase --hidden"

opt.pumblend = 15 -- default is 10
opt.pumheight = 30 -- default is 10
opt.scrolloff = 6 -- default is 4
opt.shortmess:append({
  W = true,
  I = true,
  c = true,
  C = true,
  s = true,
  F = true,
  S = true,
  w = true,
  a = true,
  l = true,
})
-- TEST:
-- opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.splitkeep = "topline" -- default WAS "screen"

opt.timeoutlen = vim.g.vscode and 1000 or 350
opt.updatetime = 250
opt.winminwidth = 6 -- Minimum window width

opt.wrapscan = true
opt.wrap = false -- Added, test with other plugins etc

-- BUG: Something here isn't letting me use <S-v>kkk<Space>L-stuff> will need to look tldr; (foldmethod == "expr") != true
-- ||
-- if vim.fn.has("nvim-0.10") == 1 then
--   opt.smoothscroll = true
--   opt.foldexpr = "v:lua.require('lazyvim.util').ui.foldexpr()"
--   opt.foldmethod = "expr"
--   opt.foldtext = ""
-- else

opt.foldmethod = "indent"
-- opt.foldexpr = folding.foldtext()
opt.foldexpr = "v:lua.require('lazyvim.util').ui.foldtext()"

-- end

vim.g.markdown_recommended_style = 0

-- vim.highlight = 55
