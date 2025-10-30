return {
  "L3MON4D3/LuaSnip",
  lazy = true,
  -- event = "VeryLazy",
  -- event = "BufEnter",
  event = "InsertEnter",
  setup = function()
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
