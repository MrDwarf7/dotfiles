local feedkeys = vim.api.nvim_feedkeys

return {
  "gitsigns.nvim",
  keys = {
    -- Disable a bunch of built-ins
    {
      "<Leader>hp",
      function()
        return require("gitsigns").preview_hunk()
      end,
      desc = "[p]review hunk",
    },

    {
      "<Leader>hs",
      function()
        return require("gitsigns").stage_hunk()
      end,
      desc = "[s]tage hunk",
    },
    {
      --
      "<Leader>hr",
      function()
        return require("gitsigns").reset_hunk()
      end,
      desc = "[r]eset hunk",
    },

    {
      "<Leader>hR",
      function()
        return require("gitsigns").reset_buffer()
      end,
      desc = "[R]eset buffer",
    },

    {
      "<Leader>hS",
      function()
        return require("gitsigns").stage_buffer()
      end,
      desc = "[S]tage buffer",
    },

    {
      "<Leader>hu",
      function()
        return require("gitsigns").undo_stage_hunk()
      end,
      desc = "[u]ndo stage",
    },

    {
      "<Leader>hb",
      function()
        return require("gitsigns").blame_line({ full = true })
      end,
      desc = "[b]lame line",
    },

    {
      "<Leader>hT",
      function()
        return require("gitsigns").toggle_current_line_blame()
      end,
      desc = "[T]oggle deleted",
    },
    {
      "<Leader>ht",
      function()
        return require("gitsigns").toggle_deleted()
      end,
      desc = "[t]oggle blame",
    },
    {
      "<Leader>hd",
      function()
        return require("gitsigns").diffthis()
      end,
      desc = "[d]iff this",
    },

    {
      "<Leader>hD",
      function()
        return require("gitsigns").diffthis("main")
      end,
      desc = "[D]iff main",
    },

    {
      "[c",
      function()
        require("gitsigns").prev_hunk()
        vim.schedule(function()
          feedkeys("zz", "n", false)
        end)
      end,
      desc = "[p]revious hunk",
      mode = { "n", "v" },
    },

    {
      "]c",
      function()
        require("gitsigns").next_hunk()
        vim.schedule(function()
          feedkeys("zz", "n", false)
        end)
      end,
      desc = "[n]ext hunk",
      mode = { "n", "v" },
    },

    {
      "[h",
      function()
        require("gitsigns").prev_hunk()
        vim.schedule(function()
          feedkeys("zz", "n", false)
        end)
      end,
      desc = "[p]revious hunk",
      mode = { "n", "v" },
    },

    {
      "]h",
      function()
        require("gitsigns").next_hunk()
        vim.schedule(function()
          feedkeys("zz", "n", false)
        end)
      end,
      desc = "[n]ext hunk",
      mode = { "n", "v" },
    },
  },

  opts = {

    signs = {
      add = { text = "│" },
      changedelete = { text = "~" },
      change = { text = "│" },
      delete = { text = "󰍵" },
      topdelete = { text = "‾" },
      untracked = { text = "│" },
    },

    signs_staged = {
      add = { text = "│" },
      changedelete = { text = "~" },
      change = { text = "│" },
      delete = { text = "󰍵" },
      topdelete = { text = "‾" },
      untracked = { text = "│" },
    },

    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      -- local function map(mode, lhs, rhs, desc)
      --   vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
      -- end
      local map = vim.keymap.set

      map("o", "ih", gs.select_hunk, { desc = "select hunk" })
      map("x", "ih", gs.select_hunk, { desc = "select hunk" })
    end,
  },
}
