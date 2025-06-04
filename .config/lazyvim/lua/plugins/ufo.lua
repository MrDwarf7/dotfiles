return {
  "kevinhwang91/nvim-ufo",
  lazy = true,
  event = "VeryLazy",
  -- event = "BufReadPost",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  -- stylua: ignore start
  keys = {
    { "zR", function() return require("ufo").openAllFolds() end, },
    { "zM", function() return require("ufo").closeAllFolds() end, },
  },
  -- stylua: ignore end
  opts = {
    provider_selector = function(bufnr, filetype, buftype)
      return { "treesitter", "indent" }
    end,
  },
}
