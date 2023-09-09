local colors = require("config.colors").colors
return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies =
    "nvim-tree/nvim-web-devicons",
    opts = {
        options = {
            separator_style = { "| " },
            always_show_bufferline = true,
            max_name_length = 25,
            show_close_icon = false,

            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Neo-tree",
                    highlight = "Directory",
                    text_align = "left",
                    separator = true,
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
    },
}
