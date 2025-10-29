local output = require("utils.output")
return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  ft = "rust",
  opts = {
    server = {
      on_attach = function(_, bufnr)
        vim.keymap.set("n", "<Leader>la", function()
          vim.cmd.RustLsp("codeAction")
          -- vim.cmd("FzfLua lsp_code_actions")
        end, { desc = "[a]ction", buffer = bufnr })

        -- vim.keymap.set("n", "<Leader>lA", function()
        --   -- vim.cmd.RustLsp("codeAction")
        --   -- vim.cmd("FzfLua lsp_code_actions")
        -- end, { desc = "[a]ction", buffer = bufnr })

        vim.keymap.set("n", "<Leader>lc", function()
          vim.cmd.RustLsp("flyCheck")
        end, { desc = "[c]heck" })

        vim.keymap.set("n", "<Leader>dd", function()
          vim.cmd.RustLsp("debuggables")
        end, { desc = "[d]ebuggables", buffer = bufnr })

        vim.keymap.set("n", "<Leader>dr", function()
          vim.cmd.RustLsp("runnables")
        end, { desc = "[r]un" })
      end,
    },

    default_settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          buildScripts = {
            enable = true,
          },
        },
        -- Add clippy lints for Rust.
        checkOnSave = true,
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
            "target",
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
    dap = {
      adapter = {
        command = "lldb-vscode",
        name = "lldb",
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
    if package.preload["mason.nvim"] then
      -- LazyVim.has("mason.nvim") then
      local codelldb = vim.fn.exepath("codelldb")
      local codelldb_lib_ext = io.popen("uname"):read("*l") == "Linux" and ".so" or ".dylib"
      local library_path = vim.fn.expand("$MASON/opt/lldb/lib/liblldb" .. codelldb_lib_ext)
      opts.dap = {
        adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
      }
    end
    vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    if vim.fn.executable("rust-analyzer") == 0 then
      output.err("**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/")
    end
  end,
}
