return {
  "stevearc/quicker.nvim",
  ft = "qf",
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {
    --
    -- TODO: Set this up

    opts = {
      buflisted = false,
      number = true,
      relativenumber = true,
      signcolumn = "auto",
      winfixheight = true,
      wrap = false,
    },

    -- use_default_opts = true,
    keys = {
      {
        ">",
        function()
          require("quicker").expand()
        end,
        desc = "Expand item",
      },

      {
        "<",
        function()
          require("quicker").collapse()
        end,
        desc = "Collapse item",
      },

      {
        "<C-r>",
        function()
          require("quicker").refresh()
        end,
        desc = "Refresh items",
      },
    },

    constrain_cursor = true, -- default, probs change
    highlight = {
      -- Use treesitter highlighting
      treesitter = true,
      -- Use LSP semantic token highlighting
      lsp = true,
      -- Load the referenced buffers to apply more accurate highlights (may be slow)
      load_buffers = false,
    },

    follow = {
      -- When quickfix window is open, scroll to closest item to the cursor
      enabled = false,
    },
  },
}
