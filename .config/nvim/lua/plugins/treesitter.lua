local queries = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/queries"
vim.opt.runtimepath:append(queries)

-- TODO: eventually deprecate this file in favor of using a new
-- LangHub module that consolidates 'suites'
-- local lang_tables = require("lang_tables")

---@type vim.treesitter
local ts_native = vim.treesitter

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  ---@class vim.treesitter.Config
  opts = {
    --- Defaults to the `stdpath('data')/site` dir.
    -- install_dir = queries,
    languages = require("lang_tables").ts_ensure_installed(),
  },
  ---@param opts? any|nil
  ---@param _? LazyMeta|nil
  config = function(opts, _)
    local ts = require("nvim-treesitter")
    ts.setup(opts)
    -- ts.install(require("lang_tables").ts_all())
    ts.install(opts.languages)
    return ts
  end,
}

-- return {
--   "nvim-treesitter/nvim-treesitter",
--   -- lazy = false,
--   -- lazy = true,
--   -- ---@type LazyEventSpec
--   -- event = "BufReadPost",
--   -- event = "WinLeave",
--   -- branch = "master",
--   event = { "BufReadPost", "BufNewFile" },
--   build = ":TSUpdate",
--   opts = {
--     install = require("lang_tables").ts_ensure_installed(),
--     highlight = { enable = true },
--     ensure_installed = require("lang_tables").ts_ensure_installed(),
--     incremental_selection = {
--       enable = false,
--     },
--     indent = {
--       disable = {
--         "html",
--         "javascript",
--         "typescript",
--         "css",
--         "rust",
--       },
--       -- disable = function(lang, buf)
--       --   local indent_disabled = {
--       --     "html",
--       --     "javascript",
--       --     "typescript",
--       --     "css",
--       --     "rust",
--       --   }
--       --   if lang == vim.tbl_keys(indent_disabled) then
--       --     return true
--       --   end
--       -- end,
--       enable = true,
--     },
--
--     textobjects = {
--       move = {
--         enable = false,
--         goto_next_start = {
--           ["]f"] = "@function.outer",
--           ["]o"] = "@class.outer",
--           ["]a"] = "@parameter.inner",
--         },
--         goto_next_end = {
--           ["]F"] = "@function.outer",
--           ["]O"] = "@class.outer",
--           ["]A"] = "@parameter.inner",
--         },
--         goto_previous_start = {
--           ["[f"] = "@function.outer",
--           ["[o"] = "@class.outer",
--           ["[a"] = "@parameter.inner",
--         },
--         goto_previous_end = {
--           ["[F"] = "@function.outer",
--           ["[O"] = "@class.outer",
--           ["[A"] = "@parameter.inner",
--         },
--       },
--     },
--
--     autotag = {
--       enable = true,
--     },
--     -- sync_install = true,
--     auto_install = true,
--   },
--
--   -- init = function()
--   --   if package.loaded["nvim-treesitter.configs"] then
--   --     return
--   --   end
--   --
--   --   vim.defer_fn(function()
--   --     if not package.loaded["nvim-treesitter.configs"] then
--   --       require("nvim-treesitter.configs").setup(require("plugins.treesitter").opts)
--   --     end
--   --   end, 80)
--   -- end,
--
--   config = function(_, opts)
--     opts = opts or {}
--     require("nvim-treesitter.configs").setup(opts)
--   end,
-- }
