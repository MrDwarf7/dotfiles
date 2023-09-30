return {
  function()
    if vim.g.vscode then
      require("lazyvim.plugins.extras.vscode")
      local opts = {
        disabled = {
          "catppuccino.nvim",
          "gzip",
          "matchit",
          "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      }
      return opts
    end
  end,
}
