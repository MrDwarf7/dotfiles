local nvim_lint = require("lint")
local autocmd = vim.api.nvim_create_autocmd

nvim_lint.linter_by_ft = {
    css = { "stylelint" },
    yaml = { "yamllint" },
    docker = { "hadolint" },
    python = { "ruff_lsp", "mypy", "vulture", { "ruff_lsp" } },
    vim = { "vint" },
    sh = { "shellcheck" },
    lua = { "luacheck" },
    javascript = { "biomejs" },
    typescript = { "biomejs" },
    cpp = { "cpplint", "clang-tidy" },
}

autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
