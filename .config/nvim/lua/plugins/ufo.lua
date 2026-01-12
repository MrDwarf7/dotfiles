return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  event = "LspAttach",
  keys = {
    -- stylua: ignore start
    { "zR", function() require("ufo").openAllFolds() end,         desc = "UFO: Open All Folds" },
    { "zM", function() require("ufo").closeAllFolds() end,        desc = "UFO: Close All Folds" },
    { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "UFO: Open Folds Except Kinds" },
    { "zm", function() require("ufo").closeFoldsWith() end,       desc = "UFO: Close Folds With" },
    -- stylua: ignore end
  },
  opts = {},
}
