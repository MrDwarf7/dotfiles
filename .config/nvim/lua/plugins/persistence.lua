--

-- Events (new & added via persistence)
-- PersistenceLoadPre:		before loading a session
-- PersistenceLoadPost:		after  loading a session
-- PersistenceSavePre:		before saving  a session
-- PersistenceSavePost:		after  saving  a session

---@type LazyPluginBase
return {
  "folke/persistence.nvim",
  ---@type LazyEventSpec
  event = "BufReadPre",
  ---@type LazyKeys
  keys = {
    -- stylua: ignore start
    { "<Leader>ss", function() require("persistence").load() end,                desc = "Restore Session (cwd)" },
    { "<Leader>sf", function() require("persistence").select() end,              desc = "Select Session" },
    { "<Leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore last Session" },
    { "<Leader>sd", function() require("persistence").stop() end,                desc = "Delete/Stop current Session" },

    -- There's also this binding in lua/plugins/fzf-lua.lua:25
    -- { "<Leader>sf", function() require("persistence").select() end,                     desc = "Select Session" },

    -- defaults as well
    { "<Leader>Qs", function() require("persistence").load() end,                desc = "Restore Session (cwd)" },
    { "<Leader>QS", function() require("persistence").select() end,              desc = "Select Session" },
    { "<Leader>Ql", function() require("persistence").load({ last = true }) end, desc = "Restore last Session" },
    { "<Leader>Qd", function() require("persistence").stop() end,                desc = "Delete/Stop current Session" },
    -- stylua: ignore end
  },

  config = function()
    local function get_tmux_info()
      if not vim.env.TMUX then
        return nil
      end

      local ok, handle = pcall(io.popen, "tmux display-message -p '#S_#W'")
      if not ok or not handle then
        return nil
      end

      local tmux_info = handle:read("*a")
      handle:close()

      if not tmux_info or tmux_info == "" then
        return nil
      end

      return tmux_info:gsub("\n", ""):gsub("[^%w%-_]", "_")
    end

    local persistence = require("persistence")
    local config = require("persistence.config")
    local default_dir = vim.fn.stdpath("state") .. "/sessions/"
    local tmux_info = get_tmux_info()

    -- Setup with default dir first
    persistence.setup({
      dir = default_dir,
    })

    -- If in tmux, check if we should switch to tmux dir
    if tmux_info then
      local tmux_dir = default_dir .. "tmux-" .. tmux_info .. "/"

      -- Check if tmux dir has any sessions
      vim.fn.mkdir(tmux_dir, "p")
      local has_tmux_sessions = #vim.fn.glob(tmux_dir .. "*.vim", false, true) > 0

      if has_tmux_sessions then
        -- Tmux sessions exist, use tmux dir
        config.options.dir = tmux_dir
      else
        -- No tmux sessions yet, stay on default but switch after first load
        vim.api.nvim_create_autocmd("User", {
          pattern = "PersistenceLoadPost",
          once = true,
          callback = function()
            -- After loading from default, switch to tmux dir for saving
            config.options.dir = tmux_dir
          end,
        })
      end
    end
  end,
}
