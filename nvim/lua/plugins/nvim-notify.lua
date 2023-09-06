return {
   {
      "rcarriga/nvim-notify",
      opts = {},
      config = function()
         -- vim.notify = require("notify")
     require("notify").setup({
  background_colour = "#80a0ff",
})
      end,
   },
}
