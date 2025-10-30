return {
  "nvim-neotest/neotest",
  lazy = true, -- doesn't need to run unless called via keymap or command
  cmd = { "Neotest" },
  dependencies = {
    { "nvim-neotest/nvim-nio", lazy = true, event = "VeryLazy" },
    { "nvim-lua/plenary.nvim", lazy = true, event = "VeryLazy" },
    { "antoinemadec/FixCursorHold.nvim", lazy = true, event = "VeryLazy" },
    { "nvim-treesitter/nvim-treesitter", lazy = true, event = "VeryLazy" },
    -- languages --
    { "alfaix/neotest-gtest", lazy = true }, -- C++/CPP (uses gtest)

    { "rcasia/neotest-bash", lazy = true }, -- Bash
    { "lawrence-laz/neotest-zig", lazy = true }, -- Zig
  },
  keys = {
    -- stylua: ignore start
    { "<Leader>or", function() require("neotest").run.run() end,                                        desc = "NTest - Run Nearest" },
    { "<Leader>of", function() require("neotest").run.run(vim.fn.expand("%")) end,                      desc = "NTest - Run File" },
    { "<Leader>ow", function() require("neotest").run.run(vim.loop.cwd()) end,                          desc = "NTest - Run Workspace" },
    { "<Leader>os", function() require("neotest").run.stop() end,                                       desc = "NTest - Stop" },


    { "<Leader>ot", function() require("neotest").summary.toggle() end,                                 desc = "NTest - Summary (toggle)" },

    { "<Leader>og", function() require("neotest").output.open({ short = true, auto_close = true }) end, desc = "Ntest Output (short)" },
    { "<Leader>oo", function() require("neotest").output.open({ enter = true }) end,                    desc = "Ntest Output-Panel" },
    { "<Leader>lo", function() require("neotest").output.open({ enter = true }) end,                    desc = "Ntest Output-Panel" },

    { "<Leader>om", function() require("neotest").summary.run_marked() end,                             desc = "NTest - Run Marked" },

    { "<Leader>on", function() require("neotest").jump.next() end,                                      desc = "Next Test" },
    { "<Leader>op", function() require("neotest").jump.prev() end,                                      desc = "Prev Test" },
    { "<Leader>ol", function() require("neotest").jump.last() end,                                      desc = "Last Test" },

    { "]o",         function() require("neotest").jump.next() end,                                      desc = "Next Test" },
    { "[o",         function() require("neotest").jump.prev() end,                                      desc = "Prev Test" },

    -- TODO: not impl. requires DAP support
    --
    -- { "<Leader>Td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Run DAP for nearest test" },

    -- stylua: ignore end
  },
  opts = function()
    return {
      adapters = {
        -- Rust
        require("rustaceanvim.neotest"), -- if using this, DO NOT add neotest-rust

        -- Zig
        require("neotest-zig")({
          -- options here
          dap = {
            adapter = "lldb",
          },
        }),
        require("neotest-gtest").setup({
          --
        }),
      },
    }
  end,
}
