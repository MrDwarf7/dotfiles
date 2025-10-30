---@type LazyPluginBase
return {
  "NvChad/nvim-colorizer.lua",
  lazy = true,
  ---@type LazyEventSpec
  event = "LspAttach",
  ft = {
    "css",
    "html",
    "javascript",
    "lua",
    "markdown",
    "scss",
    "txt",
    "vim",
    "yaml",
    "json",
    "typescript",
    "typescriptreact",
    "javascriptreact",
    "norg",
    "org",
    "pandoc",
  },
  opts = {
    -- user_default_options = {
    -- 	tailwind = "both",
    -- 	css = true,
    -- 	css_fn = true,
    -- 	names = false,
    -- },
  },
}
