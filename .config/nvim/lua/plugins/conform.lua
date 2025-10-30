local lang_tables = require("lang_tables")
return {
  "stevearc/conform.nvim",
  event = "LspAttach",
  -- lazy = false,
  keys = {
    {
      "<Leader>lf",
      function()
        if
          vim.g.autofmrat == nil
          or vim.g.autoformat == false
          or vim.b.autoformat == nil
          or vim.b.autoformat == false
        then
          vim.lsp.buf.format({ async = false })
        else
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts or {}, {

      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "fallback",
      },

      default_format_opts = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },

      formatters = {
        injected = { options = { ignore_errors = true } },
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find("<!%-%- toc %-%->") then
                return true
              end
            end
          end,
        },
      },
      formatters_by_ft = vim.tbl_deep_extend(
        "force",
        lang_tables.by_ft("formatters", vim.bo.filetype, vim.api.nvim_get_current_buf() or 0),
        {
          -- Default formatters can be set here
        }
      ),
      -- },
      -- formatters_by_ft = {
      --   cpp = { "clang-format" },
      --   gleam = { "gleam" },
      --   javascript = { "biome" },
      --   javascriptreact = { "biome" },
      --   json = { "fixjson" }, -- Cannot use "biome" here as it will break a lot of json due to trailing commas where there shouldn't be any
      --   lua = { "stylua" },
      --   python = function(bufnr)
      --     if require("conform").get_formatter_info("ruff_format", bufnr).available then
      --       return { "ruff_format" }
      --     else
      --       return { "isort", "black" }
      --     end
      --   end,
      --   ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
      --   ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
      --   -- markdown = { "prettier" },
      --   ocaml = { "ocamlformat" },
      --
      --   sh = { "shfmt" },
      --   sql = { "sql_formatter" },
      --   surql = { "sql_formatter" },
      --   bash = { "shfmt", "beautysh" },
      --   zsh = { "beautysh" },
      --   typescript = { "biome" },
      --   typescriptreact = { "biome" },
      --   yaml = { "yamlfmt" },
      --   rust = { "rustfmt" },
      -- },

      notify_on_error = false,
    })
  end,
}
