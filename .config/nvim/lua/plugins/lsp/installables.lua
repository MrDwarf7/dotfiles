--- Each subtable represents one of the tabs available in `:Mason`.
--- If you want to hand this to an `ensure_installed` table - you must call the `.flatten()` method on it.
---@class MasonEnsureInstalled
---@field formatters string[] List of formatters to ensure installed
---@field formatters_tbl fun(): string[] Returns the list of formatters in the table
---
---@field linters string[] List of linters to ensure installed
---@field linters_tbl fun(): string[] Returns the list of linters in the table
---
---@field lsps string[] List of LSP servers to ensure installed
---@field lsps_tbl fun(): string[] Returns the list of LSP servers in the table
---
---@field daps string[] List of DAP servers to ensure installed
---@field daps_tbl fun(): string[] Returns the list of DAP servers in the table
---
---@field flatten fun(): string[] Returns a flattened list of all tools in the table
local M = {}

M = {
  --
  formatters = {
    "beautysh",
    "black",
    "cbfmt",
    "clang-format",
    "cmakelang",
    "fixjson",
    "gofumpt",
    "isort",
    "markdown-toc",
    "markdownlint-cli2",
    "mdslw",
    "ols", -- Odin
    "prettier",
    "shfmt",
    "sql-formatter",
    "stylua",
    "taplo",
    "typstyle",
    "yamlfmt",
    -- "csharpier",
  },

  linters = {
    "biome",
    "cmakelang",
    "cmakelint",
    "cpplint",
    "denols",
    "golangci-lint",
    "hadolint",
    "jsonlint",
    "markdownlint-cli2",
    "mypy",
    "ruff",
    "shellcheck",
    "sqlfluff",
    "ts-standard",
    "ty",
    -- "bacon",
  },

  lsps = {

    "bashls",
    "c3-lsp",
    "clangd",
    "copilot",
    "cssls",
    "cssmodules_ls",
    "denols",
    "djlsp",
    "docker-language-server",
    "docker_compose_language_service",
    "dockerls",
    "fish_lsp",
    "gh_actions_ls",
    "gopls",
    "html",
    "hyprls",
    "jsonls",
    "just",
    "lua_ls",
    "markdown-oxide",
    "mesonlsp",
    "neocmake",
    "ols",
    "prismals",
    "qmlls",
    "tailwindcss",
    "tinymist",
    "ts_ls", -- Want it _installed_ only
    "tsc",
    "ty",
    "vimls",
    "vue-language-server",
    "yamlls",
    "zls",

    -- "bacon_ls",
    -- "basedpyright",
    -- "erlangls", -- requires rebar3 installed/available
    -- "eslint",
    -- "gleam",
    -- "luau-lsp",
    -- "nushell",
    -- "ocamlformat",
    -- "ocamllsp",
    -- "omnisharp",
    -- "powershell_es",
    -- "rust-analyzer",
    -- "svelte",
  },

  daps = {
    "codelldb",
    "debugpy",
    "delve",
  },
}

-- TODO: [extract] : pull this out into a common if not already in vim_ext/{lst/tbl).lua

function M.flatten()
  local ret = {}
  for _, sub_tbl in pairs(M) do
    if type(sub_tbl) == "table" then
      for _, tool in ipairs(sub_tbl) do
        table.insert(ret, tool)
      end
    end
  end
  return ret
end

-- TODO: [performance] : All of these can be done via a metatable handover

function M.formatters_tbl()
  return M.formatters
end

function M.linters_tbl()
  return M.linters
end

function M.lsps_tbl()
  return M.lsps
end

function M.daps_tbl()
  return M.daps
end

return M
