local queries = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/queries"
vim.opt.runtimepath:append(queries)

return {
  "nvim-treesitter",
  opts = {
    highlight = { enable = true },
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "c_sharp",
      "cmake",
      "css",
      "embedded_template",
      "gitattributes",
      "gitcommit",
      "git_config",
      "gitignore",
      "git_rebase",
      "go",
      "html",
      "javascript",
      "just",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "meson",
      "python",
      "regex",
      "rust",
      "scss",
      -- "surrealdb",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
    },
    incremental_selection = {
      enable = false,
    },
    indent = {
      disable = {
        "html",
        "javascript",
        "typescript",
        "css",
        "rust",
      },
      -- disable = function(lang, buf)
      --   local indent_disabled = {
      --     "html",
      --     "javascript",
      --     "typescript",
      --     "css",
      --     "rust",
      --   }
      --   if lang == vim.tbl_keys(indent_disabled) then
      --     return true
      --   end
      -- end,
      enable = true,
    },
    autotag = {
      enable = true,
    },
    -- sync_install = true,
    -- auto_install = true,
  },
}
