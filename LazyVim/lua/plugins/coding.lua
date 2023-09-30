return {

    -- ---------------------------------------------
    -- disabling ....
    -- ---------------------------------------------

    -- ---------------------------------------------
    -- overriding ....
    -- ---------------------------------------------

    {
        "echasnovski/mini.surround",
        keys = {
            -- stylua: ignore
            { "<leader>m",  desc = "[m]ini Surround" },
            { "<leader>ma", "<Plug>(minisurround-add)",            desc = "[A]dd" },
            { "<leader>md", "<Plug>(minisurround-delete)",         desc = "[D]elete" },
            { "<leader>mf", "<Plug>(minisurround-find)",           desc = "[f]ind (to the right)" },
            { "<leader>mF", "<Plug>(minisurround-find-left)",      desc = "[F]ind (to the left)" },
            { "<leader>mh", "<Plug>(minisurround-highlight)",      desc = "[H]ighlight surrounding" },
            { "<leader>mr", "<Plug>(minisurround-replace)",        desc = "[R]eplace surrounding" },
            { "<leader>mn", "<Plug>(minisurround-update-n-lines)", desc = "[n]_lines Update" },
        },
        opts = {
            mappings = {
                add = "ma",    -- Add surrounding in Normal and Visual modes
                delete = "md", -- Delete surrounding
                find = "mf",   -- Find surrounding (to the right)
                find_left = "mF", -- Find surrounding (to the left)
                highlight = "mh", -- Highlight surrounding
                replace = "mr", -- Replace surrounding
                update_n_lines = "mn", -- Update `n_lines`
            },
        },
    },

    -- ---------------------------------------------
    -- adding ....
    -- ---------------------------------------------
    {
        "gbprod/yanky.nvim",
        dependencies = { { "kkharji/sqlite.lua", enabled = not jit.os:find("Windows") } },
        keys = {
            -- stylua: ignore
            { "<leader>\'", function() require("telescope").extensions.yank_history.yank_history({}) end,
                                                                                                               desc =
                "[f]ind [y]ank" },
            { "y",          "<Plug>(YankyYank)",                                                           mode = { "n",
                "x" },                                                                                                                                    desc =
            "Yank text" },
            { "p",          "<Plug>(YankyPutAfter)",                                                       mode = { "n",
                "x" },                                                                                                                                    desc =
            "Put yanked text after cursor" },
            { "P",          "<Plug>(YankyPutBefore)",                                                      mode = { "n",
                "x" },                                                                                                                                    desc =
            "Put yanked text before cursor" },
            { "gp",         "<Plug>(YankyGPutAfter)",                                                      mode = { "n",
                "x" },                                                                                                                                    desc =
            "Put yanked text after selection" },
            { "gP",         "<Plug>(YankyGPutBefore)",                                                     mode = { "n",
                "x" },                                                                                                                                    desc =
            "Put yanked text before selection" },
            { "[y",         "<Plug>(YankyCycleForward)",                                                   desc =
            "Cycle forward through yank history" },
            { "]y",         "<Plug>(YankyCycleBackward)",                                                  desc =
            "Cycle backward through yank history" },
            { "]p",         "<Plug>(YankyPutIndentAfterLinewise)",                                         desc =
            "Put indented after cursor (linewise)" },
            { "[p",         "<Plug>(YankyPutIndentBeforeLinewise)",                                        desc =
            "Put indented before cursor (linewise)" },
            { "]P",         "<Plug>(YankyPutIndentAfterLinewise)",                                         desc =
            "Put indented after cursor (linewise)" },
            { "[P",         "<Plug>(YankyPutIndentBeforeLinewise)",                                        desc =
            "Put indented before cursor (linewise)" },
            { ">p",         "<Plug>(YankyPutIndentAfterShiftRight)",                                       desc =
            "Put and indent right" },
            { "<p",         "<Plug>(YankyPutIndentAfterShiftLeft)",                                        desc =
            "Put and indent left" },
            { ">P",         "<Plug>(YankyPutIndentBeforeShiftRight)",                                      desc =
            "Put before and indent right" },
            { "<P",         "<Plug>(YankyPutIndentBeforeShiftLeft)",                                       desc =
            "Put before and indent left" },
            { "=p",         "<Plug>(YankyPutAfterFilter)",                                                 desc =
            "Put after applying a filter" },
            { "=P",         "<Plug>(YankyPutBeforeFilter)",                                                desc =
            "Put before applying a filter" },
        },

        opts = function()
            local mapping = require("yanky.telescope.mapping")
            local mappings = mapping.get_defaults()
            mappings.i["<c-p>"] = nil

            return {
                highlight = { timer = 80 },
                ring = { storage = jit.os:find("Windows") and "shada" or "sqlite" },
                picker = {
                    telescope = {
                        use_default_mappings = false,
                        mappings = mappings,
                    },
                },
            }
        end,
    },
    --
}
