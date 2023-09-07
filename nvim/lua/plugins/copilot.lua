return {
   {
      "zbirenbaum/copilot.lua",
      enabled = true,
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
                  open = "<A-CR>"
               },
               layout = {
                  position = "bottom",
                  ratio = 0.4
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
                  dismiss = "<C-e>",
               },
            },
         })
      end
   },
    {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
    }
}

   --          help = false,
   --          gitcommit = false,
   --          gitrebase = false,
   --          hgcommit = false,
   --          svn = false,
   --          cvs = false,
   --          ["."] = false,
   --       },
   --       copilot_node_command = "node",
   --       server_opts_overrides = {},
   --    })
   -- end,
-- }
