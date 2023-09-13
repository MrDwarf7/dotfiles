return {
  -- {
  --   "tiagovla/tokyodark.nvim",
  --   opts = {
  --     transparent_background = true,
  --     gamma = 1.2,
  --     -- custom options here
  --   },
  --   config = function(_, opts)
  --     require("tokyodark").setup(opts) -- calling setup is optional
  --     vim.cmd([[colorscheme tokyodark]])
  --   end,
  -- },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("catppuccin").setup({
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.15,
        },
        transparent_background = false, --TEMP:
        show_end_of_buffer = true,
        -- color_overrides = {
        -- }
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
      background_colour = "#000000",
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
    },
    init = function()
      vim.notify = require("notify")
    end,
  },

  {
    "echasnovski/mini.bufremove",
  -- stylua: ignore
  keys = {
    { "<leader>c", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
    { "<leader>x", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
  },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufRead", "BufNewFile" },
    opts = {
      show_trailing_blankline_indent = true,
      show_current_context = true,
      show_current_context_start = true,
    },
  },
}
