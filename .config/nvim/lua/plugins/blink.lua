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

    { "xzbdmw/colorful-menu.nvim",                    lazy = false },

    ---NOTE: remember that if you're wondering why snippets aren't working/turned on:
    --- check the 'transform_items function in blink_modules.sources,
    --- as that turns ALL snippets off that are associated with blink.cmp.types.
    --- Will need to comment it, or filter by specific's

    { "L3MON4D3/LuaSnip",                             lazy = true, version = "2.*" ,
      -- dependencies = { "rafamadriz/friendly-snippets" }
    },

    { "rafamadriz/friendly-snippets",                 lazy = false },
    { "folke/lazydev.nvim",                           lazy = false,                ft = "lua" },
    { "fang2hou/blink-copilot",                       lazy = true },
    { "zbirenbaum/copilot.lua",                       lazy = true },
    { "bydlw98/blink-cmp-sshconfig",                  lazy = true, enabled = true, ft = "sshconfig", build = "make" },
    { "barrettruth/blink-cmp-tmux",                   lazy = true,                 ft = "tmux" },
    { "junkblocker/blink-cmp-wezterm",                lazy = true, enabled = true, ft = "lua" },
    { "bydlw98/blink-cmp-env",                        lazy = true, enabled = true, ft = "env" },
    { "archie-judd/blink-cmp-words",                  lazy = true, enabled = true, ft = { "markdown", "text", "txt" } },

    -- { "barrettruth/blink-cmp-ghostty",                lazy = false },
    -- -- { "disrupted/blink-cmp-conventional-commits",     lazy = false },
    -- { "Kaiser-Yang/blink-cmp-avante",                 lazy = true },
    -- { "mikavilpas/blink-ripgrep.nvim",                lazy = true, enabled = true, version = "*" }, -- use the latest stable version
    -- { "xieyonn/blink-cmp-dat-word",                   lazy = true },

    -- stylua: ignore end
  },
  -- version = "*",
  branch = "v1",
  build = "cargo build --profile release",
  opts = require("blink_modules").setup(),
  -- {
  --   fuzzy = {
  --     implementation = "prefer_rust",
  --     sorts = {
  --       "exact",
  --       "sort_text",
  --       "score",
  --       "label",
  --       "kind",
  --     },
  --   },
  --
  --   -- {{{ completion
  --   completion = require("blink_modules.completion"), -- menu_type
  --   -- completion }}}
  --
  --   -- {{{ signature
  --   signature = require("blink_modules.signature"),
  --   -- signature }}}
  --
  --   --- {{{ cmdline
  --   cmdline = require("blink_modules.cmdline"),
  --   --- cmdline }}}
  --
  --   --- {{{ keymaps
  --   keymap = require("blink_modules.blink_keymap"),
  --   --- keymaps }}}
  --
  --   snippets = {
  --     preset = "luasnip",
  --     score_offset = 99,
  --   },
  --
  --   ----------------------
  --
  --   --- {{{ sources
  --   sources = require("blink_modules.sources"),
  --   --- sources }}}
  -- },
}
