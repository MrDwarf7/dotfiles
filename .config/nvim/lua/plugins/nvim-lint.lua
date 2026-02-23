---@class lint.Config Because nvim-lint doesn't export a proper tyep.
---@field get_namespace function
---@field get_running function
---@field lint function
---@field linters table<string, fun():lint.Linter|lint.Linter>
---@field linters_by_ft table<string, string[]>
---@field try_lint function
---@field _resolve_linter_by_ft function

return {
  "mfussenegger/nvim-lint",
  lazy = true,
  ---@type LazyEventSpec
  event = "BufReadPost",
  ---@return lint.Config
  opts = {
    linters_by_ft = require("lang_tables").by_ft("force", "linters", {}) or {},
  },

  ---@param opts? lint.Config|nil
  config = function(opts)
    -- local lang_table_linters = require("lang_tables").by_ft("force", "linters", {})
    -- if not lang_table_linters then
    --   lang_table_linters = {}
    -- end
    -- require("lint").linters_by_ft = lang_table_linters or {}

    opts = opts
      or (function() -- closure
        require("utils").output.warn("No options provided for nvim-lint, using empty config")
        return {}
      end)()

    local lint_obj = require("lint") ---@type lint.Config

    lint_obj.linters_by_ft = opts.linters_by_ft or {}

    return lint_obj
  end,
}

-- -- we test rest of things first, then uncomment this
-- TODO: uncomment later

-- return {
-- 	"mfussenegger/nvim-lint",
-- 	opts = {
-- 		linters_by_ft = {
-- 			fish = { "fish" },
-- 			cpp = { "cpplint" },
-- 			css = { "stylelint" },
-- 			cmake = { "cmakelint " },
-- 			-- cs = { "omnisharp" },
-- 			docker = { "hadolint" },
-- 			javascript = { "biomejs" },
-- 			javascriptreact = { "biomejs" },
-- 			json = { "jsonlint" },
-- 			-- markdown = { "markdownlint-cli2" },
-- 			-- lua = { "luacheck" },
-- 			-- powershell = { "powershell_es" },
-- 			-- python = { "ruff_lsp", "mypy", "vulture", { "ruff_lsp" } },
-- 			-- python = { "ruff", "mypy", "vulture" },
-- 			python = { "ruff", "vulture" },
-- 			sh = { "shellcheck" },
-- 			sql = { "sqlfluff" },
-- 			typescript = { "biomejs" },
-- 			typescriptreact = { "biomejs" },
-- 			vim = { "vint" },
-- 			yaml = { "yamllint" },
-- 		},
-- 	},
-- }
