local lang_tables = require("lang_tables")

-- NOTE:
-- If we call `opts = {}` in any of the dependencies arrays,
-- we incur a significant startup time increase.
-- I assume this is because lazy.nvim registers all entries in a metatable,
-- and then (even if empty) merges them via vim.tbl_deep_extend when the plugin is loaded.
-- tl;dr: Don't put opts = {} in the dependencies array if you're also setting it up elsewhere.

return {
  -- Primary handling of installs and such here,
  --
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      { "mason-org/mason.nvim", lazy = true },
      { "mason-org/mason-lspconfig.nvim", lazy = true },
    },

    -- I don't really udnerstand why this works, but it does and helps
    -- with startup time a bit.
    -- init = function()
    --   vim.defer_fn(function() end, 2)
    -- end,

    ---@param _ any : cached deps/metatable etc.
    opts = function(_)
      return {
        ensure_installed = lang_tables.mason_all(),
        auto_update = true,
        run_on_start = true,
        start_delay = 3000,
        de_bounce_hours = 10, -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce. Used only if run_on_start is true.

        -- interop for naming conventions between tools
        integrations = {
          ["mason-lspconfig"] = true,
          ["mason-null-ls"] = true,
          ["mason-nvim-dap"] = false,
        },
      }
    end,
  },

  {
    "mason-org/mason.nvim",
    keys = {
      {
        "<Leader>pm",
        function()
          vim.cmd("Mason")
        end,
        desc = "Mason",
      },
    },
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", lazy = true },
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      -- ensure_installed = lang_tables.mason_ensure_installed()
    },
    -- don't do this here as-per the comment at top of file
  },
}
