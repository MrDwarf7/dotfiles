--TODO: actually get formatter on save to work for the file types I work with (IE: python, ts/tsx, lua, powershell and batch)
--inc also the doc languages (Toml/Yaml -- Docker etc.)
return {
  "mhartington/formatter.nvim",
  lazy = false,
  config = function()
    require('formatter').setup({
      logging = false,
      filetype = {
        javascript = {
          -- prettierd
          function()
            return {
              exe = "prettierd",
              args = {vim.api.nvim_buf_get_name(0)},
              stdin = true
            }
          end
        },
        -- other formatters ...
      }
    })
  end,
}

--[[ local format_on_save = require("format-on-save") ]]
--[[ local formatters = require("format-on-save.formatters") ]]
--[[ return { ]]
--[[]]
--[[ format_on_save.setup({ ]]
--[[   exclude_path_patterns = { ]]
--[[     "/node_modules/", ]]
--[[     ".local/share/nvim/lazy", ]]
--[[ 		"/.venv", ]]
--[[ 		"/.git", ]]
--[[ 		"/.cache", ]]
--[[ 		"/__pycache__", ]]
--[[ 		"/build", ]]
--[[ 		"/dist", ]]
--[[ 	}, ]]
--[[   formatter_by_ft = { ]]
--[[     css = formatters.lsp, ]]
--[[     html = formatters.lsp, ]]
--[[     java = formatters.lsp, ]]
--[[     javascript = formatters.lsp, ]]
--[[     json = formatters.lsp, ]]
--[[     lua = formatters.lsp, ]]
--[[     markdown = formatters.prettierd, ]]
--[[     openscad = formatters.lsp, ]]
--[[     python = formatters.black, ]]
--[[     rust = formatters.lsp, ]]
--[[     scad = formatters.lsp, ]]
--[[     scss = formatters.lsp, ]]
--[[     sh = formatters.shfmt, ]]
--[[     terraform = formatters.lsp, ]]
--[[     typescript = formatters.prettierd, ]]
--[[     typescriptreact = formatters.prettierd, ]]
--[[     yaml = formatters.lsp, ]]
--[[]]
--[[     -- Add your own shell formatters: ]]
--[[     --[[ myfiletype = formatters.shell({ cmd = { "myformatter", "%" } }), ]]
--[[]]
--[[     -- Add lazy formatter that will only run when formatting: ]]
--[[     my_custom_formatter = function() ]]
--[[       if vim.api.nvim_buf_get_name(0):match("/README.md$") then ]]
--[[         return formatters.prettierd ]]
--[[       else ]]
--[[         return formatters.lsp() ]]
--[[       end ]]
--[[     end, ]]
--[[]]
--[[     -- Add custom formatter ]]
--[[     --[[ filetype1 = formatters.remove_trailing_whitespace, ]]
--[[     --[[ filetype2 = formatters.custom({ format = function(lines) ]]
--[[     --[[   return vim.tbl_map(function(line) ]]
--[[     --[[     return line:gsub("true", "false") ]]
--[[     --[[   end, lines) ]]
--[[     --[[ end}), ]]
--[[]]
--[[     -- Concatenate formatters ]]
--[[     python = { ]]
--[[       formatters.remove_trailing_whitespace, ]]
--[[       --[[ formatters.shell({ cmd = "tidy-imports" }), ]]
--[[       formatters.black, ]]
--[[       formatters.ruff, ]]
--[[     }, ]]
--[[     }, ]]
--[[]]
--[[   -- Optional: fallback formatter to use when no formatters match the current filetype ]]
--[[   fallback_formatter = { ]]
--[[     formatters.remove_trailing_whitespace, ]]
--[[     formatters.remove_trailing_newlines, ]]
--[[     formatters.prettierd, ]]
--[[   }, ]]
--[[]]
--[[   -- By default, all shell commands are prefixed with "sh -c" (see PR #3) ]]
--[[   -- To prevent that set `run_with_sh` to `false`. ]]
--[[   run_with_sh = false, ]]
--[[ }) ]]
--[[ } ]]
