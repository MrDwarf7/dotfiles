return {
  "Saghen/blink.cmp",
  lazy = true,
  -- event = { "InsertEnter", "CmdlineEnter", "WinEnter" },
  event = "VeryLazy",
  dependencies = {
    -- stylua: ignore start
    { "j-hui/fidget.nvim",            lazy = true, event = "VeryLazy" },
    { "Saghen/blink.compat",          lazy = true },
    { "L3MON4D3/LuaSnip",             lazy = true },
    { "rafamadriz/friendly-snippets", lazy = true },
    { "folke/lazydev.nvim",           lazy = true, opts = {} },
    { "fang2hou/blink-copilot",       lazy = true },
    { "zbirenbaum/copilot.lua",       lazy = true },
    -- { "mikavilpas/blink-ripgrep.nvim", version = "*" }, -- use the latest stable version
    -- stylua: ignore end
  },
  version = "*",
  build = "cargo build --profile release",
  -- build = 'cargo build --release',
  opts = {
    fuzzy = {
      implementation = "prefer_rust",
    },

    -- {{{ completion
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
      ghost_text = {
        enabled = true,
        show_with_menu = true,
      },
    },
    -- completion }}}

    -- {{{ signature
    signature = {
      -- signature.enabled = true will show a little 'mini' function signature above/next to completion as you enter (__) <- this space
      -- but this is a LOT when the docs flyout is there AS WELL
      enabled = false, -- defaults to off (same as docs)
      trigger = {
        enabled = true,
      },
      -- DOC BORDER
      window = {
        -- min_width = 1,
        -- max_width = 100,
        -- max_height = 10,
        border = "single",
        show_documentation = false, -- ############## This is the little one
      },
    },
    -- signature }}}

    --- {{{ cmdline
    cmdline = {
      enabled = true,

      sources = {
        "cmdline",
        "buffer",
        "path",
        -- "copilot",
        -- "lsp",
      },

      completion = {
        list = {
          selection = {
            -- preselect = false,
            preselect = function(ctx)
              return require("blink.cmp").snippet_active({ direction = 1 })
            end,

            auto_insert = true,
          },
        },
        menu = {
          auto_show = true,
        },
        ghost_text = {
          enabled = true,
        },
      },

      keymap = {
        -- preset = "default",
        -- preset = "none",
        preset = "cmdline",

        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-y>"] = { "select_and_accept", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        -- TODO: Need to make this a function
        -- and it checks if we've got something selected -
        -- if we don't, 'first select' the first item,
        -- everything after that is fine to scroll through
        -- ["<Tab>"] = { "snippet_forward", "fallback" },

        -- one of:
        -- fallback,
        -- fallback_to_mappings,
        -- show,
        -- show_and_insert,
        -- show_and_insert_or_accept_single,
        -- hide,
        -- cancel,
        -- accept,
        -- accept_and_enter,
        -- select_and_accept,
        -- select_accept_and_enter,
        -- select_prev,
        -- select_next,
        -- insert_prev,
        -- insert_next,
        -- show_documentation,
        -- hide_documentation,
        -- scroll_documentation_up,
        -- scroll_documentation_down,
        -- show_signature,
        -- hide_signature,
        -- scroll_signature_up,
        -- scroll_signature_down,
        -- snippet_forward,
        -- snippet_backward or
        -- false to disable

        -- ["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },

        ["<Tab>"] = {
          "show_and_insert",
          -- function(cmp)
          --   vim.print(vim.inspect(cmp))
          -- end,
          "select_next",
        },

        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        -- preset = "inherit",
        -- keymap = {
        --   ["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },
        --   ["<S-Tab>"] = { "show_and_insert_or_accept_single", "select_prev" },
        -- },
      },
    },
    --- cmdline }}}

    --- {{{ keymaps
    keymap = {
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },

      -- defaults
      --
      -- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

      -- Version to: show with a list of providers
      -- functions are run in order, if one returns false | nil, the next is tried and so on.
      --
      -- ["<C-Space>"] = {
      --   function(cmp)
      --     cmp.show({
      --       providers = {
      --         "snippets",
      --       },
      --     })
      --   end,
      -- },

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
    --- keymaps }}}

    snippets = {
      preset = "luasnip",
    },

    ----------------------

    ---	{{{ sources
    sources = {
      -- add lazydev to your completion providers
      default = {
        --
        "copilot",
        "lazydev", -- conditional anyway
        "lsp",
        "buffer",
        -- "ripgrep",
        "snippets",
        "path",
        --
      },

      per_filetype = {
        lua = { inherit_defaults = true, "lazydev" },
        -- sql stuff
        -- sql = { "dadbod" },
      },

      --- {{{ providers
      providers = {
        --
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },

        -- sql stuff
        -- dadbod = { module = "vim_dadbod_completion.blink" },

        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 99,
        },

        lsp = {
          fallbacks = {}, -- defaults out to the "buffer" source
        },
        -- buffer = {},

        -- ripgrep = {
        --   name = "Ripgrep",
        --   module = "blink-ripgrep",
        --   score_offset = 100,
        --   opts = {},
        -- },

        -- snippets = {},
        path = {
          opts = {
            get_cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
        },
        --
      },
      --- providers }}}
    },
    ---	sources }}}
  },
}
