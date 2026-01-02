---@class GhActionsLsp.Config
---@field session_token? string The name of the environment variable that contains the GitHub session token.
---@field workspace_path? string|nil The path to the workspace directory. If nil, a default path will be used.
---@field fallback_org? string|nil The fallback GitHub organization to use if none is specified in the repository.

return {
  "tamerlang/gh-actions-lsp.nvim",
  -- lazy = true,
  -- event = "VeryLazy",
  ---@type GhActionsLsp.Config
  opts = {
    -- This token requires the environment variable GH_TOKEN to be set.
    -- You can get this using the `github-cli` (or `gh-cli`) tool, and running:
    -- `gh auth token`
    --
    -- Checking via:
    -- `env | rg -i 'GH_TOKEN'`
    session_token = "GH_TOKEN",
  },
}
