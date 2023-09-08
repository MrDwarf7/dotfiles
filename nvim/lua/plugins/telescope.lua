return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = false,
        lazy = true,
        -- branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            'jvgrootveld/telescope-zoxide',
            "nvim-tree/nvim-web-devicons",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            'nvim-telescope/telescope-ui-select.nvim',
            'telescope-dap.nvim',
            'kkharji/sqlite.lua',
            'nvim-telescope/telescope-frecency.nvim',

        },

        config = function()
            local telescope = require("telescope")
            -- local builtin = require('telescope.builtin')
            local actions = require("telescope.actions")

            telescope.setup {
                file_ignore_patterns = { "%.git/." },
                -- Applying customizations globally (via the "defaults"), or individually per picker.

                defaults = {
                    file_ignore_patterns = { "node_modules", "package-lock.json" },
                    mappings = {

                        i = {
                            ["<C-k>"] = actions.move_selection_previous, -- Move to prev result in listing
                            ["<C-j>"] = actions.move_selection_next,     -- Move to next res
                            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<C-u>"] = false,
                        },
                        n = {
                            ["q"] = actions.close,
                            ["<esc>"] = actions.close,

                        },
                    },
                },

                pickers = {
                    find_files = {
                        --theme = "dropdown",
                        previewer = true,
                        layout_config = {
                            --width = 0.5,
                            height = 0.8,
                            -- prompt_position = "top" OR "bottom",
                            preview_cutoff = 120,
                        },
                    },
                    git_files = {
                        -- theme = "dropdown",
                        previewer = true,
                        layout_config = {
                            preview_cutoff = 120,
                        },
                    },
                    buffers = {
                        -- theme = "dropdown",
                        previewer = true,
                        layout_config = {
                            preview_cutoff = 120,
                        },
                    },
                    current_buffer_fuzzy_find = {
                        -- theme = "dropdown",
                        previewer = true,
                        layout_config = {
                            preview_cutoff = 120,
                        },
                    },
                    live_grep = {
                        -- theme = "dropdown",
                        only_sort_text = true,
                        previewer = true,
                        layout_config = {
                            preview_cutoff = 120,
                        },
                    },
                    grep_string = {
                        -- theme = "dropdown",
                        only_sort_text = true,
                        previewer = true,
                    },
                    lsp_references = {
                        -- theme = "dropdown",
                        -- show_line = false,
                        previewer = true,
                    },
                    treesitter = {
                        -- theme = "dropdown",
                        -- show_line = false,
                        previewer = true,
                    }
                },

                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({
                            previewer = true,
                            initial_mode = "normal",
                        })
                    },
                    frecency = {
                        default_workspace = 'CWD',
                        show_scores = true,    -- No idea what this does lol
                        show_unindexed = true, -- No idea what this does lol
                        disable_devicons = false,
                        ignore_patterns = {
                            "*.git/*",
                            "*/tmp/*",
                            "*/lua-language-server/*",
                        },
                    },
                }
            }

            telescope.load_extension("fzf");
            telescope.load_extension('ui-select')
            telescope.load_extension('refactoring')
            telescope.load_extension('dap')
            telescope.load_extension("zoxide")
            telescope.load_extension("frecency")
            -- telescope.load_extension("file_browser")

            -- local map = vim.keymap.set
            -- map("n", "<fc>", "<cmd>Telescope grep_string<cr>", { desc = "Find Current Word" })
        end,
    }
}
