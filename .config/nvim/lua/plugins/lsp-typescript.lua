--
--   typescript-tools is unmaintained (last commit ~Nov 2025) and it only speaks
--   tsserver.js. TypeScript 7 does not ship that file.
--
--   Next time this breaks, do not keep patching it:
--     TS 4 / 5  -> vtsls. It tracks the VS Code extension and can use the
--                  workspace TypeScript (`vtsls.autoUseWorkspaceTsdk`).
--     TS 7      -> `tsc --lsp` (lspconfig name `tsc`). Not vtsls.
--   One of those per buffer. This plugin, vtsls, and tsc all attach to the
--   same filetypes, so enabling a second one brings the doubled `gd` list back.
--

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
    "nvim-lspconfig", -- ----------------- lazy = true
  },
  ft = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts or {}, {
      settings = {
        -- Default true starts a second tsserver and sends hover/definition to the
        -- other one, which answers quickinfo with nothing ("No information available").
        separate_diagnostic_server = false,
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
  end,
  config = function(_, opts)
    opts = opts or {}

    -- if there's a deno.json or deno.jsonc in the root, we return nothing (aka don't set up the plugin)

    if require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")(vim.api.nvim_buf_get_name(0)) then
      return
    end

    require("typescript-tools").setup(opts)
  end,
}
