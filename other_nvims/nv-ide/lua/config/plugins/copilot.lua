return {
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    lazy = false,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true, -- TOGGLE
          auto_refresh = true,
          keymap = {
            jump_next = "<A-]>",
            jump_prev = "<A-[>",
            accept = "<CR>",
            refresh = "gr", -- Consider <leader>cn ("Co-pilot New" ?)
            open = "<A-CR>",
          },
          layout = {
            position = "bottom",
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true, --DEFAULT FOR NOW
          debounce = 75, --No idea lol
          keymap = {
            accept = "<A-a>",
            accept_word = false,
            accept_line = false,
            next = "<A-]>",
            prev = "<A-[>",
            dismiss = "<C-Space>",
          },
        },
      })
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    depencencies = {
      "zbirenbaum/copilot.lua",
    },
    lazy = false,
    -- after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
