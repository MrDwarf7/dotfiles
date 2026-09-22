-- Deferred: these overlap and should be one job each.
--
-- quicker.nvim owns the real quickfix and location-list window (`ft=qf`).
-- Trouble is a separate viewer. It is not a keybind layer on top of quicker.
-- Its `qflist` and `loclist` modes draw the same lists quicker already shows,
-- and the `]]` / `[[` binds here fight the qf binds.
--
-- Keep Trouble for what is not a quickfix: diagnostics, todos, and maybe
-- document symbols. Drop the qf/loclist modes when that split is done.
-- lualine still reads Trouble's document-symbol statusline, so do not
-- remove the plugin until that call moves.
--
-- Symbols are the other copy. `<Leader>ls` is symbols.nvim. `<Leader>ts` is
-- Trouble's symbols mode. Snacks has a third picker, only on the snacks
-- binds provider. aerial and outline are already commented out in
-- lua/plugins/symbols.lua. Pick one sidebar.
--
return {
  "folke/trouble.nvim",
  enabled = true,
  lazy = true,
  ---@type LazyEventSpec
  event = "BufReadPre",
  cmd = "Trouble",
  keys = {
    -- stylua: ignore start
    { "<leader>td", function() require("trouble").toggle("diagnostics") end, desc = "Diagnostics (Trouble)" },
    { "<leader>tD", function() require("trouble").toggle({ mode = "diagnostics", buf = 0 }) end, desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>ts", function() require("trouble").toggle("symbols") end, desc = "Symbols (Trouble)" },
    { "<leader>tS", function() require("trouble").toggle({ mode = "symbols", focus = false, win = { position = "right" } }) end, desc = "LSP references/definitions/... (Trouble)" },
    { "<leader>tt", function() require("trouble").toggle({ mode = "todo", focus = true }) end, desc = "Todo List focus (Trouble)" },
    { "<leader>tT", function() require("trouble").toggle("todo") end, desc = "Todo List (Trouble)" },
    { "<Leader>lt", function() vim.cmd("TodoTrouble") end, desc = "list [t]odo's", mode = "n" },
    { "<leader>tL", "<CMD>Trouble loclist toggle<CR>", desc = "Location List (Trouble)" },
    { "<leader>tq", function() require("trouble").toggle("qflist") end, desc = "Quickfix List (Trouble)" },
    -- stylua: ignore end
    {
      "<Leader>tl",
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
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts or {}, {
      picker = {
        actions = require("trouble.sources.snacks").actions,
        win = {
          input = {
            keys = {
              ["<C-t>"] = {
                "trouble_open",
                mode = { "n", "i" },
              },
            },
          },
        },
      },
    })
  end,
}
