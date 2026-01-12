---@type LazyPluginBase
return {
  "folke/todo-comments.nvim",
  lazy = true,
  ---@type LazyEventSpec
  event = "BufReadPost",
  dependencies = { "nvim-lua/plenary.nvim" },
  ---@type LazyKeys
  keys = {
    -- stylua: ignore start
    -- { "q:", false },
    { "]t", function() return require("todo-comments").jump_next() end, desc = "Next todo comment", },
    { "[t", function() return require("todo-comments").jump_prev() end, desc = "Previous todo comment", },

    -- { "<Leader>ft", "<cmd>TodoFzfLua{tag = {TODO,FIX,FIXME,BUG}}<cr>", desc = "Todo/Fix/Fixme (Trouble)", },
    {
      "<Leader>ft",
      function()
        local project_wide = string.format("rg --files --glob '.*' --glob '!%s'",
          vim.fn.escape(vim.fn.getcwd() .. "/.git/**", " "))
        vim.cmd("TodoFzfLua keywords=TODO,FIX,FIXME cwd=" .. project_wide)
      end,
      desc = "Todo/Fix/Fixme (FzfLua)"
    },

    -- { "<Leader>lt", "<CMD>TodoLocList<CR>",                                           desc = "list [t]odo's",            mode = "n" },
    -- stylua: ignore end
  },

  opts = {
    keywords = {
      -- stylua: ignore start
      FIX = { icon = " ", color = "error" },
      HACK = { icon = ",", color = "warning" },
      NOTE = { icon = " ", color = "hint" },
      PERF = { icon = " ", color = "warning" },
      TODO = { icon = " ", color = "info" },
      WARN = { icon = " ", color = "warning" },
      -- stylua: ignore end
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      pattern = [[\b(KEYWORDS):]],
    },
  },
}
