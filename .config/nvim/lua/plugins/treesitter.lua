---@param base 'cache'|'config'|'config_dirs'|'data'|'data_dirs'|'log'|'run'|'state'
---@param p string|string[]
local append_rtp = function(base, p)
  vim.opt.runtimepath:append(vim.fn.stdpath(base) .. p)
end

local queries = append_rtp("data", "/lazy/nvim-treesitter/runtime/queries")
append_rtp("data", "/lazy/nvim-treesitter/queries")

local TS_TIMEOUT_MAX = 300000 -- Note this is the default, this is fine but... yeaah

local ts_langs = require("plugins.lsp.treesitter_langs")

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false, -- no longer supports/needs lazy loading!
  build = ":TSUpdate",
  ---@class vim.treesitter.Config
  opts = {
    --- Defaults to the `stdpath('data')/site` dir.
    install_dir = queries,
    -- languages = require("plugins.lsp.treesitter_langs").flatten(),
    ensure_installed = ts_langs.flatten(),

    -- indent = { enable = true },
    -- highlight = { enable = true },
    -- folds = { enable = true },
  },

  config = function(_, opts)
    local TS = require("nvim-treesitter")

    opts = opts or {}
    if not opts.ensure_installed and #opts.ensure_installed == 0 then
      require("utils.output").warn("No treesitter languages specified in ensure_installed, using default list.")
      opts.ensure_installed = ts_langs.flatten()
    end

    if not opts.install_dir then
      opts.install_dir = queries
    end

    -- check if the dir actually exists or not to indicate first time run or alrady setup
    local first_run = vim.fn.isdirectory(opts.install_dir) == 0
    if first_run then
      TS.install(opts.ensure_installed):wait(TS_TIMEOUT_MAX) -- synchronous, wait for the installation to finish before proceeding
    else
      TS.install(opts.ensure_installed) -- This is async
    end
  end,
}

---@see TREESITTER "https://github.com/nvim-treesitter/nvim-treesitter#adding-custom-languages"

-- local TSPARSERS = require("nvim-treesitter.parsers")
--
-- :: prefer to put all custom parsers into a list or something of 'install_info' types and hand them through (potentially with a tag: "remote" | "local" or similar.
-- local custom_parsers = {}

--   vim.api.nvim_create_autocmd('User', {
--     pattern = 'TSUpdate',
--   callback = function()
--     TSPARSERS.[[LANG]] = {
--       ------------- REMOTE
--       -- install_info = {
--       --   url = 'https://github.com/zimbulang/tree-sitter-zimbu',
--       --   revision = <sha>, -- commit hash for revision to check out; HEAD if missing
--       --   -- optional entries:
--       --   branch = 'develop', -- only needed if different from default branch
--       --   location = 'parser', -- only needed if the parser is in subdirectory of a "monorepo"
--       --   generate = true, -- only needed if repo does not contain pre-generated `src/parser.c`
--       --   generate_from_json = false, -- only needed if repo does not contain `src/grammar.json` either
--       --   queries = 'queries/neovim', -- also install queries from given directory
--       -- },
--
--       ------------- LOCAL CHECKOUT
--   -- install_info = {
--   --   path = '~/parsers/tree-sitter-zimbu',
--   --   -- optional entries
--   --   location = 'parser',
--   --   generate = true,
--   --   generate_from_json = false,
--   --   queries = 'queries/neovim', -- symlink queries from given directory
--   -- },
--     }
--   end
-- })
