return {
  "stevearc/conform.nvim",
  ---@type LazyEventSpec|string
  event = { "LspAttach", "BufReadPost" },
  lazy = true,
  dependencies = { "mason-org/mason.nvim" },
  cmd = "COnformInfo",
  keys = {
    {
      "<Leader>lf",
      function()
        require("conform").format({
          formatters = { "injected" },
          timeout_ms = 3000,
        })
      end,
      mode = { "n", "v", "x" },
      desc = "Format Injected Langs",
    },
  },

  ---@type conform.setupOpts
  opts = vim.tbl_deep_extend("force", {}, {
    ---@type conform.FormatOpts|fun(bufnr: integer):conform.FormatOpts|nil
    format_on_save = {
      timeout_ms = 1000,
      lsp_format = "fallback",
    },

    default_format_opts = {
      timeout_ms = 3000,
      -- async = false,
      -- async = true,
      async = false,
      quiet = false,
      lsp_format = "fallback",
    },

    -- formatters_by_ft = require("lang_tables").by_ft("force", "formatters", {}),
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

    ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer):conform.FormatterConfigOverride|nil>
    formatters = {
      injected = { options = { ignore_errors = true } },
      ["markdown-toc"] = {
        condition = function(_, ctx)
          for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
            if line:find("<!%-%- toc %-%->") then
              return true
            end
          end
          return false
        end,
      },
      yamlfmt = {
        inherit = true,
        options = {
          line_ending = "lf",
          formatter = {
            type = "basic",
            include_document_start = false,
            line_ending = "lf",
            retain_line_breaks = true,
            retain_line_breaks_single = true,
            pad_line_comments = 1,
          },
        },
      },
      odinfmt = {
        command = "odinfmt",
        args = { "-stdin" },
        stdin = true,
        inherit = true,
      },
    },
    notify_on_error = false,
  }),
}
