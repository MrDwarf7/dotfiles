---@type LazyPluginBase[]
return {

  ---@type LazyPluginBase
  {
    "MrDwarf7/kulala.nvim",
    lazy = true,
    -- dev = true,
    -- enabled = false,
    -- event = "VeryLazy",
    ft = { "http", "rest" },
    dependencies = {
      {
        "MrDwarf7/kulala-core",
        branch = "main",
        -- dev = true,
        build = "bun install --frozen-lockfile && bun run build",
      },
    },
    --  c ➜  Copy as cURL               i ➜  Inspect current request    S ➜  Show stats                 a ➜   Send all requests          s ➜   Send request        │
    --  C ➜  Paste from curl            j ➜  Open cookies jar           t ➜  Toggle headers/body        b ➜   Open scratchpad                                      │
    --  e ➜  Select environment         n ➜  Jump to next request       u ➜  Manage Auth Config         h ➜  Toggle headers/body                                  │
    --  f ➜  Find request               p ➜  Jump to previous request   x ➜  Clear globals              o ➜   Open kulala                                          │
    --  g ➜  Download GraphQL schema    q ➜  Close window               X ➜  Clear cached files         r ➜   Replay the last request                              │

    ---@type LazyKeys
    keys = {
      -- stylua: ignore start

      ------------------
      --- Originals ----
      ------------------
      -- { "<Leader>rb", function() require("kulala").scratchpad() end, desc = "Open scratchpad" },
      -- { "<Leader>ro", function() require("kulala").open() end, desc = "Open kulala" },
      -- { "<Leader>rq", function() require("kulala").close() end, ft = { "http", "rest" }, desc = "Close window" },
      -- { "<Leader>rc", function() require("kulala").copy() end, ft = { "http", "rest" }, desc = "Copy as cURL" },
      -- { "<Leader>rC", function() require("kulala").from_curl() end, ft = { "http", "rest" }, desc = "Paste from curl" },
      -- { "<Leader>ri", function() require("kulala").inspect() end, ft = { "http", "rest" }, desc = "Inspect current request" },
      -- { "<Leader>rj", function() require("kulala").open_cookies_jar() end, ft = { "http", "rest" }, desc = "Open cookies jar" },
      -- { "<Leader>re", function() require("kulala").set_selected_env() end, ft = { "http", "rest" }, desc = "Select environment" },
      -- { "<Leader>ru", function() require("kulala.ui.auth_manager").open_auth_config() end, ft = { "http", "rest" }, desc = "Manage Auth Config" },
      -- { "<Leader>rs", function() require("kulala").run() end, mode = { "n", "v" }, desc = "Send request" },
      -- { "<Leader>r<CR>", function() require("kulala").run() end, mode = { "n", "v" }, ft = { "http", "rest" }, desc = "Send request <cr>" },
      -- { "<Leader>ra", function() require("kulala").run_all() end, mode = { "n", "v" }, desc = "Send all requests" },
      -- { "<Leader>rr", function() require("kulala").replay() end, desc = "Replay the last request" },
      -- { "<Leader>rg", function() require("kulala").download_graphql_schema() end, ft = { "http", "rest" }, desc = "Download GraphQL schema" },
      -- { "<Leader>rn", function() require("kulala").jump_next() end, ft = { "http", "rest" }, desc = "Jump to next request" },
      -- { "<Leader>rp", function() require("kulala").jump_prev() end, ft = { "http", "rest" }, desc = "Jump to previous request" },
      -- { "<Leader>rf", function() require("kulala").search() end, ft = { "http", "rest" }, desc = "Find request" },
      -- { "<Leader>rt", function() require("kulala").toggle_tab() end, ft = { "http", "rest" }, desc = "Toggle tab" },
      -- { "<Leader>rS", function() require("kulala").show_stats() end, ft = { "http", "rest" }, desc = "Show stats" },
      -- { "<Leader>rx", function() require("kulala").scripts_clear_global() end, ft = { "http", "rest" }, desc = "Clear globals" },
      -- { "<Leader>rX", function() require("kulala").clear_cached_files() end, ft = { "http", "rest" }, desc = "Clear cached files" },


      { "<Leader>rt", function() require("kulala").toggle_tab() end, ft = { "http", "rest" }, desc = "[t]oggle tab" },
      { "<Leader>ro", function() require("kulala").toggle_view() end, desc = "Toggle [v]iew" },
      -- { "<Leader>ro", function() require("kulala").open() end, desc = "Open kulala" },
      { "<Leader>rq", function() require("kulala").close() end, ft = { "http", "rest" }, desc = "Close window" },

      { "<Leader>rl", function() require("kulala").replay() end, desc = "Run [l]ast" },

      { "<Leader>rr", function() require("kulala").run() end, mode = { "n", "v" }, desc = "[r]un request" },
      { "<Leader>ra", function() require("kulala").run_all() end, mode = { "n", "v" }, desc = "[r]un [a]ll requests" },
      { "<Leader>r<CR>", function() require("kulala").run() end, mode = { "n", "v" }, ft = { "http", "rest" }, desc = "Send request <cr>" },

      { "<Leader>ri", function() require("kulala").inspect() end, ft = { "http", "rest" }, desc = "[i]nspect current request" },

      { "<Leader>rb", function() require("kulala").scratchpad() end, desc = "[b]uffer/scratch" },

      { "<Leader>rc", function() require("kulala").copy() end, ft = { "http", "rest" }, desc = "[c]opy AS curl" },
      { "<Leader>rP", function() require("kulala").from_curl() end, ft = { "http", "rest" }, desc = "[P]aste FROM curl" },

      { "<Leader>rj", function() require("kulala").open_cookies_jar() end, ft = { "http", "rest" }, desc = "cookie [j]ar" },

      { "<Leader>re", function() require("kulala").set_selected_env() end, ft = { "http", "rest" }, desc = "select [e]nv" },
      { "<Leader>rA", function() require("kulala.ui.auth_manager").open_auth_config() end, ft = { "http", "rest" }, desc = "manage [A]uth config" },
      { "<Leader>rg", function() require("kulala").download_graphql_schema() end, ft = { "http", "rest" }, desc = "pull [g]raphql schema" },

      -- TODO: these should probably just be lsp-style 'loaded on demand' mappings for `[[` and `]]` resp. tbg
      { "<Leader>rn", function() require("kulala").jump_next() end, ft = { "http", "rest" }, desc = "Jump to next request" },
      { "<Leader>rp", function() require("kulala").jump_prev() end, ft = { "http", "rest" }, desc = "Jump to previous request" },

      { "<Leader>rf", function() require("kulala").search() end, ft = { "http", "rest" }, desc = "[f]ind" },
      { "<Leader>rS", function() require("kulala").show_stats() end, ft = { "http", "rest" }, desc = "[S]tats" },
      { "<Leader>rx", function() require("kulala").scripts_clear_global() end, ft = { "http", "rest" }, desc = "clear globals" },
      { "<Leader>rX", function() require("kulala").clear_cached_files() end, ft = { "http", "rest" }, desc = "clear cached files" },

      -- { "<Leader>ra", desc = "Send request" },
      -- { "<Leader>ra", desc = "Send all requests" },
      -- { "<Leader>rb", desc = "Open scratchpad" },
      -- { "<Leader>rh", function() require("kulala").toggle_tab() end, desc = "Toggle tab", },
      -- { "<Leader>rr", function() require("kulala").run() end, desc = "Send request", },
      -- { "<Leader>ra", function() require("kulala").run_all() end, desc = "Send all requests", },
      -- { "<Leader>rb", function() require("kulala").scratchpad() end, desc = "Open scratchpad", },
      -- { "<Leader>ro", function() require("kulala").toggle_tab() end, desc = "Toggle tab", },
      -- { "<Leader>ri", function() require("kulala").inspect() end, desc = "Toggle headers/body", },
      -- { "<Leader>rC", function() require("kulala").from_curl() end, desc = "Toggle headers/body", },
      -- stylua: ignore end
    },

    opts = {
      global_keymaps = false,
      -- global_keymaps_prefix = "<Leader>r",
      -- kulala_keymaps_prefix = "",
      -- lsp = {
      --   keymaps = true,
      -- },
    },
  },

  -- ---@type LazyPluginBase
  {
    "rest-nvim/rest.nvim",
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "http")
      end,
    },
    keys = {
      { "<Leader>ro", "<CMD>Rest open<CR>", desc = "[O]pen the rest-nvim panel" },
      { "<Leader>rr", "<CMD>Rest run<CR>", desc = "[R]un the request (under the cursor)" },
      { "<Leader>rl", "<CMD>Rest last<CR>", desc = "Run the [l]ast request" },
      { "<Leader>rc", "<CMD>Rest cookies<CR>", desc = "Edit the [c]ookies file" },
      { "<Leader>re", "<CMD>Rest env show<CR>", desc = "Show the .[e]nv file assoc." },
    },
  },

  -- ---@type LazyPluginBase
  -- {
  --   "oysandvik94/curl.nvim",
  --   cmd = { "CurlOpen" },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   -- config = true,
  -- opts = {}
  -- },
}
