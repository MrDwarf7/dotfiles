-- local WantsTypeE = require("lang_tables.t").WantsTypeE
-- local CategoryE = require("lang_tables.t").CategoryE
-- local SubtypeE = require("lang_tables.t").SubtypeE

local lt_enums = require("types").LangTablesEnums or {}
local WantsTypeE = lt_enums.WantsTypeE or {}
local CategoryE = lt_enums.CategoryE or {}
local SubtypeE = lt_enums.SubtypeE or {}

---@type LangTables
local LangTables = {}

-- TODO: Move this to a LangHub and
-- setup the module and all the proper scaffolding.
-- This will then be deprecated/removed later

---@type LangTables
LangTables = {
  ---@type TreeSitterSubtype
  treesitter = {
    languages = {

      "awk",
      "bash",
      "c",
      "cmake",
      "cpp",
      "c_sharp",
      "css", -- not in given list but
      "elixir",
      "fish",
      "fsh",
      "go",
      "javascript",
      "just",
      "lua",
      "luadoc",
      "luap",
      -- "luau",
      "make",
      "meson",
      "mlir",
      "nginx",
      "nu",
      "odin",
      -- "powershell",
      "prisma",
      "python",
      "regex",
      -- "robot",
      "rust",
      "scss", --- not in given list but
      "sql",
      -- "surrealdb",
      -- "teal",
      "terraform",
      -- "tmux", --- WOULD BE moved to langs, but it's not really
      "tsx",
      "typescript",
      "typst", -- not in given list but
      "vim",
      "zig",
    },
    data_formats = {

      "desktop",
      "embedded_template",
      "gomod",
      "gosum",
      "html",
      "htmldjango",
      "http",
      "ini",
      "jinja",
      "jinja_inline",
      "jq",
      "json",
      "json5",
      -- "jsonc",
      "kdl",
      "markdown",
      "markdown_inline",
      "poe_filter",
      "ron",
      "rst",
      "scss",
      "toml",
      "tsv",
      "vimdoc",
      "yaml",
    },
    system = {

      "diff",
      "gitattributes",
      "gitcommit",
      "git_config",
      "gitignore",
      "git_rebase",
      "gpg",
      "ninja",
      "passwd",
      "printf",
      -- "robots",
      "ssh_config",
      -- "tmux", --- WOULD BE moved to langs, but it's not really
    },
  },
  ---@type MasonSubtype
  mason = {
    formatters = {

      "beautysh",
      "black",
      "cbfmt",
      "clang-format",
      "cmakelang",
      -- "csharpier",
      "fixjson",
      "gofumpt",
      "isort",
      "ols", -- Odin
      "markdown-toc",
      "markdownlint-cli2",
      "mdslw",
      "prettier",
      "shfmt",
      "sql-formatter",
      "stylua",
      "taplo",
      "typstyle",
      "yamlfmt",
    },

    formatters_by_ft = {

      ["bash"] = { "shfmt", "beautysh" },
      ["cpp"] = { "clangformat" },
      ["cmake"] = { "cmakelang", "neocmake" },
      ["go"] = { "gofumpt" },

      -- ["fish"] = { "beautysh" },
      ["gleam"] = { "gleam" },
      ["javascript"] = { "biome" },
      ["javascriptreact"] = { "biome" },
      ["json"] = { "fixjson" }, -- Cannot use "biome" here as it will break a lot of json due to trailing commas where there shouldn't be any
      ["lua"] = { "stylua" },
      -- ["luau"] = { "stylua" },
      ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
      -- markdown = { "prettier" },
      ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
      ["ocaml"] = { "ocamlformat" },
      ["python"] = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
      ["odin"] = { "odinfmt" },
      -- ["rust"] = { "rustfmt" },
      ["sh"] = { "shfmt" },
      ["sql"] = { "sql_formatter" },
      ["surql"] = { "sql_formatter" },
      ["toml"] = { "taplo" },
      ["typescript"] = { "biome" },
      ["typescriptreact"] = { "biome" },
      ["yaml"] = { "yamlfmt" },
      ["zsh"] = { "beautysh" },
    },

    linters = {

      -- "bacon",
      "biome",
      "cmakelang",
      "cmakelint",
      "cpplint",
      "denols",
      "hadolint",
      "jsonlint",
      -- "luacheck",
      "markdownlint-cli2",
      "mypy",
      "ty",
      "ruff",
      "shellcheck",
      "sqlfluff",
      "ts-standard",
      -- "vulture",
      -- "yamllint",
    },

    linters_by_ft = {
      ["bash"] = { "shellcheck" },
      ["cmake"] = { "cmakelint" },
      ["cpp"] = { "cpplint" },
      ["hpp"] = { "cpplint" },
      -- ["c"] = { "clang-tidy" },
      -- ["h"] = { "clang-tidy" },
      -- cs = { "omnisharp" },
      ["css"] = { "stylelint" },
      ["docker"] = { "hadolint" },
      ["javascript"] = { "biomejs" },
      ["javascriptreact"] = { "biomejs" },
      ["json"] = { "jsonlint" },
      ["odin"] = { "ols" },

      -- ["lua"] = { "luacheck" },
      -- markdown = { "markdownlint-cli2" },
      -- powershell = { "powershell_es" },
      -- python = { "ruff_lsp", "mypy", "vulture", { "ruff_lsp" } },
      -- python = { "ruff", "mypy", "vulture" },
      -- ["rust"] = { "rust_analyzer" },
      ["python"] = { "ruff" },
      ["sh"] = { "shellcheck" },
      ["sql"] = { "sqlfluff" },
      ["typescript"] = { "biomejs" },
      ["typescriptreact"] = { "biomejs" },
      ["vim"] = { "vint" },
      -- ["yaml"] = { "yamllint" },
    },

    lsps = {

      -- "bacon_ls",
      -- "basedpyright",
      "ty",
      "bashls",
      "c3-lsp",
      "clangd",
      "copilot",
      "cssls",
      "cssmodules_ls",
      "denols",
      "djlsp",
      "docker_compose_language_service",
      "docker-language-server",
      "dockerls",
      -- "erlangls", -- requires rebar3 installed/available
      -- "eslint",
      "fish_lsp",
      "gh_actions_ls",
      -- "gleam",
      "gopls",
      "html",
      "hyprls",
      "jsonls",
      -- "luau-lsp",
      "lua_ls",
      "markdown-oxide",
      "mesonlsp",
      "neocmake",
      -- "nushell",
      -- "ocamlformat",
      -- "ocamllsp",
      "ols",
      -- "omnisharp",
      -- "powershell_es",
      "prismals",
      "qmlls",
      -- "rust-analyzer",
      -- "svelte",
      "tailwindcss",
      "tinymist",
      "ts_ls",
      "vimls",
      "vue-language-server",
      "yamlls",
      "zls",
    },
    daps = {
      "codelldb",
      "debugpy",
      "delve",
    },
  },
  disabled = {},
  merged = {},
}

--- Merges items for a category/subtype, caching the result.
---@param category Category
---@param subtype? Subtype | "all"
---@return ListElements
local function merge_category(category, subtype)
  subtype = subtype or "all"
  if not LangTables.merged[category] then
    LangTables.merged[category] = {}
  end
  if not LangTables.merged[category][subtype] then
    --TODO ---@type MasonSubtypeE|TreeSitterSubtypeE
    local source = LangTables[category]
    if subtype == "all" then
      ---@type ListElements
      local merged = {}
      for _, sub in pairs(source) do
        vim.list_extend(merged, sub)
      end
      ---@type ListElements
      LangTables.merged[category][subtype] = merged
    else
      LangTables.merged[category][subtype] = vim.deepcopy(source[subtype] or {})
    end
  end
  return LangTables.merged[category][subtype]
end

--- Returns items based on category, subtype, wants_type, and optional filter.
---@param category Category
---@param subtype? Subtype | "all"
---@param wants_type? WantsType | table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.get(category, subtype, wants_type)
  subtype = subtype or "all"
  local base = merge_category(category, subtype)

  if type(wants_type) == "nil" then
    return vim.tbl_filter(function(item)
      return not LangTables.disabled[item]
    end, base)
  end

  if type(wants_type) == "boolean" then
    return wants_type and {} or base -- true: empty, false: all (unfiltered base)
  end

  if type(wants_type) == "table" and not vim.islist(wants_type) then
    -- vim.tbl_islist(wants_type) then
    -- Assume { [item] = true } for filter/exclude
    local result = {}
    for _, item in ipairs(base) do
      if not wants_type[item] and not LangTables.disabled[item] then
        table.insert(result, item)
      end
    end
    return result
  end

  if type(wants_type) == "table" and vim.islist(wants_type) then
    -- vim.tbl_islist(wants_type) then
    -- Custom list: intersect with base or use directly?
    -- Here, filter base to only include items in the list, excluding disabled
    return vim.tbl_filter(function(item)
      return vim.tbl_contains(wants_type, item) and not LangTables.disabled[item]
    end, base)
  end

  ---@type WantsTypeLiteral
  -- local wants = wants_type == WantsTypeE.all and "all"
  --   or wants_type == WantsTypeE.ensure_installed and "ensure_installed"
  --   or wants_type == WantsTypeE.disabled and "disabled"
  --   or wants_type
  --   or "all"

  local wants = wants_type == WantsTypeE.all and "all"
    or wants_type == WantsTypeE.ensure_installed and "ensure_installed"
    or wants_type == WantsTypeE.disabled and "disabled"
    or wants_type
    or "all"

  if wants == "disabled" then
    -- Return disabled items that are in this category/subtype
    local disabled_in_scope = {}
    for _, item in ipairs(base) do
      if LangTables.disabled[item] then
        table.insert(disabled_in_scope, item)
      end
    end
    return disabled_in_scope
  elseif wants == "ensure_installed" then
    return vim.tbl_filter(function(item)
      return not LangTables.disabled[item]
    end, base)
  else -- "all"
    return vim.deepcopy(base)
  end
end

--- Sets disabled items, optionally scoped to a category/subtype.
---@param to_disable table<string, boolean> | ListElements | boolean
---@param category? Category
---@param subtype? Subtype | "all"
function LangTables.set_disabled(to_disable, category, subtype)
  if type(to_disable) == "boolean" then
    if to_disable then
      LangTables.disabled = {} -- Clear all
    end
    return
  end

  local scope = category and subtype and merge_category(category, subtype) or nil

  if type(to_disable) == "table" then
    for _, item in ipairs(to_disable) do
      if not scope or vim.tbl_contains(scope, item) then
        LangTables.disabled[item] = true
      end
    end
  end
end

-----------
--- Treesitter Convenience

-- ts enabled

--- Convenience for treesitter all.
function LangTables.ts_all(removable)
  return LangTables.get(CategoryE.treesitter, "all", removable or WantsTypeE.all)
end

--- Convenience for treesitter ensure_installed.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.ts_ensure_installed(removable)
  return LangTables.get(CategoryE.treesitter, "all", removable or WantsTypeE.ensure_installed)
end

--- Convenience for treesitter ensure_installed languages.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.ts_ensure_installed_languages(removable)
  return LangTables.get(CategoryE.treesitter, SubtypeE.treesitter.languages, removable or WantsTypeE.ensure_installed)
end

--- Convenience for treesitter ensure_installed data_formats.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.ts_ensure_installed_data_formats(removable)
  return LangTables.get(
    CategoryE.treesitter,
    SubtypeE.treesitter.data_formats,
    removable or WantsTypeE.ensure_installed
  )
end

--- Convenience for treesitter ensure_installed system.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.ts_ensure_installed_system(removable)
  return LangTables.get(CategoryE.treesitter, SubtypeE.treesitter.system, removable or WantsTypeE.ensure_installed)
end

-- ts disabled

--- Convenience for treesitter disabled.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.ts_disabled(removable)
  return LangTables.get(CategoryE.treesitter, SubtypeE.all, removable or WantsTypeE.disabled)
end

--- Convenience for treesitter disabled languages.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.ts_disabled_languages(removable)
  return LangTables.get(CategoryE.treesitter, SubtypeE.treesitter.system, removable or WantsTypeE.disabled)
end

--- Convenience for treesitter disabled data_formats.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.ts_disabled_data_formats(removable)
  return LangTables.get(CategoryE.treesitter, SubtypeE.treesitter.data_formats, removable or WantsTypeE.disabled)
end

--- Convenience for treesitter disabled system.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.ts_disabled_system(removable)
  return LangTables.get(CategoryE.treesitter, SubtypeE.treesitter.system, removable or WantsTypeE.disabled)
end

-----------
--- Mason Convenience

-- mason enabled

--- Convenience for mason all.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.mason_all(removable)
  return LangTables.get(CategoryE.mason, "all", removable or WantsTypeE.all)
end

--- Convenience for mason linters ensure_installed.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.mason_ensure_installed(removable)
  return LangTables.get(CategoryE.mason, "all", removable or WantsTypeE.ensure_installed)
end

--- Convenience for mason formatters ensure_installed.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.mason_ensure_installed_formatters(removable)
  return LangTables.get(CategoryE.mason, SubtypeE.mason.formatters, removable or WantsTypeE.ensure_installed)
end

--- Convenience for mason linters ensure_installed.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.mason_ensure_installed_linters(removable)
  return LangTables.get(CategoryE.mason, SubtypeE.mason.linters, removable or WantsTypeE.ensure_installed)
end

--- Convenience for mason lsps ensure_installed.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.mason_ensure_installed_lsps(removable)
  return LangTables.get(CategoryE.mason, SubtypeE.mason.lsps, removable or WantsTypeE.ensure_installed)
end

--- Convenience for mason ensure installed daps.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.mason_ensure_installed_daps(removable)
  return LangTables.get(CategoryE.mason, SubtypeE.mason.daps, removable or WantsTypeE.ensure_installed)
end

-- mason disabled

--- Convenience for mason disabled.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.mason_disabled(removable)
  return LangTables.get(CategoryE.mason, "all", removable or WantsTypeE.disabled)
end

--- Convenience for mason disabled formatters.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.mason_disabled_formatters(removable)
  return LangTables.get(CategoryE.mason, SubtypeE.mason.formatters, removable or WantsTypeE.disabled)
end

--- Convenience for mason disabled linters.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.mason_disabled_linters(removable)
  return LangTables.get(CategoryE.mason, SubtypeE.mason.linters, removable or WantsTypeE.disabled)
end

--- Convenience for mason disabled lsps.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.mason_disabled_lsps(removable)
  return LangTables.get(CategoryE.mason, SubtypeE.mason.lsps, removable or WantsTypeE.disabled)
end

--- Convenience for mason disabled daps.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.mason_disabled_daps(removable)
  return LangTables.get(CategoryE.mason, SubtypeE.mason.daps, removable or WantsTypeE.disabled)
end

-- dap enabled

--- Convenience for dap all.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.daps_all(removable)
  return LangTables.get(CategoryE.mason, SubtypeE.mason.daps, removable or WantsTypeE.all)
end

--- Convenience for mason ensure installed daps.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.daps_ensure_installed(removable)
  return LangTables.get(CategoryE.mason, SubtypeE.mason.daps, removable or WantsTypeE.ensure_installed)
end

--- Convenience for mason disabled daps.
---@param removable? table<string, boolean> | boolean | ListElements
---@return ListElements
function LangTables.daps_disabled(removable)
  return LangTables.get(CategoryE.mason, SubtypeE.mason.daps, removable or WantsTypeE.disabled)
end

-----------
--- Generic (nvim-lint, conform, etc.)

---@param behavior string|function
---@return boolean, string|function
local check_behaviour = function(behavior)
  local valids = { "error", "force", "keep", "function" }
  if type(behavior) == "string" then
    for _, v in ipairs(valids) do
      if behavior == v then
        return true, behavior
      end
    end
  end
  return false, behavior
end

function LangTables.by_ft(behavior, typeof, extra_fmtters)
  local ok
  ok, behavior = check_behaviour(behavior)
  if not ok then
    behavior = "force" -- default
    local util = require("utils.output")
    util.warn(
      string.format(
        "Invalid behavior provided to LangTables.by_ft(). Using default 'force'. Given: %s",
        tostring(behavior)
      )
    )
  end

  if type(typeof) == "nil" then
    local util = require("utils.output")
    return util.err("You must provide a typeof ('linters' or 'formatters')")
  end

  -- check if the 'typeof' param has an 's' at the end, if not, add it
  if typeof:sub(-1) ~= "s" then
    typeof = typeof .. "s"
  end

  local target_set = LangTables.mason[typeof .. "_by_ft"] or {}

  local b_type = type(behavior)
  if b_type == "function" then
    behavior = behavior()
  else
    behavior = behavior or "force"
  end

  -- print("behaviour:", vim.inspect(behavior))

  target_set = vim.tbl_deep_extend(
    --
    behavior,
    {},
    target_set,
    extra_fmtters or {}
  )
  return target_set
end

-- local enforce_c_headers = function(ft)
--   if ft == "h" then
--     local filename = vim.api.nvim_buf_get_name(0)
--     if filename:match("%.h$") then
--       return "c"
--     elseif filename:match("%.hpp$") then
--       return "cpp"
--     end
--   end
--   return ft
-- end

---@deprecated Use LangTables.by_ft("linters", ft) instead.
--- Returns the LangTables.mason.linter(s) by filetype association.
---@param ft? Ft
function LangTables.linters_by_ft(ft)
  if type(ft) ~= "string" then
    ft = ft or vim.bo.filetype or ""
  end
  ft = string.format("%s", ft)

  -- currently all <foo>.h files auto map to CPP, which... isn't correct.
  -- <foo>.hpp == CPP,
  -- <foo>.h == C

  -- if ft == "h" then
  --   ft = enforce_c_headers(ft)
  -- end

  local target = LangTables.mason.linters_by_ft[ft] or {}
  if type(target) == "function" then
    return target()
  else
    return target
  end
end

---@deprecated Use LangTables.by_ft("formatters", ft, bufnr) instead.
--- Returns the LangTables.mason.formatters_by_ft
---@param ft? Ft
---@param bufnr? integer
function LangTables.formatters_by_ft(ft, bufnr)
  if type(ft) ~= "string" then
    ft = ft or vim.bo.filetype or ""
  end
  ft = string.format("%s", ft)

  bufnr = bufnr or vim.api.nvim_get_current_buf()

  -- if ft == "h" then
  --   ft = enforce_c_headers(ft)
  -- end

  local target = LangTables.mason.formatters_by_ft[ft] or {}
  if type(target) == "function" then
    return target(bufnr)
  else
    return target
  end
end

---@return LangTables
return LangTables
-- (LangTables, LangTables)
