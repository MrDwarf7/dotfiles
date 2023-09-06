return {
   "zbirenbaum/copilot.lua",
   cmd = "Copilot",

   config = function()
      local copilot = require("copilot")
   copilot.setup({
         panel = {
            enabled = false, -- TOGGLE
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
            -------------
            enabled = false,
            auto_trigger = true, --DEFAULT FOR NOW
            debounce = 75, --No idea lol
            keymap = {
               accept = "<A-1>",
               accept_word = false,
               accept_line = false,
               next = "<A-]>",
               prev = "<A-[>",
               dismiss = "<C-]>",
            },
         },
         filetypes = {
            yaml = false,
            markdown = false,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
         },
         copilot_node_command = "node",
         server_opts_overrides = {},
      })
   end,
}
