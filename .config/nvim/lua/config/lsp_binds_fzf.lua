---@class config.BIND.fzf
---@field setup fun(): nil Handles keymaps for the 'builtin' binds type.
local B = {}

function B.setup()
  local map = vim.keymap.set

  map("n", "gd", function()
    require("fzf-lua").lsp_definitions({ jump1 = true, ignore_current_line = true })
  end, { desc = "[G]oto [d]efinition" })
  map("n", "gD", function()
    require("fzf-lua").lsp_declarations({ jump1 = true, ignore_current_line = true })
  end, { desc = "Goto T[y]pe Definition" })
  map("n", "gr", function()
    require("fzf-lua").lsp_references({ jump1 = true, ignore_current_line = true })
  end, { desc = "[G]oto [r]eferences" })
  map("n", "gt", function()
    require("fzf-lua").lsp_typedefs({ jump1 = true, ignore_current_line = true })
  end, { desc = "Goto T[y]pe Definition" })
  map("n", "gi", function()
    require("fzf-lua").lsp_implementations({ jump1 = true, ignore_current_line = true })
  end, { desc = "[G]oto [I]mpl" })
end

---@return config.BIND.fzf
return B
