return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        -- lazy = false,
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = true,      -- Temp disabled to test copilot_cmp
                    auto_refresh = false, -- This is the default setting
                    keymap = {
                        open = "<C-<CR>>"
                    }
                },

                suggestion = {
                    enabled = false, -- Temp disabled to test copilot-cmp
                    auto_trigger = true,
                    keymap = {
                        accept = "<C-l>",
                        accept_word = "<A-l>",
                        next = "<A-]>",
                        prev = "<A-[>",
                        dismiss = "<C-c>",
                    },
                },

                filetypes = { -- Defaults are all false basically
                    yaml = true,
                    markdown = true,
                    help = false,
                    gitcommit = true,
                    gitrebase = true,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = true,
                },
                copilot_node_command = 'node', -- What other ways can it be run??
                server_opts_overrides = {},
            })                                 -- End of setup fnc

            vim.keymap.set("n", "<Leader>lP", function()
                vim.cmd("Copilot panel")
            end, { desc = "copilot [P]anel" }
            )
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        --lazy = false,
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                opts = { history = true, updateevents = "TextChanged,TextChangedI" },
                config = function(_, opts)
                    local cmp_util = require("configs.completion_sub.cmp_sub_module")
                    cmp_util.luasnip_func(opts)
                end
            },

            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)
                    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },

            -----------------
            {
                "doxnit/cmp-luasnip-choice",
                -- lazy = false,
                config = function()
                    require("cmp_luasnip_choice").setup({
                        auto_open = true, -- Automatically open nvim-cmp on choice node (default: true)
                    });
                end,
            },

            -----------------

            {
                "saecki/crates.nvim",
                tag = "stable",
                config = function()
                    require("crates").setup()
                end,
            },

            {
                "vrslev/cmp-pypi",
                dependencies = { "nvim-lua/plenary.nvim" },
                ft = "toml",
            },

            {
                "zbirenbaum/copilot-cmp",
                dependencies = {
                    "zbirenbaum/copilot.lua",
                },

                config = function()
                    require("copilot_cmp").setup({
                        suggestion = { enabled = false },
                        panel = { enabled = false },
                    })
                end
            },

            -----------------

            {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",

                "zbirenbaum/copilot-cmp", -- new


                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",

                "doxnit/cmp-luasnip-choice", -- new
                "saecki/crates.nvim",        -- new
                "vrslev/cmp-pypi",           -- new

                "petertriho/cmp-git",
                "hrsh7th/cmp-cmdline",
            },
        },

        config = function()
            local cmp = require("cmp")
            local cmp_utils = require("configs.completion_sub.cmp_sub_module")
            local opts = cmp_utils.nvim_cmp_main_opts()

            cmp.setup(opts)
        end
    },

}
