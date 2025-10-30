local queries = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/queries"
vim.opt.runtimepath:append(queries)

-- TODO: eventually deprecate this file in favor of using a new
-- LangHub module that consolidates 'suites'
-- local lang_tables = require("lang_tables")

---@type LazyPluginBase
return {
  "nvim-treesitter/nvim-treesitter",
  -- lazy = false,
  -- lazy = true,
  -- ---@type LazyEventSpec
  -- event = "BufReadPost",
  -- event = "WinLeave",
  branch = "master",
  build = ":TSUpdate",
  opts = {
    highlight = { enable = true },
    ensure_installed = require("lang_tables").ts_ensure_installed(),
    incremental_selection = {
      enable = false,
    },
    indent = {
      disable = {
        "html",
        "javascript",
        "typescript",
        "css",
        "rust",
      },
      -- disable = function(lang, buf)
      --   local indent_disabled = {
      --     "html",
      --     "javascript",
      --     "typescript",
      --     "css",
      --     "rust",
      --   }
      --   if lang == vim.tbl_keys(indent_disabled) then
      --     return true
      --   end
      -- end,
      enable = true,
    },

    textobjects = {
      move = {
        enable = false,
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]o"] = "@class.outer",
          ["]a"] = "@parameter.inner",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]O"] = "@class.outer",
          ["]A"] = "@parameter.inner",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[o"] = "@class.outer",
          ["[a"] = "@parameter.inner",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[O"] = "@class.outer",
          ["[A"] = "@parameter.inner",
        },
      },
    },

    autotag = {
      enable = true,
    },
    -- sync_install = true,
    auto_install = true,
  },

  -- init = function()
  --   if package.loaded["nvim-treesitter.configs"] then
  --     return
  --   end
  --
  --   vim.defer_fn(function()
  --     if not package.loaded["nvim-treesitter.configs"] then
  --       require("nvim-treesitter.configs").setup(require("plugins.treesitter").opts)
  --     end
  --   end, 80)
  -- end,

  config = function(_, opts)
    opts = opts or {}
    require("nvim-treesitter.configs").setup(opts)
  end,
}
