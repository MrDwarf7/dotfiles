return {
    "lukas-reineke/indent-blankline.nvim",

   config = function()
      local indent_blankline = require("indent_blankline").setup{
         show_current_context_start = true,
         space_char_blankline = " ",
         -- char = "|",
         filetype_exclude = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm"
         },
         show_trailing_blankline_indent = true,
         show_current_context = true,
         use_treesitter = true,
      }
   end,

}
