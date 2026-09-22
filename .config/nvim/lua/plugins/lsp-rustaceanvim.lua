local fmt_desc = function(desc)
  desc = type(desc) == "table" and desc[1] or desc
  ---@cast desc string

  local parts = {}
  -- split camelCase word boundaries: "codeAction" -> "code Action", "OpenCargo" -> "Open Cargo"
  -- parens around gsub so gmatch only sees the string, not its match-count return
  for word in (desc:gsub("(%l)(%u)", "%1 %2")):gmatch("%a+") do
    -- wrap the first letter of each word in brackets: "code" -> "[c]ode"
    parts[#parts + 1] = ("[%s]%s"):format(word:sub(1, 1), word:sub(2))
  end

  return table.concat(parts, " ")
end

local map_rustaceanvim = function(modes, lhs, opts, rust_lsp_cmd)
  ---@cast modes string[]
  modes = type(modes) == "string" and { modes } or modes
  -- lhs has to stay a string. vim.keymap.set rejects a table here.

  vim.keymap.set(modes, lhs, function()
    vim.cmd.RustLsp(rust_lsp_cmd)
  end, opts)
end

---@param direction "next" | "prev"
local map_list = function(direction)
  --
  local ql = require("utils").list.find_qf("q")
  local ll = require("utils").list.find_qf("l")
  local ql_len = #ql
  local ll_len = #ll
  direction = direction == "next" and "next" or "prev"

  if ql_len > 0 then
    vim.cmd("c" .. direction)
  else
    if ll_len > 0 then
      vim.cmd("l" .. direction)
    else
      print("No quickfix or loclist found")
    end
  end
end

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
          -- local LSP = require("config.lsp") --.setup({ binds_type = vim.g.lsp_binds_type or "builtin" })
          -- if not LSP then
          --   require("utils").output.warn("LSP config not found")
          --   return
          -- end

          -- <Leader>la overwrites the global code-action map in rust buffers.
          -- Subcommand names are the :RustLsp ones (`openCargo`, not `OpenCard`).
          -- A list value is extra args: { "renderDiagnostic", "cycle" }.
          local key_to_action = {
            ["<Leader>la"] = "codeAction",
            ["<Leader>ln"] = "renderDiagnostic",
            ["<Leader>lc"] = "openCargo",
            ["]n"] = { "renderDiagnostic", "cycle" },
            ["[n"] = { "renderDiagnostic", "cycle_prev" },
            ["<Leader>lx"] = "relatedDiagnostics",
            ["<Leader>dd"] = "debuggables",
            ["<Leader>dr"] = "runnables",
          }

          for lhs, rust_lsp_cmd in pairs(key_to_action) do
            -- LuaJIT reuses the for-loop local. A callback that closed over
            -- rust_lsp_cmd directly would run the last action for every key.
            local action = rust_lsp_cmd
            local name = type(action) == "table" and action[1] or action
            map_rustaceanvim("n", lhs, { desc = "[RUST] - " .. fmt_desc(name), buffer = bufnr }, action)
          end

          -- local mds = { "n", "x", "o" }

          -- vim.keymap.set(mds, "[[", function()
          --   map_list("prev")
          -- end, { desc = "Prev item in LIST" })
          --
          -- vim.keymap.set(mds, "]]", function()
          --   map_list("next")
          -- end, { desc = "Prev item in LIST" })
          --
          -- vim.keymap.set(mds, "[[", function()
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

          -- vim.keymap.set(mds, "]]", function()
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

          --------------------------------------------------
          -- vim.keymap.set("n", "<Leader>loc", function()
          --   require("rustaceanvim.commands.open_cargo_toml")()
          -- end, { desc = "Open Cargo.toml", buffer = bufnr })
          --------------------------------------------------

          -- vim.keymap.set("n", "]]", function()
          --   local tsutils = require("utils.tsutils")
          --   local cnext_op = function()
          --     vim.cmd("cnext")
          --   end
          --   tsutils.handle_builtins({ operation = cnext_op })
          -- end, { silent = true, desc = "qf next" })
          --
          -- vim.keymap.set("n", "[[", function()
          --   local tsutils = require("utils.tsutils")
          --   local cprev_op = function()
          --     vim.cmd("cprev")
          --   end
          --   tsutils.handle_builtins({ operation = cprev_op })
          -- end, { silent = true, desc = "qf prev" })
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
          hover = {
            memoryLayout = {
              padding = true,
              niches = true,
            },
          },
          -- diagnostics == "rust-analyzer",
          diagnostics = {
            enable = true,
            previewRustcOutput = true,
            -- diagnostics == "rust-analyzer",

            -- rust-analyzer.diagnostics.experimental.enable  default: false
            -- rust-analyzer.diagnostics.remapPrefix  default: {}
            -- rust-analyzer.diagnostics.styleLints.enable  default: false
            -- rust-analyzer.diagnostics.warningsAsHint  default: []
            -- rust-analyzer.diagnostics.warningsAsInfo  default: []
            --
            styleLints = {
              enable = true,
            },

            -- does 'true' enable all? -- don't think so...
            warningsAsHint = {
              "dead_code",
              "unused_variables",
              "unused_mut",
              "unused_imports",
            },

            warningsAsInfo = {
              "missing_docs",
            },

            -- rust-analyzer.document.symbol.search.excludeLocals  default: true
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

          lens = {
            debug = { enable = true },
            enable = true,
            implementations = { enable = true },
            references = {
              adt = { enable = true },
              enumVariant = { enable = true },
              method = { enable = true },
              trait = { enable = true },
            },
            run = { enable = true },
            updateTest = { enable = true },
          },
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
      -- local LSP = require("config.lsp") --.setup({ binds_type = vim.g.lsp_binds_type or "builtin" })
      -- if not LSP then
      --   require("utils").output.warn("LSP config not found")
      -- end

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
