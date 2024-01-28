return {
    {
        "neovim/nvim-lspconfig",
        event = "BufEnter",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },

        -- Mason LSP CONFIG
        -- allows specifically for a cross over in the naming schema between
        -- the actual lsp server, and the naming conventions for the connections.
        -- in the below list - go to Mason, hit / to start a search and cancel it,
        -- this will give ghost text of the udnerlying name - Which is what you want to use here.

        config = function()
            -- local augroup = vim.api.nvim_create_augroup
            -- local autocmd = vim.api.nvim_create_autocmd
            -- local LspAuGroup = augroup("LspAuGroup ", { clear = true })

            require("mason").setup({
                ui = {
                    border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
                    icons = {
                        package_pending = " ",
                        package_installed = "󰄳 ",
                        package_uninstalled = " 󰚌",
                    }
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "tsserver",
                    "biome",
                    "awk_ls", -- Un-updated (requires running LTS version of node via NVM)
                    "azure_pipelines_ls",
                    "bashls",
                    "clangd",
                    "cmake",
                    "cssls",
                    "docker_compose_language_service",
                    "dockerls",
                    "eslint",
                    "html",
                    "taplo",
                    "marksman",
                    "powershell_es",
                    "prismals",
                    --"pyright",
                    "ruff_lsp",
                    --"rust_analyzer", -- Since using Rustaceanvim, DO NOT SETUP via lspconfig call
                    "slint_lsp",
                    "vimls",
                    "yamlls",
                    "zls",
                },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup {}
                    end,
                }, -- handlers end


            })

            vim.keymap.set('n', '<Leader>lt', ":TodoLocList<CR>", { desc = "[T]odo's" })
            -- LSP attach autocmds are called within the autocmds file (group = LspAuGroup)
        end,
    },

    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        --lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "mfussenegger/nvim-dap",
            {
                "lvimuser/lsp-inlayhints.nvim",
                opts = {}
            },
        },
        ft = { 'rust' },
        config = function()
            vim.g.rustaceanvim = {
                inlay_hints = {
                    highlight = "NonText",
                },
                tools = {
                    hover_actions = {
                        auto_focus = true,
                    },
                },
                server = {
                    on_attach = function(client, bufnr)
                        require("lsp-inlayhints").on_attach(client, bufnr)
                    end
                }
            }

            local bufnr = vim.api.nvim_get_current_buf()
            vim.keymap.set("n", "<Leader>la", function()
                vim.cmd.RustLsp("codeAction")
            end, { silent = true, buffer = bufnr, desc = "[A]ction" }
            )

            vim.keymap.set("n", "<Leader>dr", function()
                vim.cmd.RustLsp("runnables")
            end, { silent = true, buffer = bufnr, desc = "[R]un" }
            )

            vim.keymap.set("n", "<Leader>lc", function()
                vim.cmd.RustLsp("flyCheck")
            end, { silent = true, buffer = bufnr, desc = "[C]heck" }
            )
        end
    },
}
