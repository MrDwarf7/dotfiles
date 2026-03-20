---@class BlinkModules.Cmdline :  blink.cmp.CmdlineConfigPartial

---@return blink.cmp.KeymapConfig
local function keymap()
  ---@type blink.cmp.KeymapConfig
  return {
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
  }
end

---@return BlinkModules.Cmdline

return { ---@type blink.cmp.CmdlineConfigPartial
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
      auto_show = false,
    },
    -- trigger = {},
    ghost_text = {
      enabled = true,
    },
  },

  keymap = keymap(),
}
