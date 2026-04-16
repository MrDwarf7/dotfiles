-- local bm = require("blink_modules").setup()

return {
  "Saghen/blink.cmp",
  lazy = false,
  event = { "InsertEnter", "CmdlineEnter", "WinEnter" },

  -- ---@type LazyEventSpec
  -- event = { "CursorMoved", "VeryLazy" },
  dependencies = {
    -- stylua: ignore start
    -- { "j-hui/fidget.nvim", enabled = false,            lazy = true, event = "VeryLazy" },
    { "Saghen/blink.compat",                          lazy = false },
    { "L3MON4D3/LuaSnip",                             lazy = false, version = "2.*" ,
      dependencies = { { "rafamadriz/friendly-snippets" } } },
    { "rafamadriz/friendly-snippets",                 lazy = true },
    { "folke/lazydev.nvim",                           lazy = false, ft = "lua" },
    { "fang2hou/blink-copilot",                       lazy = true },
    {
      "zbirenbaum/copilot.lua",                       lazy = true,
      opts = {
        max_completions = 4, -- These set 'global' defaults. We override in sources.lua
        max_attempts = 2,
      },

    },
    { "xzbdmw/colorful-menu.nvim",                    lazy = false },
    -- { "barrettruth/blink-cmp-ghostty",                lazy = false },
    -- -- { "disrupted/blink-cmp-conventional-commits",     lazy = false },
    { "bydlw98/blink-cmp-sshconfig",                  lazy = true, enabled = true, build = "make" },
    { "barrettruth/blink-cmp-tmux",                   lazy = true },
    { "junkblocker/blink-cmp-wezterm",                lazy = true, enabled = true },
    -- { "Kaiser-Yang/blink-cmp-avante",                 lazy = true },
    -- { "mikavilpas/blink-ripgrep.nvim",                lazy = true, enabled = true, version = "*" }, -- use the latest stable version
    { "bydlw98/blink-cmp-env",                        lazy = true, enabled = true },
    { "archie-judd/blink-cmp-words",                  lazy = true, enabled = true },
    -- { "xieyonn/blink-cmp-dat-word",                   lazy = true },

    -- stylua: ignore end
  },
  -- version = "*",
  branch = "v1",
  build = "cargo build --profile release",
  -- build = 'cargo build --release',
  ---@type blink.cmp.Config
  opts = {
    fuzzy = {
      implementation = "prefer_rust",
      sorts = {
        "exact",
        "sort_text",
        "score",
        "label",
        "kind",
      },
    },

    -- {{{ completion
    completion = require("blink_modules.completion"), -- menu_type
    -- completion }}}

    -- {{{ signature
    signature = require("blink_modules.signature"),
    -- signature }}}

    --- {{{ cmdline
    cmdline = require("blink_modules.cmdline"),
    --- cmdline }}}

    --- {{{ keymaps
    keymap = require("blink_modules.blink_keymap"),
    --- keymaps }}}

    snippets = {
      preset = "luasnip",
      score_offset = 99,
    },

    ----------------------

    --- {{{ sources
    sources = require("blink_modules.sources"),
    --- sources }}}
  },
}
