return {

  -- PYTHON DAP

  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },
  },

  {
    "nvim-neotest/neotest-python",
  },

  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mfussenegger/nvim-dap-python",
    -- stylua: ignore
    keys = {
      { "<leader>d", desc = "[D]ebugging" },
      { "<leader>dp", desc = "[P]ython" },
      { "<leader>dpf", function() require('dap-python').test_method() end, desc = "[F]unction/Method Debug" },
      { "<leader>dpc", function() require('dap-python').test_class() end, desc = "[C]lass Debug" },
    },
      config = function()
        local path = require("mason-registry").get_package("debugpy"):get_install_path()
        require("dap-python").setup(path .. "/venv/bin/python")
      end,
    },
  },

  {
    "mfussenegger/nvim-dap-python",
  -- stylua: ignore
  keys = {
      { "<leader>d", desc = "[D]ebugging" },
      { "<leader>dp", desc = "[P]ython" },
      { "<leader>dpf", function() require('dap-python').test_method() end, desc = "[F]unction/Method Debug" },
      { "<leader>dpc", function() require('dap-python').test_class() end, desc = "[C]lass Debug" },
  },
    config = function()
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(path .. "/venv/bin/python")
    end,
  },

  {
    "linux-cultist/venv-selector.nvim",
    cmd = "VenvSelect",
    opts = {
      name = {
        "venv",
        ".venv",
        "env",
        ".env",
      },
    },
    keys = { { "<leader>fv", "<cmd>:VenvSelect<cr>", desc = "Find [V]env" } },
  },
  -- END PYTHON DAP
  --
}
