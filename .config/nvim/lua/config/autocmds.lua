local keymaps = require("config.keymaps")

local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ timeout = 55 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitconfig", ".gitconfig" },
  callback = function()
    local comment_str = vim.filetype.get_option("gitconfig", "commentstring")
    if comment_str ~= "#" then
      vim.cmd([[ setlocal commentstring=#\ %s ]])
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { ".gitignore_global", ".gitignore_local", ".gitignore.local", ".gitignore.global" },
  callback = function()
    vim.cmd([[ set ft=gitignore ]])
    -- vim.bo.filetype = "gitignore"
  end,
})

--- Use 'q' to close quickfix, jumplist, and other help buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "help", "checkhealth", "jumplist", "lspinfo" },
  callback = function()
    -- keymaps.map("n", "q", "<CMD>close<CR>")
    vim.keymap.set("n", "q", "<CMD>bd<CR>", { silent = true, buffer = true })
  end,
})
