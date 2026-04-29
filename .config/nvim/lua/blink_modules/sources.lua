---@class BlinkModules.Sources : blink.cmp.SourceConfigPartial

---@private
---@return table<string, blink.cmp.SourceProviderConfigPartial>?
local function providers()
  --- {{{ providers
  ---@return table<string, blink.cmp.SourceProviderConfigPartial>?
  ---@type table<string, blink.cmp.SourceProviderConfigPartial>?
  return {
    --
    copilot = {
      name = "copilot",
      module = "blink-copilot",
      score_offset = 800,
      async = true,
      opts = {
        max_completions = 4, -- 'override' default (default is 4)
        max_attempts = 4,
      },
    },

    -- sql stuff
    -- dadbod = { module = "vim_dadbod_completion.blink" },

    lazydev = {
      name = "LazyDev",
      module = "lazydev.integrations.blink",
      -- make lazydev completions top priority (see `:h blink.cmp`)
      score_offset = 1000,
    },

    -- ghostty = {
    --   name = "Ghostty",
    --   module = "blink-cmp-ghostty",
    -- },

    -- -- conventional_commits = {
    -- --   name = "Conventional Commits",
    -- --   module = "blink-cmp-conventional-commits",
    -- --   enabled = function()
    -- --     return vim.bo.filetype == "gitcommit" or "jjdescription"
    -- --   end,
    -- --   ---@module 'blink-cmp-conventional-commits'
    -- --   ---@type blink-cmp-conventional-commits.Options
    -- --   opts = {
    -- --     -- See Configuration section below for available options
    -- --   },
    -- -- },

    sshconfig = {
      name = "SshConfig",
      module = "blink-cmp-sshconfig",
    },

    tmux = {
      name = "Tmux",
      module = "blink-cmp-tmux",
    },

    wezterm = {
      name = "wezterm",
      module = "blink-cmp-wezterm",
      -- default options
      opts = {
        all_panes = false,
        capture_history = false,
        -- only suggest completions from `wezterm` if the `trigger_chars` are
        -- used
        triggered_only = false,
        trigger_chars = { "." },
      },
    },

    lsp = {
      name = "LSP",
      module = "blink.cmp.sources.lsp",
      score_offset = 900,
      async = true,
      min_keyword_length = 0,
      -- fallbacks = {}, -- defaults out to the "buffer" source
    },
    buffer = {
      score_offset = 55,
      min_keyword_length = 2,
      async = true,
      opts = {
        -- Ability to provide completions
        -- from ALL buffers (well, valid ones)

        -- get_bufnrs = vim.api.nvim_list_bufs,
        get_bufnrs = function()
          return vim.tbl_filter(function(bufnr)
            return vim.bo[bufnr].buftype == ""
          end, vim.api.nvim_list_bufs())
        end,
      },
    },

    dictionary = {
      name = "blink-cmp-words",
      module = "blink-cmp-words.dictionary",
      async = true,
      -- All available options
      opts = {
        -- The number of characters required to trigger completion.
        -- Set this higher if completion is slow, 3 is default.
        dictionary_search_threshold = 3,

        -- See above
        -- score_offset = 20,

        -- See above
        definition_pointers = { "!", "&", "^" },
      },
    },

    -- Use the thesaurus source
    thesaurus = {
      name = "blink-cmp-thesaurus",
      module = "blink-cmp-words.thesaurus",
      async = true,
      -- All available options
      opts = {
        -- A score offset applied to returned items.
        -- By default the highest score is 0 (item 1 has a score of -1, item 2 of -2 etc..).
        -- score_offset = 10,

        -- Default pointers define the lexical relations listed under each definition,
        -- see Pointer Symbols below.
        -- Default is as below ("antonyms", "similar to" and "also see").
        definition_pointers = { "!", "&", "^" },

        -- The pointers that are considered similar words when using the thesaurus,
        -- see Pointer Symbols below.
        -- Default is as below ("similar to", "also see" )
        similarity_pointers = { "&", "^" },

        -- The depth of similar words to recurse when collecting synonyms. 1 is similar words,
        -- 2 is similar words of similar words, etc. Increasing this may slow results.
        similarity_depth = 2,
      },
    },
    -- avante = {
    --   name = "Avante",
    --   module = "blink-cmp-avante",
    --   opts = {
    --     -- options for blink-cmp-avante
    --   },
    -- },

    -- -- ripgrep = {
    -- --   name = "Ripgrep",
    -- --   module = "blink-ripgrep",
    -- --   score_offset = 30,
    -- --   opts = {
    -- --     prefix_min_len = 2,
    -- --     -- debug = false,
    -- --   },
    -- -- },

    env = {
      name = "Env",
      module = "blink-cmp-env",
      async = true,

      --- @type blink-cmp-env.Options
      opts = {
        -- item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
        show_braces = false,
        show_documentation_window = true,
      },
    },

    snippets = {
      enabled = false,
      score_offset = -200,
      opts = {
        -- friendly_snippets = true, -- default
        snippets = {
          preset = "luasnip",
        },
      },
      fallbacks = {},
    },

    path = {
      -- score_offset = -15,
      opts = {
        -- provide directory completions from the cwd instead
        -- of the current buffer's path.
        get_cwd = function(_)
          return vim.fn.getcwd()
        end,
      },
    },
    --
  }
  --- providers }}}
end

---@return blink.cmp.SourceConfigPartial
return {
  -- Items with a double "-- --" I've disabled to test perf. related things,
  -- not so much because I dont' want to use them

  default = {
    --
    "lsp",
    "buffer",

    "copilot",
    "lazydev", -- conditional anyway
    -- "ghostty",
    -- -- "conventional_commits", -- add it to the list
    "sshconfig",
    "tmux",
    "wezterm",
    -- "avante",
    -- "datword",

    -- "ripgrep",
    "snippets",
    "path",
    "env",

    --
  },

  per_filetype = {
    lua = {
      "lsp",
      "lazydev", -- conditional anyway
      "path",
      "copilot",

      "wezterm",
      "buffer",
      "snippets",
    },
    rust = {
      "lsp",
      "buffer",
      "path",
      "copilot",
      "env",
      -- "snippets",
    },

    text = {
      "copilot",
      "dictionary",
      "thesaurus",
    },
    markdown = {
      "copilot",
      "dictionary",
      "thesaurus",
    },

    -- sql stuff
    -- sql = { "dadbod" },
  },

  --- Disable ALL of snippets via filtering _OUT_ items that are a part of valid blink snippet types
  -- transform_items = function(_, items)
  --   return vim.tbl_filter(function(item)
  --     return item.kind ~= require("blink.cmp.types").CompletionItemKind.Snippet
  --   end, items)
  -- end,

  providers = providers(),
}
