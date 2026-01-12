return {
  -- nvim port of Matt Pocock's ts-error-translator
  "dmmulroy/ts-error-translator.nvim",
  lazy = true,
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  opts = {
    auto_attach = true,
    -- LSP server names to translate diagnostics for (default shown below)
    servers = {
      "astro",
      "svelte",
      "ts_ls",
      -- "tsserver", -- deprecated, use ts_ls
      "typescript-tools",
      "volar",
      "vtsls",
    },
  },
}
