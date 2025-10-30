local lang_tables = require("lang_tables")

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  lazy = false,
  -- lazy = true,
  -- event = "VeryLazy",
  event = "BufReadPost",
  dependencies = {
    { "mason-org/mason.nvim", event = "BufReadPost" },
    { "mason-org/mason-lspconfig.nvim", event = "BufReadPost" },
  },
  opts = {
    -- Can handle everything that's listed in
    -- mason pop-ups.
    ensure_installed = lang_tables.mason_ensure_installed(),
  },
}

-- local original_list = {
--
--   -------------------------------
--   ---Formatters
--
--   "beautysh",
--   "black",
--   "cbfmt",
--   "clang-format",
--   -- "csharpier",
--   "fixjson",
--   "isort",
--   "mdslw",
--   "prettier",
--   "shfmt",
--   "sql-formatter",
--   "stylua",
--   "taplo",
--   "typstyle",
--   "yamlfmt",
--
--   -------------------------------
--   ---Linters
--
--   -- "bacon",
--   "biome",
--   "cmakelang",
--   "cmakelint",
--   "cpplint",
--   "jsonlint",
--   "markdownlint-cli2",
--   "mypy",
--   "ruff",
--   "sqlfluff",
--   "ts-standard",
--   "vulture",
--   "yamllint",
--
--   -------------------------------
--   ---LSP's
--
--   -- "bacon_ls",
--   "basedpyright",
--   "bashls",
--   "c3-lsp",
--   "clangd",
--   "copilot",
--   "cssls",
--   "cssmodules_ls",
--   "djlsp",
--   "docker_compose_language_service",
--   "dockerls",
--   -- "erlangls", -- requires rebar3 installed/available
--   "eslint",
--   "fish_lsp",
--   -- "gleam",
--   "gopls",
--   "html",
--   "hyprls",
--   "jsonls",
--   "lua_ls",
--   "mesonlsp",
--   "neocmake",
--   -- "nushell",
--   -- "ocamlformat",
--   -- "ocamllsp",
--   "ols",
--   "omnisharp",
--   "powershell_es",
--   -- "powershell_es",
--   "prismals",
--   "qmlls",
--   -- "rust-analyzer",
--   "svelte",
--   "tailwindcss",
--   "tinymist",
--   "vimls",
--   "vue-language-server",
--   "yamlls",
--   "zls",
--
--   -------------------------------
--   ---DAP/Debuggers
--
--   "codelldb",
--   "debugpy",
--   "delve",
-- }
