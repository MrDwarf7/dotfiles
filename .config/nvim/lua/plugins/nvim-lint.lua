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
    events = { "BufWritePost", "BufReadPost", "InsertLeave" }, -- ours

    linters_by_ft = {
      ["bash"] = { "shellcheck" },
      ["cmake"] = { "cmakelint" },
      ["cpp"] = { "cpplint" },
      ["css"] = { "stylelint" },
      ["docker"] = { "hadolint" },
      ["fish"] = { "fish" },
      ["hpp"] = { "cpplint" },
      ["javascript"] = { "biomejs" },
      ["javascriptreact"] = { "biomejs" },
      ["json"] = { "jsonlint" },
      ["odin"] = { "ols" },
      ["python"] = { "ruff" },
      ["sh"] = { "shellcheck" },
      ["sql"] = { "sqlfluff" },
      ["typescript"] = { "biomejs" },
      ["typescriptreact"] = { "biomejs" },
      ["vim"] = { "vint" },

      -- ["c"] = { "clang-tidy" },
      -- ["h"] = { "clang-tidy" },
      -- ["lua"] = { "luacheck" },
      -- ["rust"] = { "rust_analyzer" },
      -- ["yaml"] = { "yamllint" },
      -- cs = { "omnisharp" },
      -- markdown = { "markdownlint-cli2" },
      -- powershell = { "powershell_es" },
      -- python = { "ruff", "mypy", "vulture" },
      -- python = { "ruff_lsp", "mypy", "vulture", { "ruff_lsp" } },
    },
  },

  ---@param opts? lint.Config|nil
  config = function(_, opts)
    -- local lang_table_linters = require("lang_tables").by_ft("force", "linters", {})
    -- if not lang_table_linters then
    --   lang_table_linters = {}
    -- end
    -- require("lint").linters_by_ft = lang_table_linters or {}

    -- opts = opts
    --   or (function() -- closure
    --     require("utils").output.warn("No options provided for nvim-lint, using empty config")
    --     return {}
    --   end)()
    --
    -- local lint_obj = require("lint") ---@type lint.Config
    --
    -- lint_obj.linters_by_ft = opts.linters_by_ft or {}
    --
    -- return lint_obj

    opts = opts or {}
    opts.linters = opts.linters or {}
    opts.events = opts.events or { "BufWritePost", "BufReadPost", "InsertLeave" }

    local mod = {}
    local lint = require("lint")

    local list_prepend = function(dst, src)
      for i = 1, #src do
        table.insert(dst, i, src[i])
      end
    end

    for name, linter in pairs(opts.linters) do
      if type(linter) == "table" and type(lint.linters[name]) == "table" then
        lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
        if type(linter.prepend_args) == "table" then
          lint.linters[name].args = lint.linters[name].args or {}
          list_prepend(lint.linters[name].args, linter.prepend_args)
        end
      else
        lint.linters[name] = linter
      end
    end

    lint.linters_by_ft = opts.linters_by_ft or {}

    function mod.debounce(ms, fn)
      local timr = vim.uv.new_timer()
      if not timr then
        error("Failed to create timer for debounce")
      end
      return function(...)
        local argv = { ... }
        timr:start(ms, 0, function()
          timr:stop()
          vim.schedule_wrap(fn)(unpack(argv))
        end)
      end
    end

    function mod.lint()
      local names = lint._resolve_linter_by_ft(vim.bo.filetype)
      names = vim.list_extend({}, names)

      if #names == 0 then
        vim.list_extend(names, lint.linters_by_ft["_"] or {})
      end

      vim.list_extend(names, lint.linters_by_ft["*"] or {})

      local ctx = { filename = vim.api.nvim_buf_get_name(0) }
      ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
      names = vim.tbl_filter(function(name)
        local linter = lint.linters[name]
        if not linter then
          require("utils").output.warn("Linter " .. name .. " not found for filetype " .. vim.bo.filetype)
        end
        return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
      end, names)

      if #names > 0 then
        lint.try_lint(names)
      end
    end

    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = mod.debounce(100, mod.lint),
    })
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
