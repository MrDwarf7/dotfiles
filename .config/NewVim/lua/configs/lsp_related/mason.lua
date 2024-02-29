local mason = require("mason")

local ensure_installed_table = {}

-- if vim.g.os == "unix" then
--     ensure_installed_table = {
--         "beautysh",
--         "biome",
--         "biome",
--         "black",
--         "blackd-client",
--         "eslint_d",
--         "isort",
--         "mypy",
--         "prettier",
--         "prettierd",
--         "pyright",
--         "ruff",
--         -- "ruff_lsp",
--         "rust",
--         "rust_analyzer",
--         "rustywind",
--         "shellcheck",
--         "shfmt",
--         "ts-standard",
--         "vulture",
--     }
-- elseif vim.g.os == "win32" then
--     ensure_installed_table = {
--         "beautysh",
--         "biome",
--         "biome",
--         "black",
--         -- "blackd-client",
--         "eslint_d",
--         "isort",
--         "mypy",
--         "prettier",
--         "prettierd",
--         "pyright",
--         "ruff",
--         -- "ruff_lsp",
--         "rust",
--         "rust_analyzer",
--         "rustywind",
--         "shellcheck",
--         "shfmt",
--         "ts-standard",
--         "vulture",
--     }
-- end

mason.setup({
    -- ensure_installed = ensure_installed_table,

    pip = {
        upgrade_pip = true,
    },

    ui = {
        border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
        icons = {
            package_pending = " ",
            package_installed = "󰄳 ",
            package_uninstalled = " 󰚌",
        },
    },

})
