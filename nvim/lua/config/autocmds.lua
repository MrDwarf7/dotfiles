

local api = vim.api

local colors = {
  fg = "#76787d",
  bg = "#252829",
}

-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })


--- Remove all trailing whitespace on save
local TrimWhiteSpaceGrp = api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })
api.nvim_create_autocmd("BufWritePre", {
  command = [[:%s/\s\+$//e]],
  group = TrimWhiteSpaceGrp,
})

-- Highlight when yanking
api.nvim_create_autocmd("TextYankPost", {
   callback = function()
      vim.highlight.on_yank({ timeout = 69 })
   end,
})

-- go to last loc when opening a buffer
api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})


-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command = "set cursorline",
  group = cursorGrp,
})
api.nvim_create_autocmd(
  { "InsertEnter", "WinLeave" },
  { pattern = "*", command = "set nocursorline", group = cursorGrp }
)


-- Enable spell checking for certain file types
api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  -- { pattern = { "*.txt", "*.md", "*.tex" }, command = [[setlocal spell<cr> setlocal spelllang=en,de<cr>]] }
  {
    pattern = { "*.txt", "*.md", "*.tex" },
    callback = function()
      vim.opt.spell = true
      vim.opt.spelllang = "en,de"
    end,
  }
)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<leader>v', "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)
  end,
})


api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    -- change the background color of floating windows and borders.
    vim.cmd('highlight NormalFloat guibg=none guifg=none')
    vim.cmd('highlight FloatBorder guifg=' .. colors.fg .. ' guibg=none')
    vim.cmd('highlight NormalNC guibg=none guifg=none')

    -- change neotree background colors
    -- Default: NeoTreeNormal  xxx ctermfg=223 ctermbg=232 guifg=#d4be98 guibg=#141617
    vim.cmd('highlight NeoTreeNormal guibg=#1d2021')
    ---- vim.cmd('highlight NeoTreeFloatNormal guifg=#1d2021 guibg=#141617')
    vim.cmd('highlight NeoTreeFloatBorder guifg=#958272 guibg=#1d2021')
    vim.cmd('highlight NeoTreeEndOfBuffer guibg=#1d2021') -- 1d2021
  end,
})


-- close some filetypes with <q>
api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})


-- resize neovim split when terminal is resized
api.nvim_command('autocmd VimResized * wincmd =')

-- api.nvim_create_autocmd("ColorScheme", {
--   pattern = "kanagawa",
--   callback = function()
--     if vim.o.background == "light" then
--       vim.fn.system("kitty +kitten themes Kanagawa_light")
--     elseif vim.o.background == "dark" then
--       vim.fn.system("kitty +kitten themes Kanagawa_dragon")
--     else
--       vim.fn.system("kitty +kitten themes Kanagawa")
--     end
--   end,
-- })

-- Keymap for .py file
-- May have to edit some thing here --
api.nvim_create_autocmd("BufEnter", {
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

--------------------------- OLD VERSIONN OF THINGS --------------------------------
-- -- Disable auto comment
-- vim.api.nvim_create_autocmd("BufEnter", {
--    callback = function()
--       vim.opt.formatoptions = { c = false, r = false, o = false }
--    end,
-- })
--
-- -- Turn on spell check for markdown and text file
-- vim.api.nvim_create_autocmd("BufEnter", {
--    pattern = { "*.md" },
--    callback = function()
--       vim.opt_local.spell = true
--    end,
-- })
--
-- -- Tab format for .lua file
-- vim.api.nvim_create_autocmd("BufEnter", {
--    pattern = { "*.lua" },
--    callback = function()
--       vim.opt.shiftwidth = 3
--       vim.opt.tabstop = 3
--       vim.opt.softtabstop = 3
--       -- vim.opt_local.colorcolumn = {70, 80}
--    end,
-- })
--

