---@type blink.cmp.Config
local opts = {}

-- local CMDLINE_MIN_KW_LEN = 2

opts.fuzzy = {
  implementation = "prefer_rust",
  --- previously*
  -- sorts = {
  --   "exact",
  --   "sort_text",
  --   "score",
  --   "label",
  --   "kind",
  -- },

  sorts = {
    "score",
    "sort_text",
    "label",
    "kind",
    "exact",
  },
}

local filetype_types_text = { "markdown", "text", "txt" }
local sources_types_text = {
  "copilot",
  "dictionary",
  "thesaurus",
}

---@param additional string[]|nil
local set_text_types_sources = function(additional)
  if additional then
    return vim.list_extend(vim.deepcopy(sources_types_text), additional)
  else
    return vim.deepcopy(sources_types_text)
  end
end

opts.sources = {
  -- Items with a double "-- --" I've disabled to test perf. related things,
  -- not so much because I dont' want to use them

  default = {
    "lsp",
    "buffer",
    "path",
    "copilot",
  },

  per_filetype = {
    lua = {
      inherit_defaults = true,
      "lazydev",
      -- "wezterm",
      "snippets",
    },
    rust = {
      inherit_defaults = true,
      -- "env",
      -- "snippets",
    },

    sshconfig = {
      inherit_defaults = true,
      "sshconfig",
    },
    sshconfig_hosts = {
      inherit_defaults = true,
      "sshconfig",
    },
    ghostty = {
      inherit_defaults = true,
      "ghostty",
    },
    tmux = {
      inherit_defaults = true,
      "tmux",
    },

    text = set_text_types_sources(),
    markdown = set_text_types_sources(),

    -- sql stuff
    -- sql = { "dadbod" },
  },

  --- Disable ALL of snippets via filtering _OUT_ items that are a part of valid blink snippet types
  -- transform_items = function(_, items)
  --   return vim.tbl_filter(function(item)
  --     return item.kind ~= require("blink.cmp.types").CompletionItemKind.Snippet
  --   end, items)
  -- end,

  providers = {
    --
    copilot = {
      name = "copilot",
      module = "blink-copilot",
      score_offset = 900,
      async = true,
      opts = {
        max_completions = 4, -- 'override' default (default is 4)
        max_attempts = 4,
      },
      -- TODO: [blink_fixes] : Copilot suggestion fixes

      --- copilot items don't correct 'fuzzy'ed completion entries.
      --- Eg: writing a lazily entered fn name without underscores etc.
      --- then hitting 'tab'/'enter' to take a copilot suggestion
      --- will not correct the fn name itself (to the already discovered LSP name that is correct).
      --- This mean you can end up with stuff like:
      --- foo.reallylngfnname() -- instead of foo.really_long_fn_name()
      -- transform_items = function(ctx, items) end,
    },

    -- sql stuff
    -- dadbod = { module = "vim_dadbod_completion.blink" },

    lazydev = {
      name = "LazyDev",
      module = "lazydev.integrations.blink",
      -- make lazydev completions top priority (see `:h blink.cmp`)
      score_offset = 1000,
    },

    ghostty = {
      name = "Ghostty",
      module = "blink-cmp-ghostty",
    },

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
      enabled = true,
      -- enabled = function()
      --   return vim.bo.filetype == "sshconfig" or vim.bo.filetype == "sshconfig_hosts"
      -- end,
      name = "SshConfig",
      module = "blink-cmp-sshconfig",
      --- @module 'blink-cmp-sshconfig'
      --- @type blink-cmp-sshconfig.Options
      opts = {
        prefer_pre_generated = true, -- default
      },
    },

    tmux = {
      name = "Tmux",
      module = "blink-cmp-tmux",
    },

    -- wezterm = {
    --   name = "wezterm",
    --   module = "blink-cmp-wezterm",
    --   -- enabled = function()
    --   --   local full_path = vim.api.nvim_buf_get_name(0)
    --   --   local contains_wezterm = string.find(full_path, "wezterm.lua") ~= nil
    --   --   return vim.bo.filetype == "lua" and contains_wezterm
    --   -- end,
    --   -- default options
    --   opts = {
    --     all_panes = false,
    --     capture_history = false,
    --     -- only suggest completions from `wezterm` if the `trigger_chars` are
    --     -- used
    --     triggered_only = false,
    --     trigger_chars = { "." },
    --
    --     max_completions = 4, -- 'override' default (default is 4)
    --     max_attempts = 4,
    --   },
    -- },

    lsp = {
      name = "LSP",
      module = "blink.cmp.sources.lsp",
      score_offset = 910,
      async = true,
      -- min_keyword_length = 0,
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
      -- keep case of first char
      transform_items = function(a, items)
        local kw = a.get_keyword()
        local correct
        local case
        if kw:match("%l") then
          correct = "^%u%l+$"
          case = string.lower
        elseif kw:match("^%u") then
          correct = "^%l+$"
          case = string.upper
        else
          return items
        end

        -- avoid duplicates from the correction itself
        local seen = {}
        local out = {}
        for _, item in ipairs(items) do
          local raw = item.insertText
          if raw:match(correct) then
            local text = case(raw:sub(1, 1)) .. raw:sub(2)
            item.insertText = text
            item.label = text
          end
          if not seen[item.insertText] then
            seen[item.insertText] = true
            table.insert(out, item)
          end
        end
        return out
      end,
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

    -- env = {
    --   name = "Env",
    --   module = "blink-cmp-env",
    --   async = true,
    --
    --   --- @type blink-cmp-env.Options
    --   opts = {
    --     -- item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
    --     show_braces = false,
    --     show_documentation_window = true,
    --   },
    -- },

    -- snippets = {
    --   enabled = false,
    --   score_offset = -200,
    --   opts = {
    --     friendly_snippets = true, -- default
    --     -- snippets = {
    --     --   preset = "luasnip",
    --     -- },
    --   },
    --   fallbacks = {},
    -- },

    snippets = {
      preset = "luasnip",
      opts = {
        friendly_snippets = true, -- default
      },
      should_show_items = function(ctx)
        return ctx.trigger.initial_kind ~= "trigger_character"
      end,
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

    omni = {
      module = "blink.cmp.sources.complete_func",
      enabled = function()
        return vim.bo.omnifunc ~= "v:lua.vim.lsp.omnifunc"
      end,
      ---@type blink.cmp.CompleteFuncOpts
      opts = {
        ---@type fun():string|nil|function
        complete_func = function()
          return vim.bo.omnifunc
        end,
      },
    },

    -- idk, is broken or smth
    -- cmdline = {
    --   min_keyword_length = function(ctx)
    --     if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
    --       return CMDLINE_MIN_KW_LEN
    --     end
    --   end,
    -- },
  },
}

opts.completion = {
  -- trigger = {},
  list = {
    selection = {
      preselect = false,
      auto_insert = true,
    },
  },

  menu = {
    auto_show = true,
    min_width = 10,
    -- max_width = 100, -- 80 is default in blink docs
    max_height = 80, -- default is 20, (or does it use LazyVim's options.pumheight setting? -- changing it here overrides it anyway)
    border = "single",
    -- draw = require("blink_modules.comp_menu_types").colorful,

    draw = require("blink_modules.comp_menu_types").colorful(), -- menu_type
  },

  documentation = {
    auto_show = true,
    auto_show_delay_ms = 50,
    -- DOC BORDER
    window = {
      border = "single",
    },
  },

  ghost_text = {
    enabled = true,
    show_with_menu = true,
  },
}

opts.signature = {
  -- signature.enabled = true will show a little 'mini' function signature above/next to completion as you enter (__) <- this space
  -- but this is a LOT when the docs flyout is there AS WELL
  enabled = false, -- defaults to off (same as docs)
  trigger = {
    enabled = true,
  },
  -- DOC BORDER
  -- window = window(),
  window = {
    -- min_width = 1,
    -- max_width = 100,
    -- max_height = 10,
    border = "single",
    show_documentation = false, -- ############## This is the little one
  },
}

opts.cmdline = {
  enabled = true,

  -- NOTE: idk apparently this just.... doesn't exist here despite docs?
  -- sources = { "cmdline", "buffer", "path" },

  -- "copilot",
  -- "lsp",

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
    -- trigger = {},
    ghost_text = {
      enabled = false,
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
}

opts.keymap = {
  -- ["<C-j>"] = { "select_next", "fallback" },
  -- ["<C-k>"] = { "select_prev", "fallback" },

  ["<C-j>"] = { "select_next" },
  ["<C-k>"] = { "select_prev" },

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

  ["<C-c>"] = { "hide", "fallback" },
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

  --- Scroll amount is 4 by default.

  ["<C-d>"] = { "scroll_documentation_down", "fallback" },
  ["<C-u>"] = { "scroll_documentation_up", "fallback" },
  -- ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },

    -- stylua: ignore start
  ["<C-e>"] = { function(cmp) return cmp.scroll_documentation_down(1) end, "fallback" },
  ["<C-y>"] = { function(cmp) return cmp.scroll_documentation_up(1)   end, "fallback" },
  -- stylua: ignore end
}

return {
  "saghen/blink.cmp",
  lazy = false,
  -- event = { "InsertEnter", "CmdlineEnter", "WinEnter" },

  -- ---@type LazyEventSpec
  -- event = { "CursorMoved", "VeryLazy" },
  dependencies = {
    -- stylua: ignore start
    { "saghen/blink.lib",                             lazy = false }, -- required unless pinning to 'v1'
    -- { "j-hui/fidget.nvim", enabled = false,            lazy = true, event = "VeryLazy" },
    { "Saghen/blink.compat",                          lazy = false },
    { "fang2hou/blink-copilot",                       lazy = true },
    -- { "zbirenbaum/copilot.lua",                       lazy = true },
    { "rafamadriz/friendly-snippets",                 lazy = false },
    { "L3MON4D3/LuaSnip",                             lazy = false },

    { "xzbdmw/colorful-menu.nvim",                    lazy = false },

    { "archie-judd/blink-cmp-words",                  lazy = true, enabled = true, ft = filetype_types_text },

    ----- Specific languages/sources
    { "folke/lazydev.nvim",                           lazy = true,                 ft = "lua" },
    { "bydlw98/blink-cmp-sshconfig",                  lazy = true, enabled = true, ft = { "sshconfig", "sshconfig_hosts" },  build = "make" },
    { "barrettruth/blink-cmp-ghostty",                lazy = true, enabled = true, ft = "ghostty" },
    { "barrettruth/blink-cmp-tmux",                   lazy = true, enabled = true, ft = "tmux" },

    -- { "junkblocker/blink-cmp-wezterm",                lazy = true, enabled = true, ft = "lua" },

    -- -- { "disrupted/blink-cmp-conventional-commits",     lazy = false },
    -- { "bydlw98/blink-cmp-env",                        lazy = true, enabled = true, ft = "env" },
    -- { "Kaiser-Yang/blink-cmp-avante",                 lazy = true },
    -- { "mikavilpas/blink-ripgrep.nvim",                lazy = true, enabled = true, version = "*" }, -- use the latest stable version
    -- { "xieyonn/blink-cmp-dat-word",                   lazy = true },
    -- stylua: ignore end
  },

  build = function()
    require("blink.cmp").build():pwait()
  end,

  opts = opts,

  -------------------------------------------------------------------------
  -------------------------------------------------------------------------
  --
  -- opts = {}

  --
  -------------------------------------------------------------------------
  -------------------------------------------------------------------------
}
