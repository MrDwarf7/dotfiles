local ufo = require("ufo")
local map = vim.keymap.set

ufo.setup({
    provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
    end,
    map('n', 'zR', require('ufo').openAllFolds),
    map('n', 'zM', require('ufo').closeAllFolds),
})
