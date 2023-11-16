---@diagnostic disable: different-requires
if vim.g.neovide then
  require("base.neovide")
end


if vim.g.vscode then
  require("base.keymaps")
  require("base.vscode")
  -- vim.opt.clipboard:append("unnamedplus")
end


-- require("Comment").setup()
-- require("config.mini")

if not vim.g.vscode and not vim.g.neovide then
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


-- temp here for testing cos VS Code is picking up commented things for some stupid reason

-- require("base.options")
-- require("base.lazy")
--require("config.misc")
-- require("config.dap")
-- require("config.lualine")
-- require("base.autocmds")
--require("misc")
-- require("config.gitsigns")
-- require("config.tele")
-- require("config.treesitter")
-- require("config.lsp")
-- require("config.linter")

-- temp here for testing cos VS Code is picking up commented things for some stupid reason



--[[ vim.g.mapleader = " " ]]
--[[ vim.g.maplocalleader = " " ]]
--[[ vim.o.termguicolors = true ]]
-- require("config.trouble") -- sources from 'plugins_list'
-- require("config.toggleterm") -- Disabled for now -- need to configure it properly
-- vim: ts=8 sts=2 sw=2 et
