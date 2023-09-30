return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                -- pyright will be automatically installed with mason and loaded with lspconfig
                pyright = {},
                eslint = {
                    settings = {
                        workingDirectory = { mode = "auto" },
                    },
                },
            },
            setup = {
                ruff_lsp = function()
                    require("lazyvim.util").on_attach(function(client, _)
                        if client.name == "ruff_lsp" then
                            client.server_capabilities.hoverProvider = false
                        end
                    end)
                end,
                eslint = function()
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        callback = function(event)
                            if not require("lazyvim.plugins.lsp.format").enabled() then
                                -- Simply exit early if autoformat is disabled
                                return
                            end

                            -- Else we need to check if there are any eslint errors
                            local client = vim.lsp.get_active_clients({ bufnr = event.buf, name = "eslint" })[1]
                            if client then
                                local diag = vim.diagnostic.get(event.buf,
                                    { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
                                if #diag > 0 then
                                    vim.cmd("EslintFixAll")
                                end
                            end
                        end,
                    })
                end,
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, {
                    "lua",
                    "python",
                    "html",
                    "javascript",
                    "typescript",
                    "tsx",
                    "json",
                    "markdown",
                    "markdown_inline",
                    "query",
                    "regex",
                    "vim",
                    "yaml",
                })
            end
        end,
    },

    {
        "zbirenbaum/copilot.lua",
        enabled = true,
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = true, -- TOGGLE
                    auto_refresh = true,
                    keymap = {
                        jump_next = "<A-]>",
                        jump_prev = "<A-[>",
                        accept = "<CR>",
                        refresh = "gr", -- Consider <leader>cn ("Co-pilot New" ?)
                        open = "<A-CR>",
                    },
                    layout = {
                        position = "bottom",
                        ratio = 0.4,
                    },
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true, --DEFAULT FOR NOW
                    debounce = 75,       --No idea lol
                    keymap = {
                        accept = "<A-a>",
                        accept_word = false,
                        accept_line = false,
                        next = "<A-]>",
                        prev = "<A-[>",
                        dismiss = "<C-Space>",
                    },
                },
            })
        end,
    },

    {
        "zbirenbaum/copilot-cmp",
        depencencies = {
            "zbirenbaum/copilot.lua",
        },
        -- after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
    },
}
