---@class config.BIND.builtin
---@field setup fun(): nil Handles keymaps for the 'builtin' binds type.
local B = {}

function B.setup()
  local map = require("config.keymaps")
  local tsutils = require("utils.tsutils")
  local handle_builtins = tsutils.handle_builtins

  -- stylua: ignore start
  -- map("n", "gd", function() handle_builtins({ method = "textDocument/definition" }) end,
  map("n", "gd", function() handle_builtins({ operation = vim.lsp.buf.definition }) end,
    { desc = "[G]oto [d]efinition" })

  -- map("n", "gD", function() handle_builtins({ method = "textDocument/declaration" }) end,
  map("n", "gD", function() handle_builtins({ operation = vim.lsp.buf.declaration }) end,
    { desc = "[G]oto [D]eclaration" })

  -- map("n", "gr", function() handle_builtins({ method = "textDocument/references" }) end,
  map("n", "gr", function() handle_builtins({ operation = vim.lsp.buf.references }) end,
    { desc = "[G]oto [r]eferences" })

  -- map("n", "gt", function() handle_builtins({ method = "textDocument/typeDefinition" }) end,
  map("n", "gt", function()
      handle_builtins({ operation = vim.lsp.buf.type_definition })
    end,
    { desc = "[G]oto [t]ype Definition" })

  map("n", "gi", function() handle_builtins({ operation = vim.lsp.buf.implementation }) end,
    { desc = "[G]oto [I]mpl" })

  map("n", "]]", function()
    local cnext_op = function() vim.cmd("cnext") end
    tsutils.handle_builtins({ operation = cnext_op })
  end, { silent = true, desc = "qf next" })

  map("n", "[[", function()
    local cprev_op = function() vim.cmd("cprev") end
    tsutils.handle_builtins({ operation = cprev_op })
  end, { silent = true, desc = "qf prev" })
  -- stylua: ignore end
end

---@return config.BIND.builtin
return B
