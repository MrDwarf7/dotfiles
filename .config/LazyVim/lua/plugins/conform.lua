return {
  "conform.nvim",
  lazy = true,
  keys = {
    { "<leader>cF", false },
    {
      "<Leader>lf",
      function()
        if
          vim.g.autofmrat == nil
          or vim.g.autoformat == false
          or vim.b.autoformat == nil
          or vim.b.autoformat == false
        then
          return
        else
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
  opts = function(_, opts)
    -- vim.print(opts)

    return vim.tbl_deep_extend("force", opts or {}, {

      -- local insert_opts = {
      -- These are the defaults set by lazy anyway
      default_format_opts = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        cpp = { "clang-format" },
        cs = { "csharpier" },
        gleam = { "gleam" },
        vb = { "csharpier" },
        javascript = { "biome" },
        javascriptreact = { "biome" },
        json = { "fixjson" }, -- Cannot use "biome" here as it will break a lot of json due to trailing commas where there shouldn't be any
        lua = { "stylua" },
        -- powershell = function(formatter, bufnr)
        --   bufnr = bufnr or vim.api.nvim_get_current_buf()
        --   if require("conform").get_formatter_info(formatter, bufnr).available then
        --     return { formatter }
        --   else
        --     return { vim.lsp.buf.format({ async = true }) }
        --   end
        -- end,
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_format" }
          else
            return { "isort", "black" }
          end
        end,
        markdown = { "prettier" },

        sh = { "shfmt" },
        sql = { "sql_formatter" },
        surql = { "sql_formatter" },
        bash = { "shfmt" },
        zsh = { "beautysh" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        yaml = { "yamlfmt" },
        rust = { "rustfmt" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
      },

      notify_on_error = false,
    })
    -- table.insert(opts, insert_opts)
  end,
}
