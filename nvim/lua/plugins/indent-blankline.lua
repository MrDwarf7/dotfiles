return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    enabled = true,
    config = function()
        local indent_blankline = require("indent_blankline").setup {
            show_current_context_start = true,
            show_current_context = true,
            -- space_char_blankline = nil,
            show_trailing_blankline_indent = true,
            -- char = "|",
            filetype_exclude = {
                "help",
                "alpha",
                "dashboard",
                -- "neo-tree",
                "Trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm"
            },
            use_treesitter = true,
        }
    end,

}
