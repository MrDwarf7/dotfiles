---@type LazyPluginBase
return {
  "zbirenbaum/copilot.lua",
  lazy = true,
  cmd = "Copilot",
  build = ":Copilot auth",
  ---@type LazyEventSpec
  event = "LspAttach",
  opts = {
    suggestion = {
      -- this is the 'ghost_text' component
      -- we have no way to directly accept the inline ghost_text as we've turned it off here
      enabled = false,
      -- enabled = true,

      auto_trigger = true,
      hide_during_completion = false,
      -- vim.g.ai_cmp,
      keymap = {
        accept = false, -- handled by nvim-cmp / blink.cmp
        -- accept = "<A-Enter>",

        -- next = "<M-]>",
        next = "<A-Right>",
        prev = "<A-Left>",
      },
    },
    panel = {
      enabled = false,
      auto_refresh = false,
    },
    filetypes = {
      bash = true,
      cvs = false,
      fish = true,
      gitcommit = true,
      gitrebase = true,
      -- help = false,
      help = true,
      hgcommit = false,
      -- markdown = true,
      markdown = false,
      sh = true,
      svn = false,
      yaml = true,

      ["."] = true,
      ["*"] = true,
    },

    -- filetypes = {
    --   markdown = true,
    --   help = true,
    --   fish = true,
    --   bash = true,
    --   sh = true,
    --
    --   cvs = false,
    --   gitcommit = true,
    --   gitrebase = true,
    --   -- help = false,
    --   hgcommit = false,
    --   -- markdown = true,
    --   svn = false,
    --   yaml = true,
    --   ["."] = true,
    --   ["*"] = true,
    -- },

    -- copilot_node_command = "node", -- What other ways can it be run??
    -- server_opts_overrides = {
    --   trace = "verbose",
    -- },
  },
}
