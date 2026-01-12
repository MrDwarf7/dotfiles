local invoke = function()
  local grug = require("grug-far")
  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
  grug.open({
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
    },
  })
end

return {
  "MagicDuck/grug-far.nvim",
  lazy = true,
  keys = {
    -- stylua: ignore start
    { "<Leader>f/", function() invoke() end, mode = { "n", "v" }, desc = "Search & Replace" },
    { "<Leader>lp", function() invoke() end, mode = { "n", "v" }, desc = "Search & Replace" },
    { "<Leader>fs", function() invoke() end, mode = { "n", "v" }, desc = "Search & Replace" },
    -- stylua: ignore end
  },
}
