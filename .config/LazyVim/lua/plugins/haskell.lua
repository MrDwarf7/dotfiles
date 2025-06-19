-- local ht = require("haskell-tools")
-- local bufnr = vim.api.nvim_get_current_buf()
-- local opts = { noremap = true, silent = true, buffer = bufnr }
--
-- local map = function(keys, fn, opts)
--   vim.keymap.set("n", keys, fn, opts)
-- end

return {
  "haskell-tools.nvim",
  version = "^5",
  lazy = true,
  ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  dependencies = {
    { "nvim-telescope/telescope.nvim", optional = true },
  },
  -- opts = {}
}
