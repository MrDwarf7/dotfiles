local lang_tables = require("lang_tables")

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  -- enabled = false,
  lazy = false, -- swap this once all your local stuff is installed/setup :)
  event = "WinLeave",
  dependencies = {
    { "mason-org/mason.nvim", lazy = true },
    { "mason-org/mason-lspconfig.nvim", lazy = true },
  },

  -- I don't really udnerstand why this works, but it does and helps
  -- with startup time a bit.
  init = function()
    vim.defer_fn(function() end, 2)
  end,

  config = function(_, opts)
    if package.loaded["mason-tool-installer"] then
      return
    end

    opts = vim.tbl_deep_extend("force", {}, opts or {}, {
      -- Can handle everything that's listed in mason pop-ups.
      ensure_installed = lang_tables.mason_ensure_installed(),
    })

    -- vim.defer_fn(function()
    if not package.loaded["mason-tool-installer"] then
      require("mason-tool-installer").setup(opts)
    end
  end,
}
