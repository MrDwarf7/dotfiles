---@type LazyPluginBase
return {
  -- In-Editor preview rendering for Typst files
  "chomosuke/typst-preview.nvim",
  lazy = true, -- or ft = 'typst'
  ft = "typst",
  version = "1.*",
  opts = {}, -- lazy.nvim will implicitly calls `setup {}`
}
