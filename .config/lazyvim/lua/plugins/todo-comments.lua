return {
  "todo-comments.nvim",
  keys = {
    -- stylua: ignore start
    { "]t", function() return require("todo-comments").jump_next() end, desc = "Next todo comment", },
    { "[t", function() return require("todo-comments").jump_prev() end, desc = "Previous todo comment", },
    { "<Leader>tt", "<cmd>Trouble todo toggle<CR>", desc = "TODO (Trouble)" },
    { "<Leader>tT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)", },
    { "<Leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    { "<Leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    { "<Leader>lt", ":TodoLocList<CR>", desc = "list [t]odo's", mode = "n" },
    -- stylua: ignore end
  },

  opts = {
    keywords = {
      FIX = { icon = " ", color = "error" },
      HACK = { icon = ",", color = "warning" },
      NOTE = { icon = " ", color = "hint" },
      PERF = { icon = " ", color = "warning" },
      TODO = { icon = " ", color = "info" },
      WARN = { icon = " ", color = "warning" },
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
