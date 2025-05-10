return {
  "blink.cmp",

  dependencies = {
    { "saghen/blink.compat" },
    { "L3MON4D3/LuaSnip" },

    -- { "zbirenbaum/copilot-cmp" }, -- event = "InsertEnter",
    -- { "hrsh7th/cmp-nvim-lsp", opts = {} },
    --
    -- "hrsh7th/cmp-buffer",
    -- "hrsh7th/cmp-path",
    -- "hrsh7th/cmp-cmdline",
    -- "hrsh7th/cmp-nvim-lua",
    --
    -- { "folke/lazydev.nvim", opts = {} },
    -- "saadparwaiz1/cmp_luasnip",
    -- { "saecki/crates.nvim", ft = { "toml", "rust" }, tag = "stable", opts = {} },
    -- "vrslev/cmp-pypi",
    -- "onsails/lspkind.nvim",
  },

  opts = {
    completion = {
      -- DOC BORDER
      menu = { border = "single" },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100,
        -- DOC BORDER
        window = {
          border = "single",
        },
      },
    },
    -- DOC BORDER
    signature = { window = { border = "single" } },

    -- cmdline = {
    --   enabled = true,
    -- },

    keymap = {
      preset = "super-tab",
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-Space>"] = {
        function(cmp)
          cmp.show({
            providers = {
              "snippets",
            },
          })
        end,
      },

      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },

    snippets = {
      preset = "luasnip",
    },

    sources = {
      default = { "lazydev" },
      per_filetype = {
        -- sql = { "dadbod" },
        lua = { inherit_defaults = true, "lazydev" },
      },

      providers = {
        lazydev = {
          name = "LazyDev",
          -- module = require("lazydev.intergrations.blink"),
          score_offset = 100,
        },
      },
    },
    -- providers = {
    --   dadbod = { module = "vim_dadbod_completion.blink" },
    -- },
  },
}
