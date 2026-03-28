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
      score_offset = 80,
      async = false,
    },

    -- sql stuff
    -- dadbod = { module = "vim_dadbod_completion.blink" },

    lazydev = {
      name = "LazyDev",
      module = "lazydev.integrations.blink",
      -- make lazydev completions top priority (see `:h blink.cmp`)
      score_offset = 100,
    },

    -- ghostty = {
    --   name = "Ghostty",
    --   module = "blink-cmp-ghostty",
    -- },

    conventional_commits = {
      name = "Conventional Commits",
      module = "blink-cmp-conventional-commits",
      enabled = function()
        return vim.bo.filetype == "gitcommit" or "jjdescription"
      end,
      ---@module 'blink-cmp-conventional-commits'
      ---@type blink-cmp-conventional-commits.Options
      opts = {
        -- See Configuration section below for available options
      },
    },

    sshconfig = {
      name = "SshConfig",
      module = "blink-cmp-sshconfig",
    },

    tmux = {
      name = "Tmux",
      module = "blink-cmp-tmux",
    },

    wezterm = {
      module = "blink-cmp-wezterm",
      name = "wezterm",
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
      score_offset = 40,
      async = true,
      min_keyword_length = 0,
      -- fallbacks = {}, -- defaults out to the "buffer" source
    },
    buffer = {
      score_offset = -20,
      min_keyword_length = 3,
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

    -- ripgrep = {
    --   name = "Ripgrep",
    --   module = "blink-ripgrep",
    --   score_offset = 100,
    --   opts = {},
    -- },

    snippets = {
      score_offset = -5,
      -- opts = {
      --   friendly_snippets = true, -- default
      --   -- extended_filetypes = {
      --   -- }
      -- },
      fallbacks = {},
    },

    path = {
      score_offset = -10,
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
  -- add lazydev to your completion providers
  default = {
    --
    "copilot",
    "lazydev", -- conditional anyway
    -- "ghostty",
    "conventional_commits", -- add it to the list
    "sshconfig",
    "tmux",
    "wezterm",

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

  providers = providers(),
}
