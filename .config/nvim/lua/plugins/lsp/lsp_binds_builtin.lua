---@class config.BIND.builtin
---@field setup fun(): nil Handles keymaps for the 'builtin' binds type.
local B = {}

function B.setup()
  -- local map = require("config.keymaps")
  local map = vim.keymap.set
  local tsutils = require("utils.tsutils")
  local handle_builtins = tsutils.handle_builtins

  -- stylua: ignore start
  -- on_list is the supported hook. Neovim has already merged every client.
  -- unique_locations drops the same file+range. It does not drop a different declaration.
  local jump = tsutils.location_jump
  -- map("n", "gd", function() handle_builtins({ method = "textDocument/definition" }) end,
  map("n", "gd", jump(vim.lsp.buf.definition), { desc = "[G]oto [d]efinition" })

  -- map("n", "gD", function() handle_builtins({ method = "textDocument/declaration" }) end,
  map("n", "gD", jump(vim.lsp.buf.declaration), { desc = "[G]oto [D]eclaration" })

  -- map("n", "gr", function() handle_builtins({ method = "textDocument/references" }) end,
  map("n", "gr", function()
    vim.lsp.buf.references(nil, {
      on_list = function(options)
        tsutils.locations_on_list(options)
      end,
    })
  end, { desc = "[G]oto [r]eferences" })

  -- map("n", "gt", function() handle_builtins({ method = "textDocument/typeDefinition" }) end,
  map("n", "gt", jump(vim.lsp.buf.type_definition), { desc = "[G]oto [t]ype Definition" })

  map("n", "gi", jump(vim.lsp.buf.implementation), { desc = "[G]oto [I]mpl" })

  -- TODO: [URGENT] : Clean this up - we want to go through a SINGULAR
  -- system for accessing anything to do with `]]` or `[[`
  -- !!!!!!!!!!

  -- map("n", "]]", function()
  --   local cnext_op = function() vim.cmd("cnext") end
  --   tsutils.handle_builtins({ operation = cnext_op })
  -- end, { silent = true, desc = "qf next" })
  --
  -- map("n", "[[", function()
  --   local cprev_op = function() vim.cmd("cprev") end
  --   tsutils.handle_builtins({ operation = cprev_op })
  -- end, { silent = true, desc = "qf prev" })

  -- stylua: ignore end
end

setmetatable(B, {
  __index = function(_, k)
    error("Key " .. tostring(k) .. " not found in config.BIND.builtin")
  end,
})

---@return config.BIND.builtin
return B
