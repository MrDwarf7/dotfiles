return {
  {
    "mason.nvim",
    -- events = { "VeryLazy" },
    lazy = false,
    -- version = "^1.0.0",
    keys = {
      { "<leader>cm", false },
    },
    opts = {
      ensure_installed = {
        --         -- "bacon",
        "basedpyright",
        "beautysh",
        "black",
        "c3-lsp",
        "cbfmt",
        "clang-format",
        "cmakelang",
        "cmakelint",
        "codelldb",
        "cpplint",
        -- -- "csharpier",
        "debugpy",
        "delve",
        "fixjson",
        "gopls",
        "isort",
        "jsonlint",
        "markdownlint-cli2",

        --         -- -- "markdown-toc",
        --         -- --"markdown_oxide",
        --         -- -- "mdsf",
        "mdslw",
        "mypy",
        "ocamlformat",
        --         -- -- "powershell_es",
        "prettier",
        "ruff",
        "shfmt",
        "sqlfluff",
        "sql-formatter",
        "svelte-language-server",
        "stylua",
        "tinymist", -- typst -- typstyle & typstfmt are included in tinymist
        "ts-standard",
        -- "typstfmt", -- typst
        "typstyle", -- typst
        "vue-language-server",
        "vulture",
        "yamlfmt",
        "yamllint",
      },
      --
    },
  },
  {
    "mason-lspconfig.nvim",
    -- version = "^1.0.0",
    lazy = true,
  },
}
