return {
    {
        'MunifTanjim/nui.nvim',
        lazy = false,
    },

    {
        'rcarriga/nvim-notify',
        lazy = false,
        config = function()
            vim.notify = require("notify")
        end
    },

    {
        'stevearc/dressing.nvim',
        lazy = false,
        opts = {},
    },

    {
        "j-hui/fidget.nvim",
        event = "BufEnter",
        lazy = false,
        tags = "v1.2.0",
        opts = {
            -- options
        },
    },

    {
        "folke/noice.nvim",
        --event = "VeryLazy",
        lazy = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },

        opts = {

            lsp = {

                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },

            presets = {
                --bottom_search = false, -- use a classic bottom cmdline for search
                --command_palette = false, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = true,            -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,        -- add a border to hover docs and signature help
            },

            routes = {

                {
                    view = "notify",
                    filter = { event = "msg_showmode" },
                },
            },

            views = {
                cmdline_popup = {
                    position = {
                        row = 30,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = "auto",
                    },
                },
                popupmenu = {
                    relative = "editor",
                    position = {
                        row = 33,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = 10,
                    },
                    border = {
                        style = "rounded",
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                    },
                },
            },
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "UIEnter",
        enabled = true,
        opts = {
            exclude = {
                -- stylua: ignore
                filetypes = {
                    'dbout', 'neo-tree-popup', 'log', 'gitcommit',
                    'txt', 'help', 'NvimTree', 'git', 'flutterToolsOutline',
                    'undotree', 'markdown', 'norg', 'org', 'orgagenda', "Diffview", "Neogit",
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
            },
        },
        config = function(_, opts)
            require("ibl").setup(opts)
            local hooks = require("ibl.hooks")
            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
        end,
    },
}