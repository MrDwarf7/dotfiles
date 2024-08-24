if vim.g.neovide then
  require("base.neovide")
end


if vim.g.vscode then
  require("base.options")
  require("base.lazy")
  --require("config.misc")
  require("base.keymaps")
  require("base.vscode")
  require("Comment").setup()
  require("config.mini")
else
  require("base.options")
  require("base.lazy")
  --require("config.misc")
  require("base.keymaps")

  vim.cmd.colorscheme("catppuccin")
  require("git-worktree").setup()
  require("Comment").setup()
  require("config.dap")
  require("config.lualine")
  require("base.autocmds")
  require("config.gitsigns")
  require("config.tele")
  require("config.treesitter")
  require("config.lsp")
  require("config.linter")
  require("config.mini")
end
