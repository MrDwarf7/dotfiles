-- TODO: properly configure it (binds etc.)

---@type LazyPluginBase
return {
  "folke/trouble.nvim",
  enabled = true,
  lazy = true,
  ---@type LazyEventSpec
  event = "BufReadPre",
  cmd = "Trouble",
  ---@type LazyKeys
  keys = {
    {
      "<leader>td",
      function()
        require("trouble").toggle("diagnostics")
      end,
      desc = "Diagnostics (Trouble)",
    },

    {
      "<leader>tD",
      function()
        require("trouble").toggle({ mode = "diagnostics", buf = 0 })
      end,
      desc = "Buffer Diagnostics (Trouble)",
    },

    {
      "<leader>ts",
      function()
        require("trouble").toggle("symbols")
      end,
      desc = "Symbols (Trouble)",
    },

    {
      "<leader>tS",
      function()
        require("trouble").toggle({ mode = "symbols", focus = false, win = { position = "right" } })
      end,
      desc = "LSP references/definitions/... (Trouble)",
    },

    {
      "<leader>tc",
      function()
        require("trouble").toggle("qflist")
      end,
      desc = "Quickfix List (Trouble)",
    },

    {
      "<leader>tt",
      function()
        require("trouble").toggle({ mode = "todo", focus = true })
      end,
      desc = "Todo List focus (Trouble)",
    },

    {
      "<leader>tT",
      function()
        require("trouble").toggle("todo")
      end,
      desc = "Todo List (Trouble)",
    },

    {
      "<Leader>lt",
      function()
        vim.cmd("TodoTrouble")
      end,
      desc = "list [t]odo's",
      mode = "n",
    },

    { "<leader>tl", "<CMD>Trouble loclist toggle<CR>", desc = "Location List (Trouble)" },
    {
      "<Leader>tq",
      function()
        -- need to check if the todo list is open or not

        -- filetype for it (from set ft?) is `trouble`
        -- We need to find it it's open at all
        local is_open = false
        for _, win in pairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
          if ft == "trouble" then
            is_open = true
            break
          end
        end
        if is_open then
          require("trouble").close()
        else
          local lm = require("trouble").last_mode
          require("trouble").open(lm or "workspace_diagnostics")
        end
      end,
      desc = "Toggle [t]rouble last",
    },

    {
      "]]",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = false, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
        -- return require("trouble").next({ skip_groups = true, jump = true })
      end,
      mode = "n",
      desc = "[p]robem NEXT",
    },

    {
      "[[",
      function()
        if require("trouble").is_open() then
          require("trouble").prev({ skip_groups = false, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
        -- return require("trouble").previous({ skip_groups = true, jump = true })
      end,
      mode = "n",
      desc = "[p]robem PREV",
    },
  },
  opts = {},
}
