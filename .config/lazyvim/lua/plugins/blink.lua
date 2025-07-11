-- Stand-in for cmp / cmp.lua / cmp-nvim-lsp
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
    { "folke/lazydev.nvim", opts = {} },
    -- "saadparwaiz1/cmp_luasnip",
    -- { "saecki/crates.nvim", ft = { "toml", "rust" }, tag = "stable", opts = {} },
    -- "vrslev/cmp-pypi",
    -- "onsails/lspkind.nvim",
  },

  opts = {
    completion = {
      -- DOC BORDER
      menu = {
        min_width = 10,
        -- max_width = 100, -- 80 is default in blink docs
        max_height = 40, -- default is 20, (or does it use LazyVim's options.pumheight setting? -- changing it here overrides it anyway)
        border = "single",
      },
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
    signature = {
      -- signature.enabled = true will show a little 'mini' function signature above/next to completion as you enter (__) <- this space
      -- but this is a LOT when the docs flyout is there AS WELL
      enabled = false, -- defaults to off (same as docs)
      trigger = {
        enabled = true,
      },
      window = {
        -- min_width = 1,
        -- max_width = 100,
        -- max_height = 10,
        border = "single",
        show_documentation = false, -- ############## This is the little one
      },
    },

    -- cmdline = {
    --   enabled = true,
    -- },

    keymap = {
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      -- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-Space>"] = {
        function(cmp)
          cmp.show({
            providers = {
              "snippets",
            },
          })
        end,
      },
      ["<C-e>"] = { "hide", "fallback" },
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-n>"] = { "select_next", "fallback_to_mappings" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      -- ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },
    snippets = {
      preset = "luasnip",
    },

    sources = {
      default = { "lazydev", "lsp", "buffer", "snippets", "path" },
      per_filetype = {
        sql = { "dadbod" },
        lua = { inherit_defaults = true, "lazydev" },
      },

      providers = {
        dadbod = { module = "vim_dadbod_completion.blink" },
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
