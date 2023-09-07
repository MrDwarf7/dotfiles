local colors = require("config.colors").colors
return {
    "akinsho/bufferline.nvim",
   event = "VeryLazy",
    version = "*",
    dependencies = 
        "nvim-tree/nvim-web-devicons",
   opts = {
         options = {
         separator_style = { " | " },

         always_show_bufferline = true,
            offsets = {
                  {
                     filetype = "neo-tree",
                     text = "Neo-tree",
                     highlight = "Directory",
                     text_align = "left",
                     -- separator = true
                  },
               },
            },

      highlights = {
         fill = {
            bg = "",
         },
         background = {
           bg = "",
         },
         tab = {
           bg = "",
         },
         tab_close = {
           bg = "",
         },
         tab_separator = {
           fg = colors.bg,
           bg = "",
         },
         tab_separator_selected = {
           fg = colors.bg,
           bg = "",
           sp = colors.fg,
         },
         close_button = {
           bg = "",
           fg = colors.fg,
         },
         close_button_visible = {
           bg = "",
           fg = colors.fg,
         },
         close_button_selected = {
           fg = { attribute = "fg", highlight = "StatusLineNonText" },
         },
         buffer_visible = {
           bg = "",
         },
         modified = {
           bg = "",
         },
         modified_visible = {
           bg = "",
         },
         duplicate = {
           fg = colors.fg,
           bg = ""
         },
         duplicate_visible = {
           fg = colors.fg,
           bg = ""
         },
         separator = {
           fg = colors.bg,
           bg = ""
         },
         separator_selected = {
           fg = colors.bg,
           bg = ""
         },
         separator_visible = {
           fg = colors.bg,
           bg = ""
         },
         offset_separator = {
           fg = colors.bg,
           bg = ""
         },
      },
   }
        --Other components for buffer management/deletion are in bufdelete.lua

      local map = vim.keymap.set,
        -- NEXT
      map("n", "<leader>bn", ":bnext<CR>", { desc = "Buffer Next" })
      map("n", "<tab>", ":bnext<CR>", { desc = "Buffer Next" })

        -- PREV / PREVIOUS
      map("n", "<leader>bp", ":bPrevious<CR>", { desc = "Buffer Previous" })
      map("n", "<leader>bp", ":bprev<CR>", { desc = "Buffer Previous" })
      map("n", "<S-tab>", ":bprev<CR>", { desc = "Buffer Previous" })

      -- MOVING
      map("n", "<leader>bmn", ":BufferLineMoveNext<CR>", { desc = "Buffer Move Next" })
      map("n", "<leader>bmp", ":BufferLineMovePrev<CR>", { desc = "Buffer Move Previous" })

      -- DELETE and WIPE
      -- map("n", "<leader>bd", ":bdelete<CR><tab>", {desc = "Buffer Delete" })
      -- map("n", "<leader>bw", ":bwipeout<CR>", {desc = "Buffer Wipeout" })

      -- Tab controls
      map("n", "<leader><tab>]", ":tabNext<CR>", { desc = "Tab Next" })
      map("n", "<leader><tab>[", ":tabprevious<CR>", { desc = "Tab Previous" })
      map("n", "<leader><tab>a", ":tabnew<CR>", { desc = "Tab New" })
      map("n", "<leader><tab>c", ":tabclose<CR>", { desc = "Tab Close" })
}
