---@class BlinkModules.Keymap : blink.cmp.KeymapConfig

---@return BlinkModules.Keymap
---@type blink.cmp.KeymapConfig
return {
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

  ["<C-e>"] = { "scroll_documentation_down", "fallback" },
  ["<C-y>"] = { "scroll_documentation_up", "fallback" },

  ["<C-d>"] = { "scroll_documentation_down", "fallback" },
  ["<C-u>"] = { "scroll_documentation_up", "fallback" },
  -- ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
}
