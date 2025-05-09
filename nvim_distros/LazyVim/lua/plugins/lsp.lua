return {
  "nvim-lspconfig",
  -- stylua: ignore start
  opts = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()

    -- Remove
    keys[#keys + 1] = { "<leader>cR", false }  --function() Snacks.rename.rename_file() end, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } }

    keys[#keys + 1] = { "<Leader>l<S-i>", "<CMD>LspInfo<CR>", desc = "Lsp Info" }
    --  gd
    --  gr
    --  gI
    keys[#keys + 1] = { "gt", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" }
    keys[#keys + 1] = { "<leader>la", vim.lsp.buf.code_action, desc = "Lsp Action", mode = { "n", "v" }, has = "codeAction" }
    keys[#keys + 1] = { "<leader>lc", vim.lsp.codelens.run, desc = "CodeLens", mode = { "n", "v" }, has = "codeLens" }
    keys[#keys + 1] = { "<leader>lC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" }
    keys[#keys + 1] = { "<leader>lr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
    keys[#keys + 1] = { "<Leader>lh", vim.diagnostic.open_float, desc = "float" }

    keys[#keys + 1] = { "<Leader>ca", false }
    keys[#keys + 1] = { "<Leader>cA", false }
    keys[#keys + 1] = { "<Leader>cc", false }
    keys[#keys + 1] = { "<Leader>cC", false }
    keys[#keys + 1] = { "<Leader>cl", false }
    keys[#keys + 1] = { "<Leader>cr", false }
  -- stylua: ignore end

    local ret = {
      -- options for vim.diagnostic.config()
      ---@type vim.diagnostic.Opts
      diagnostics = {
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        underline = true,
        severity_sort = true,
        update_in_insert = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = true,
        exclude = { }, -- filetypes for which you don't want to enable inlay hints
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = false,
      },
      -- add any global capabilities here
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      servers = require("utils.lsp_servers"),
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    }
  return ret
  end,
}
