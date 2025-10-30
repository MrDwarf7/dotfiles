-- ---@type LazyPluginBase[]
---@type LazyPluginBase
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
  ---@type LazyKeys
  keys = {
    {
      "<Leader>tm",
      function()
        local get = function()
          return require("render-markdown.state").enabled
        end

        local set = function(enabled)
          local m = require("render-markdown")
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end

        return set(not get())
      end,
      { desc = "Toggle markdown" },
    },
  },

  ---@type render.md.UserConfig
  opts = {
    code = {
      sign = false,
      width = "block",
      right_pad = 1,
    },
    heading = {
      sign = false,
      icons = {},
    },
    checkbox = {
      enabled = false,
    },
  },
}

-- ---@type LazyPluginBase
-- {
-- 	"iamcco/markdown-preview.nvim",
-- 	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
-- 	build = function()
-- 		require("lazy").load({ plugins = { "markdown-preview.nvim" } })
-- 		vim.fn["mkdp#util#install"]()
-- 	end,
-- 	---@type LazyKeys
-- 	keys = {
-- 		{
-- 			"<Leader>tM",
-- 			ft = "markdown",
-- 			"<cmd>MarkdownPreviewToggle<cr>",
-- 			desc = "Markdown Preview",
-- 		},
-- 	},
-- 	opts = {},
-- 	config = function()
-- 		vim.cmd([[do FileType]])
-- 	end,
-- },
-- { "markdown-preview.nvim" },
-- }
