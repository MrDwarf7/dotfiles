return {
  "mfussenegger/nvim-lint",
  lazy = true,
  ---@type LazyEventSpec
  event = "BufReadPost",
  config = function()
    local lang_table_linters = require("lang_tables").by_ft("force", "linters", {})
    -- if not lang_table_linters then
    --   lang_table_linters = {}
    -- end
    require("lint").linters_by_ft = lang_table_linters or {}
    -- vim.tbl_deep_extend("force",
    -- lang_tables.by_ft(
    --   "force",
    --     "linters",
    --   {},
    --   -- "linters",
    --   -- vim.bo.filetype,
    --   -- vim.api.nvim_get_current_buf() or 0
    -- ), {
    --   -- Linter overrides can be set here
    -- })
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
