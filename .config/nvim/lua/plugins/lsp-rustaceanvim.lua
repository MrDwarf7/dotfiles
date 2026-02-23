-- local output = require("utils.output")

return {
  {
    "mrcjkb/rustaceanvim",
    lazy = false,
    -- version = "^8",
    opts = {
      tools = {
        enable_clippy = true,
      },

      server = {
        on_attach = function(_, bufnr)
          require("config.lsp").setup({ binds_type = vim.g.lsp_binds_type or "builtin" })

          vim.keymap.set("n", "<Leader>lA", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Rust - [A]ction", buffer = bufnr })

          vim.keymap.set("n", "<Leader>ln", function()
            vim.cmd.RustLsp("renderDiagnostic")
          end, { desc = "Rust - in-comp. diag", buffer = bufnr })

          vim.keymap.set("n", "]n", function()
            vim.cmd.RustLsp({ "renderDiagnostic", "cycle" })
          end, { desc = "Rust - Next comp. diag ", buffer = bufnr })

          vim.keymap.set("n", "[n", function()
            vim.cmd.RustLsp({ "renderDiagnostic", "cycle_prev" })
          end, { desc = "Rust - Prev comp. diag ", buffer = bufnr })

          vim.keymap.set("n", "<leader>lx", function()
            vim.cmd.RustLsp("relatedDiagnostics")
          end, { desc = "Rust - Prev comp. diag ", buffer = bufnr })

          -- vim.keymap.set("n", "<Leader>lA", function()
          --   -- vim.cmd.RustLsp("codeAction")
          --   -- vim.cmd("FzfLua lsp_code_actions")
          -- end, { desc = "[a]ction", buffer = bufnr })

          -- vim.keymap.set("n", "<Leader>lc", function()
          --   vim.cmd.RustLsp("flyCheck")
          -- end, { desc = "[c]heck" })

          vim.keymap.set("n", "<Leader>dd", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "[d]ebuggables", buffer = bufnr })

          vim.keymap.set("n", "<Leader>dr", function()
            vim.cmd.RustLsp("runnables")
          end, { desc = "[r]un" })

          --

          -- BUG: These aren't working because no matter where I put them,
          -- rust-analyzer overrides them with just simple function jumps (each functions opening bracket...)

          -- vim.keymap.set("n", "[[", function()
          --   -- if the qf list or location list is open, navigate that instead of buffers
          --   local ql = require("utils").list.find_qf("q")
          --   dd(ql)
          --   if #ql > 0 then
          --     return vim.cmd.cprev()
          --   end
          --   local ll = require("utils").list.find_qf("l")
          --   if #ll > 0 then
          --     return vim.cmd.lprev()
          --   end
          -- end, { desc = "Prev item in LIST" })
          --
          -- vim.keymap.set("n", "]]", function()
          --   -- if the qf list or location list is open, navigate that instead of buffers
          --   local ql = require("utils").list.find_qf("q")
          --   if #ql > 0 then
          --     return vim.cmd.cnext()
          --   end
          --   local ll = require("utils").list.find_qf("l")
          --   if #ll > 0 then
          --     return vim.cmd.lnext()
          --   end
          -- end, { desc = "Next item in LIST" })

          --
        end,
      },

      default_settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
            extraArgs = {
              "--no-deps",
              "--",
              "-W",
              "clippy::pedantic",
            },
          },
          -- Add clippy lints for Rust.
          checkOnSave = true,
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },
          -- diagnostics == "rust-analyzer",
          diagnostics = {
            enable = true,

            -- diagnostics == "rust-analyzer",
          },
          procMacro = {
            enable = true,
            ignored = {
              ["async-trait"] = { "async_trait" },
              ["napi-derive"] = { "napi" },
              ["async-recursion"] = { "async_recursion" },
            },
          },
          files = {
            excludeDirs = {
              ".direnv",
              ".git",
              ".github",
              ".gitlab",
              "bin",
              "node_modules",
              -- "target",
              "venv",
              ".venv",
            },
          },

          inlay_hints = {
            align = true,
            bindingHints = true,
            chainingHints = true,
            closingBraceHints = true,
            closureCaptureHints = true,
            closureReturnTypeHints = true,
            closureStyle = "rust_analyzer",
            discriminationHints = true,
            expressionAdjustmentHints = true,
            highlight = "Comment",
            implicitDrops = true,
            lifetimeEllisionHints = {
              enable = true,
              useParamaterNames = true,
            },
            -- lifetimeEllisionHints = true,
            maxLength = 120,
            mutableBorrowHints = true,
            parameterHints = {
              enable = true,
            },
            -- parameterHints = true,
            prefix = " » ",
            rangeExclusiveHints = {
              enable = true,
            },
            typeHints = true,
          },
          watcher = "client",
        },
      },
      ---@type rustaceanvim.dap.Opts
      dap = {
        adapter = {
          -- command = "lldb-vscode",
          -- name = "lldb",
          command = "codelldb",
          name = "codelldb",
          type = "executable",
        },
        configuration = {
          args = {},
          cwd = vim.fn.getcwd(),
          env = {},
          externalConsole = false,
          MIMode = "gdb",
          name = "lldb",
          program = "${file}",
          request = "launch",
          stopOnEntry = true,
          type = "lldb",
          setupCommands = {
            {
              description = "Enable pretty-printing for gdb",
              ignoreFailures = true,
              text = "-enable-pretty-printing",
            },
          },
          sourceLanguages = { "rust" },
        },
      },
    },
    config = function(_, opts)
      require("config.lsp").setup({ binds_type = vim.g.lsp_binds_type or "builtin" })
      vim.g.rustaceanvim = opts
    end,
  },

  ---@type LazyPluginBase
  {
    "saecki/crates.nvim",
    -- lazy = true,
    -- event = { "BufRead Cargo.toml" },
    ft = { "toml" },
    ---@type crates.UserConfig
    opts = {
      ---- new options after fixing the plugin
      autoload = true,
      smart_insert = true,
      ----

      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
      completion = {
        crates = {
          enabled = true,
          max_results = 8,
          min_chars = 1,
        },
      },
    },
    ---@param _ LazyPluginBase
    ---@param opts crates.UserConfig
    config = function(_, opts)
      require("crates").setup(opts)
    end,
  },
}
