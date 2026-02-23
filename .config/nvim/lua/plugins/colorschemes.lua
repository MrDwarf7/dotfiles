---@class tokyonight.Config.styles.Opts : vim.api.keyset.highlight

---@class tokyonight.Config.styles
---@field comments tokyonight.Config.styles.Opts
---@field functions tokyonight.Config.styles.Opts
---table
---@field variables tokyonight.Config.styles.Opts
---@field keywords tokyonight.Config.styles.Opts
---
---@field sidebars "dark" | "transparent" | "normal"
---@field floats "dark" | "transparent" | "normal"

-- ---@type LazyPluginBase[]
return {
  ---@type LazyPluginBase
  {
    "rose-pine/neovim",
    enabled = false,
    name = "rose-pine",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("rose-pine")
    end,
  },
  ---@type LazyPluginBase
  {
    "zenbones-theme/zenbones.nvim",
    enabled = false,
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    config = function()
      --     vim.g.zenbones_darken_comments = 45
      -- vim.cmd.colorscheme('zenbones')
      vim.cmd.colorscheme("rosebones")
    end,
  },
  ---@type LazyPluginBase
  {
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    -- ---@type fun(): tokyonight.Config

    ---@type tokyonight.Config
    ---@type tokyonight.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      -- style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      -- debating.....
      transparent = true, -- Enable this to disable setting the background color
      terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
      ---@type tokyonight.Config.styles
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
        -- floats = "dark", -- style for floating windows
      },
      sidebars = { "qf", "help", "nvimtree" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = false, -- dims inactive windows
      lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

      cache = true,

      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      ----@param colors ColorScheme
      -- on_colors = function(colors) end,

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ----@param highlights Highlights
      ----@param colors ColorScheme
      -- on_highlights = function(highlights, colors) end,

      ---@type table<string, boolean|{enabled:boolean}>
      plugins = {
        all = package.loaded.lazy == nil,
        auto = true,
      },
    },

    ---@param _ LazyPluginBase
    ---@param opts tokyonight.Config
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-" .. opts.style)
      return opts
    end,

    -- config = function(_, opts)
    -- 	vim.cmd.colorscheme("tokyonight-" .. opts.style)
    -- 	-- require("tokyonight").setup(opts)
    -- 	return opts
    -- end,
  },
}
