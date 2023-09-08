return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    branch = "v3.x",
    keys = {
        { "<leader>n", ":Neotree toggle left<CR>",  silent = true, desc = "Explorer TreeView" },
        -- { "<leader>et", ":Neotree toggle left<CR>", silent = true, desc = "Explorer Left File " }, -- Could change this to leader n at some point if I prefer
        { "<leader>e", ":Neotree toggle float<CR>", silent = true, desc = " Explorer Float" },
    },
    -- map("n", "<leader>nt", ":Neotree toggle<CR>", opts, { desc = "Neotree Toggle" })
    -- map("n", "<leader>n", ":Neotree focus<CR>", opts, { desc = "Neotree" })
    config = function()
        require("neo-tree").setup({
            close_if_last_window = false,
            open_on_setup = false,
            popup_border_style = "rounded", -- or 'solid', 'double', 'shadow', 'curved', 'rounded', single,
            enable_git_status = true,
            enable_modified_markers = true,
            -- enable_diagnostics = true,
            sort_case_insensitive = true,
            update_cwd = true, -- update cwd on open -- Will have to see how this works with my workflow

            default_component_configs = {
                indent = {
                    with_markers = false,
                    with_expanders = true,
                },
                modified = {
                    symbol = " ",
                    highlight = "NeoTreeModified",
                },
                icon = {
                    folder = {
                        default = "",
                        open = "",
                        symlink = "",
                    },
                    file = {
                        default = "",
                        symlink = "",
                    },
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added = "",
                        deleted = "",
                        modified = "",
                        renamed = "",
                        -- Status type
                        untracked = "",
                        ignored = "",
                        unstaged = "",
                        staged = "",
                        conflict = "",
                    },
                },
            },
            window = {
                position = "float",
                width = 40,
            },
            filesystem = {
                use_libuv_file_watcher = true,
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                        "node_modules",
                    },
                    always_show = {
                        "AppData",
                        ".git",
                        ".gitignore",
                        ".gitignored",
                    },
                    never_show = {
                        ".DS_Store",
                        "thumbs.db",
                    },
                    never_show_by_pattern = {
                        "NTUSER.DAT*",
                        "ntuser.ini*",
                    },
                    follow_current_file = {
                        enabled = true,
                    },
                },
            },

            -- window = {
            mappings = {
                --     ["<leader>"] = {
                --         ["<leader>"] = "toggle",
                --     },
                ["<bs>"] = "close_node",
                ["<2-LeftMouse>"] = "edit",
                ["<C-]>"] = "cd",
                ["<C-[>"] = "navigate_up",
                ["s"] = "split",
                ["v"] = "vsplit",
            },
            -- },

            event_handlers = {
                {
                    event = "neo_tree_window_after_open",
                    handler = function(args)
                        if args.position == "left" or args.position == "right" then
                            vim.cmd("wincmd =")
                        end
                    end,
                },
                {
                    event = "neo_tree_window_after_close",
                    handler = function(args)
                        if args.position == "left" or args.position == "right" then
                            vim.cmd("wincmd =")
                        end
                    end,
                },
            },
        })
    end,
}
--
--             opts = {
--                 source_selector = {
--                     winbar = true,
--                 },
--                 mappings = {
--                     ["<space>"] = {
--                         "toggle_node",
--                         nowait = false,
--                     },
--                     ["s"] = "open_split",
--                     ["v"] = "open_vsplit",
--                     ["<bs>"] = "close_node",
--                 },
--                 filestystem = {
--                     -- follow_current_file = { enabled = true },
--                     filtered_items = {
--                         visible = false,
--                         hide_dotfiles = false,
--                         hide_gitignored = false,
--                         show_hidden_count = true,
--                         hide_hidden = true, --windows specific.
--                         hide_by_name = {
--                             -- "node_modules"
--                         },
--                         always_show = { -- remains visible even if other settings would normally hide it
--                             "AppData",
--                             ".git",
--                             ".gitignore",
--                             ".gitignored",
--                         },
--                     },
--
--                     use_lubuv_file_watcher = true, -- Makes NeoTree use the OS level file watcher to detect changes
--                     window = {
--
--                         mappings = {
--                             ["<->"] = "navigate_up",
--                         }
--                     },
--                 },
--
--                 buffers = {
--                     follow_current_file = {
--                         enabled = true,
--                     },
--                 }
--             }
--         })
--         local map = vim.keymap.set
--         opts = {
--             silent = true
--         }
--     end,
-- }
