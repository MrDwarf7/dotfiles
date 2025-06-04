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
  "grug-far.nvim",
  keys = {
    {
      "<Leader>lp",
      function()
        invoke()
      end,
      mode = { "n", "v" },
      desc = "Search & Replace",
    },
    {
      "<Leader>fs",
      function()
        invoke()
      end,
      mode = { "n", "v" },
      desc = "Search & Replace",
    },
  },
}
