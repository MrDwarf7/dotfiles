return {
  function(_, opts)
    require("nvim-treesitter.configs").setup(
      opts
    )
  end,
  opts = function(_, opts)
    opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
      "lua",
      "luadoc",
      "python",
      "javascript",
      "typescript",
      "tsx",
      "css",
      "csv",
      "dockerfile",
      "gitcommit",
      "gitignore",
      "html",
      "htmldjango",
      "sql",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    })
  end,
}
