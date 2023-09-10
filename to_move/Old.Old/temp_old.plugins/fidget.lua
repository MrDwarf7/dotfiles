return {
   "j-hui/fidget.nvim",
   branch = "legacy",
   config = function()
      require('fidget').setup({
         text = {
            spinner = "meter"
         },
         window = { 
            blend = 0, -- value 100 is fully transparent.
            -- zindex  ---- Disable for now till I know what the range() is for this.
         }, 
      })
   end
}
