return {
  { "nvim-neotest/neotest-plenary" },
  { "rouge8/neotest-rust", dependencies = { "nvim-treesitter" } },
  {
    "neotest",
    opts = {
      adapters = {
        "neotest-plenary",
        ["neotest-python"] = {
          runner = "pytest",
          python = ".venv/scripts/activate", -- .ps1
        },

        -------- Rust adapters - PICK ONE --------
        ["rustaceanvim.neotest"] = {},
        -- require("rustaceanvim.neotest"),
        -- require("neotest-rust")({
        --   args = { "--no-capture" },
        --   dap_adapter = "lldb",
        -- }),
      },
      -- status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          if LazyVim.has("trouble.nvim") then
            require("trouble").open({ mode = "quickfix", focus = false })
          else
            vim.cmd("copen")
          end
        end,
      },
    },
  },
}
