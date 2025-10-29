return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "BufReadPost",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = false,
				-- vim.g.ai_cmp,
      keymap = {
        accept = false, -- handled by nvim-cmp / blink.cmp
        -- next = "<M-]>",
        next = "<C-l>",
        prev = "<C-h>",
      },
    },
    panel = {
      enabled = false,
      auto_refresh = false,
    },
    filetypes = {
      markdown = true,
      help = true,

      cvs = false,
      gitcommit = true,
      gitrebase = true,
      -- help = false,
      hgcommit = false,
      -- markdown = true,
      svn = false,
      yaml = true,
      ["."] = true,
    },

    -- copilot_node_command = "node", -- What other ways can it be run??
    -- server_opts_overrides = {
    --   trace = "verbose",
    -- },
  },
}
