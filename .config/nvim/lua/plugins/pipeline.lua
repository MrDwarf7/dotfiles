return {
  "topaxi/pipeline.nvim",
  keys = {
    { "<Leader>gp", "<CMD>Pipeline<CR>", desc = "Open pipeline.nvim" },
  },
  -- optional, you can also install and use `yq` instead.
  build = "make",
  opts = {
    -- Although not an actual field for `opts`, here are the binds:
    -- ["q"] : Close the pipeline window
    -- ["gp"] : Open the pipeline under the cursor in the browser
    -- ["gr"] : Open that specific run that's below the cursor in the browser
    -- ["gj"] : Open that specific job that's below the cursor in the browser
    -- ["d"] : Dispatch a new run for the repository under the cursor

    --- The browser executable path to open workflow runs/jobs in
    browser = nil,
    --- Interval to refresh in seconds
    refresh_interval = 10,
    --- How much workflow runs and jobs should be indented
    indent = 2,
    providers = {
      github = {
        default_host = "github.com",
        --- Mapping of names that should be renamed to resolvable hostnames
        --- names are something that you've used as a repository url,
        --- that can't be resolved by this plugin, like aliases from ssh config
        --- for example to resolve "gh" to "github.com"
        --- ```lua
        --- resolve_host = function(host)
        ---   if host == "gh" then
        ---     return "github.com"
        ---   end
        --- end
        --- ```
        --- Return nil to fallback to the default_host
        ---@param host string
        ---@return string|nil
        resolve_host = function(host)
          return host
        end,
      },
      gitlab = {
        default_host = "gitlab.com",
        --- Mapping of names that should be renamed to resolvable hostnames
        --- names are something that you've used as a repository url,
        --- that can't be resolved by this plugin, like aliases from ssh config
        --- for example to resolve "gl" to "gitlab.com"
        --- ```lua
        --- resolve_host = function(host)
        ---   if host == "gl" then
        ---     return "gitlab.com"
        ---   end
        --- end
        --- ```
        --- Return nil to fallback to the default_host
        ---@param host string
        ---@return string|nil
        resolve_host = function(host)
          return host
        end,
      },
    },
    --- Allowed hosts to fetch data from, github.com is always allowed
    allowed_hosts = {},
    --- Configure which branch to use to dispatch workflow
    --- set to "default" to use the repository default branch
    --- set to "current" to use the branch you're currently checked out
    --- set to any valid branch name to use that branch
    --- @type string
    dispatch_branch = "default",
    icons = {
      workflow_dispatch = "⚡️",
      conclusion = {
        success = "✓",
        failure = "X",
        startup_failure = "X",
        cancelled = "⊘",
        skipped = "◌",
      },
      status = {
        unknown = "?",
        pending = "○",
        queued = "○",
        requested = "○",
        waiting = "○",
        in_progress = "●",
      },
    },
    highlights = {
      PipelineError = { link = "DiagnosticError" },
      PipelineRunIconSuccess = { link = "DiagnosticOk" },
      PipelineRunIconFailure = { link = "DiagnosticError" },
      PipelineRunIconStartup_failure = { link = "DiagnosticError" },
      PipelineRunIconPending = { link = "DiagnosticWarn" },
      PipelineRunIconRequested = { link = "DiagnosticWarn" },
      PipelineRunIconWaiting = { link = "DiagnosticWarn" },
      PipelineRunIconIn_progress = { link = "DiagnosticWarn" },
      PipelineRunIconCancelled = { link = "Comment" },
      PipelineRunIconSkipped = { link = "Comment" },
      PipelineRunCancelled = { link = "Comment" },
      PipelineRunSkipped = { link = "Comment" },
      PipelineJobCancelled = { link = "Comment" },
      PipelineJobSkipped = { link = "Comment" },
      PipelineStepCancelled = { link = "Comment" },
      PipelineStepSkipped = { link = "Comment" },
    },
    split = {
      relative = "editor",
      position = "right",
      size = 60,
      win_options = {
        wrap = false,
        number = false,
        foldlevel = nil,
        foldcolumn = "0",
        cursorcolumn = false,
        signcolumn = "no",
      },
    },
  },
}
