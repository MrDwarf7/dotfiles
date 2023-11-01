--[[ vim.g.mapleader = " " ]]
--[[ vim.g.maplocalleader = " " ]]
--[[ vim.o.termguicolors = true ]]

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

--require("misc")
require("config.gitsigns")
require("config.tele")
require("config.treesitter")
require("config.lsp")
require("config.linter")
require("config.mini")

-- require("config.trouble") -- sources from 'plugins_list'
-- require("config.toggleterm") -- Disabled for now -- need to configure it properly
-- vim: ts=8 sts=2 sw=2 et
