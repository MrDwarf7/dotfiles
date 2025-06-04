return {
  "nvim-lint",
  opts = {
    linters_by_ft = {

      cpp = { "cpplint", "clang-tidy" },
      css = { "stylelint" },
      cmake = { "cmakelint " },
      -- cs = { "omnisharp" },
      docker = { "hadolint" },
      javascript = { "biomejs" },
      javascriptreact = { "biomejs" },
      json = { "jsonlint" },
      lua = { "luacheck" },
      powershell = { "powershell_es" },
      -- python = { "ruff_lsp", "mypy", "vulture", { "ruff_lsp" } },
      -- python = { "ruff", "mypy", "vulture" },
      python = { "ruff", "vulture" },
      sh = { "shellcheck" },
      sql = { "sqlfluff" },
      typescript = { "biomejs" },
      typescriptreact = { "biomejs" },
      vim = { "vint" },
      yaml = { "yamllint" },
    },
  },
}
