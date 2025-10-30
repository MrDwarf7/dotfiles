---@type LazyPluginBase
return {
	"HawkinsT/pathfinder.nvim", -- Enhances the gf, gF, and gx commands
	lazy = true,
  -- stylua: ignore start
  ---@type LazyKeys
  keys = {
    { "gf",         function() return require("pathfinder").gf() end,               desc = "P. gf" },
    { "gF",         function() return require("pathfinder").gF() end,               desc = "P. gF" },
    { "gx",         function() return require("pathfinder").gx() end,               desc = "P. gx" },

    { "]f",         function() return require("pathfinder").next_file() end,        desc = "Jump to next valid file name" },
    { "[f",         function() return require("pathfinder").prev_file() end,        desc = "Jump to previous valid file name" },
    { "]u",         function() return require("pathfinder").next_url() end,         desc = "Jump to next valid URL" },
    { "[u",         function() return require("pathfinder").prev_url() end,         desc = "Jump to previous valid URL" },

    { "<Leader>gf", function() return require("pathfinder").select_file() end,      desc = "P. Visual File Selection" },
    { "<Leader>gF", function() return require("pathfinder").select_file_line() end, desc = "P. Visual file selection (line)" },
    { "<Leader>gx", function() return require("pathfinder").select_url() end,       desc = "P. Visual URL/Git repository selection" },
  },
	-- stylua: ignore end
	opts = {},
}
