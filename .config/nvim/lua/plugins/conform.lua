return {
  "stevearc/conform.nvim",
  ---@type LazyEventSpec|string
  event = { "LspAttach", "BufReadPost" },
  lazy = true,
  -- lazy = false,

  keys = {
    {
      "<Leader>lf",
      function()
        print("conform format")
        local conform = require("conform")
        conform.format({
          -- formatters = { "injected" },
          timeout_ms = 3000,
        })
      end,
      mode = { "n", "v" },
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
      async = true,
      quiet = false,
      lsp_format = "fallback",
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
    formatters_by_ft = require("lang_tables").by_ft("force", "formatters", {}),
    notify_on_error = false,
  }),
}
