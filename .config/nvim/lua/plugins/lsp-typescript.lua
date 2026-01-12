--- TSServer capabilities
---@param opts? table
---@param capabilities? table
---@return table|lsp.ClientCapabilities?
local function tsserv_cap(opts, capabilities)
  opts = opts or {}
  capabilities = capabilities or vim.lsp.protocol.make_client_capabilities()

  return vim.tbl_deep_extend("force", capabilities, opts, {
    includeCompletionsForImportStatements = true,
    includeCompletionsWithSnippetText = true,
    useLabelDetailsInCompletionEntries = true,

    -- Params
    includeInlayParameterNameHints = "all",
    includeInlayParameterNameHintsWhenArgumentMatchesName = true,

    -- Functions
    includeInlayFunctionParameterTypeHints = true,
    includeInlayFunctionLikeReturnTypeHints = true,
    -- Variables
    includeInlayVariableTypeHints = true,
    includeInlayVariableTypeHintsWhenTypeMatchesName = true,
    -- Properties
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayEnumMemberValueHints = true,

    quotePreference = "double",
  })
end

return {
  "pmizio/typescript-tools.nvim",
  -- lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-lspconfig",
  },
  ft = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
  opts = function(_, opts)
    opts = opts or {}
    opts = vim.tbl_deep_extend("force", opts, {
      settings = {
        capabilities = tsserv_cap(opts),
        -- capabilities,
        root_dir = {
          root = { "package.json " },
          exclude = { "deno.json", "deno.jsonc" },
        },
        single_file_support = false,
        tsserver_file_preferences = tsserv_cap(opts),
        tsserver_plugins = {
          "@types/node",
          "@types/react",
          "@types/react-dom",
          "@types/w3c-web-serial",
          "@types/web-bluetooth",
          "@typescript-eslint/eslint-plugin",
          "@typescript-eslint/parser",
        },
      },
    })
    return opts
  end,
  config = function(_, opts)
    opts = opts or {}
    require("typescript-tools").setup(opts)
  end,
}
