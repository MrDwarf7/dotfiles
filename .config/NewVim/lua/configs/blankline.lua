local blankline = require("ibl")
local hooks = require("ibl.hooks")

blankline.setup({
    exclude = {
        filetypes = {
            "dbout",
            "neo-tree-popup",
            "log",
            "gitcommit",
            "txt",
            "help",
            "NvimTree",
            "git",
            "flutterToolsOutline",
            "undotree",
            "markdown",
            "norg",
            "org",
            "orgagenda",
            "Diffview",
            "Neogit",
        },
    },
    indent = {
        char = "│", -- ▏┆ ┊ 
        tab_char = "│",
    },
    scope = {
        char = "▎",
        highlight = {
            "RainbowDelimiterRed",
            "RainbowDelimiterYellow",
            "RainbowDelimiterBlue",
            "RainbowDelimiterOrange",
            "RainbowDelimiterGreen",
            "RainbowDelimiterViolet",
            "RainbowDelimiterCyan",
        },
        show_start = true,
    }
})

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
