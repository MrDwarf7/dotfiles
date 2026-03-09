---@class config.BIND.snacks
---@field setup fun(): nil Handles keymaps for the 'builtin' binds type.
local B = {}

function B.setup()
  local Snacks = require("snacks")

  local opts = {
    --
    auto_confirm = true,
    show_delay = 0,
    jump = {
      tagstack = true,
      reuse_win = false,
    },
    jump1 = true,
  }

  local map = vim.keymap.set
  -- stylua: ignore start
  map("n", "gd", function() Snacks.picker.lsp_definitions(opts) end, { desc = "Snacks Goto Definition" })
  map("n", "gD", function() Snacks.picker.lsp_declarations(opts) end, { desc = "Snacks Goto Declaration" })
  map("n", "gr", function() Snacks.picker.lsp_references(opts) end, { nowait = true, desc = "Snacks References" })
  map("n", "gi", function() Snacks.picker.lsp_implementations(opts) end, { desc = "Snacks Goto Implementation" })
  map("n", "gt", function() Snacks.picker.lsp_type_definitions(opts) end,{ desc = "Snacks Goto T[y]pe Definition" })
  map("n", "gai", function() Snacks.picker.lsp_incoming_calls(opts) end, { desc = "Snacks C[a]lls Incoming" })
  map("n", "gao", function() Snacks.picker.lsp_outgoing_calls(opts) end, { desc = "Snacks C[a]lls Outgoing" })
  map("n", "<Leader>ls", function() Snacks.picker.lsp_symbols(opts) end, { desc = "Snacks LSP Symbols" })
  map("n", "<Leader>lS", function() Snacks.picker.lsp_workspace_symbols(opts) end, { desc = "Snacks LSP Workspace Symbols" })
  map("n", "<Leader>l`", function() Snacks.picker.lsp_config(opts) end, { desc = "Snacks Pulls up the capabilities of various LSP servers" })

  map("n", "]]", function()
    local tsutils = require("utils.tsutils")
    local cnext_op = function() vim.cmd("cnext") end
    tsutils.handle_builtins({ operation = cnext_op })
  end, { silent = true, desc = "qf next" })

  map("n", "[[", function()
    local tsutils = require("utils.tsutils")
    local cprev_op = function() vim.cmd("cprev") end
    tsutils.handle_builtins({ operation = cprev_op })
  end, { silent = true, desc = "qf prev" })

  -- stylua: ignore end
end

---@return config.BIND.fzf
return B
