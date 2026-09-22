--- Represents all `Mason` related tools

local installables = require("plugins.lsp.installables")

local get_default_capabilities = function()
  ---@type lsp.ClientCapabilities
  local capabilities = {
    textDocument = {
      completion = {
        snippetSupport = false,
      },
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
    workspace = {
      fileOperations = {
        -- TEST: : might turn these off, idk
        didRename = true,
        willRename = true,
      },
    },
  }

  -- TODO: streamline - `blink_cmp.get_lsp_capabilities` already gives us back a tbl

  local blink_cmp_ok, blink_cmp = pcall(require, "blink.cmp")
  if blink_cmp_ok then
    capabilities = blink_cmp.get_lsp_capabilities(capabilities, true)
  else
    capabilities = vim.lsp.protocol.make_client_capabilities()
  end

  -- LSP.capabilities = capabilities
  return capabilities
end

---@alias LSPBindsProvider "builtin" | "fzf" | "snacks"

---@param binds_provider LSPBindsProvider
---@return void|Error
local apply_keys = function(binds_provider)
  ----------- Remove some shitty defaults
  local remove_defaults = { "grn", "gra", "gri", "grr", "grt" }
  for _, bind in ipairs(remove_defaults) do
    pcall(vim.keymap.del, "n", bind)
  end

  ----------- build the filename (probs shouldn't do this tbh)
  local binds_provider_name = string.format("plugins.lsp.lsp_binds_%s", binds_provider)
  local ok, maybe_data = pcall(require, binds_provider_name)
  if not ok then
    require("utils").output.err("Failed to load LSP binds provider: " .. binds_provider_name)
  end
  if type(maybe_data) == "table" and type(maybe_data.setup) == "function" then
    return maybe_data.setup()
  else
    require("utils").output.err("LSP binds provider does not have a setup function: " .. binds_provider_name)
  end
end

local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    })
  end
end

local toggle_inlay_hints = function()
  if type(vim.lsp.inlay_hint) ~= "nil" then
    if type(vim.lsp.inlay_hint.is_enabled) == "function" then
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end
  end
end

--- Maps that are not a `vim.lsp.Config` field. `vim.lsp.config` will not register these.
--- Goto maps (`gd`/`gr`/…) stay in the binds provider.
local set_shared_keys = function()
  local map = vim.keymap.set

  -- gd / gD / gr / gi / gt live in the binds provider (lsp_binds_builtin and friends).

  map("n", "K", function()
    return vim.lsp.buf.hover()
  end, { desc = "Hover" })
  map("n", "<C-k>", function()
    return vim.lsp.buf.signature_help()
  end, { desc = "Signature Help" })

  map({ "n", "x" }, "<Leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
  map({ "n", "x" }, "<Leader>lc", vim.lsp.codelens.run, { desc = "Run Codelens" })
  -- { "<Leader>lC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
  map("n", "<Leader>lC", function()
    vim.lsp.codelens.enable(true, { bufnr = vim.api.nvim_get_current_buf() })
  end, { desc = "Refresh & Display Codelens" })
  map("n", "<Leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
  -- { "<Leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
  map("n", "<Leader>lh", vim.diagnostic.open_float, { desc = "Float" })

  ------------

  -- >ld and >lD handled by Snacks!

  -- { "<Leader>cA", LazyVim.lsp.action.source, desc = "Source Action", has = "codeAction" },

  -- TODO: [URGENT] : move this away from snacks stuff, and use builtin's that enforce qf/loc list jumps! (or via trouble or quicker or w/e)
  -- { "]]", function() Snacks.words.jump(vim.v.count1) end, has = "documentHighlight",
  -- desc = "Next Reference", enabled = function() return Snacks.words.is_enabled() end },
  -- { "[[", function() Snacks.words.jump(-vim.v.count1) end, has = "documentHighlight",
  -- desc = "Prev Reference", enabled = function() return Snacks.words.is_enabled() end },

  -- { "[[", function()
  --   -- if the qf list or location list is open, navigate that instead of buffers
  --   local ql = require("utils").list.find_qf("q")
  --   -- dd(ql)
  --   if #ql > 0 then
  --     return vim.cmd.cprev()
  --   end
  --   local ll = require("utils").list.find_qf("l")
  --   if #ll > 0 then
  --     return vim.cmd.lprev()
  --   end
  -- end, { desc = "Prev item in LIST" }},
  --
  -- { "]]", function()
  --   -- if the qf list or location list is open, navigate that instead of buffers
  --   local ql = require("utils").list.find_qf("q")
  --   if #ql > 0 then
  --     return vim.cmd.cnext()
  --   end
  --   local ll = require("utils").list.find_qf("l")
  --   if #ll > 0 then
  --     return vim.cmd.lnext()
  --   end
  -- end, { desc = "Next item in LIST" }},

  -- { "n", "[q", vim.cmd.cprev,  desc = "Previous Quickfix" },
  -- { "n", "]q", vim.cmd.cnext,  desc = "Next Quickfix" },

  map("n", "[[", vim.cmd.cprev, { desc = "Previous Quickfix" })
  map("n", "]]", vim.cmd.cnext, { desc = "Next Quickfix" })

  map("n", "<a-n>", function()
    Snacks.words.jump(vim.v.count1, true)
  end, { desc = "Next Reference" })
  -- has = "documentHighlight", enabled = function() return Snacks.words.is_enabled() end
  map("n", "<a-p>", function()
    Snacks.words.jump(-vim.v.count1, true)
  end, { desc = "Prev Reference" })
  -- has = "documentHighlight", enabled = function() return Snacks.words.is_enabled() end

  map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
  map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
  map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
  map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
  map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
  map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

  map("n", "<Leader>ti", toggle_inlay_hints, { desc = "[T]oggle [I]nlay hints" })
end

return {
  ---@type PluginSpec
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { "mason-org/mason-lspconfig.nvim", config = function() end }, -- 'nil' to basically clear opts, kinda
    },

    -- Maps have to exist before the first buffer. `config` waits on BufReadPre.
    init = function()
      apply_keys(vim.g.lsp_binds_type or "builtin")
      set_shared_keys()
    end,

    ---@return LSPConfigReturn
    opts = function()
      ---@class LSPConfigReturn
      local ret = {
        --
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          -- virtual_lines = true,
          virtual_text = true,
          update_in_insert = false,
          severity_sort = true,
          float = {
            border = "single",
            source = true,
          },
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = "󰅚 ",
              [vim.diagnostic.severity.WARN] = "󰀪 ",
              [vim.diagnostic.severity.INFO] = "󰋽 ",
              [vim.diagnostic.severity.HINT] = "󰌶 ",
            },
            numhl = {
              [vim.diagnostic.severity.ERROR] = "ErrorMsg",
              [vim.diagnostic.severity.WARN] = "WarningMsg",
            },
          },
        }, -- END ret.diagnostics

        inlay_hints = {
          enabled = true,
          exclude = {
            "markdown",
            "help",
            "text",
            "json",
            "yaml",
            "toml",
          },
        },
        codelens = {
          enabled = false,
        },
        folds = {
          enabled = false, -- ufo.nvim handles folds
        },

        format = {
          -- async = false,
          formatting_options = {
            async = false,
          },
          timeout_ms = nil,
        },

        servers = {
          ["*"] = {
            capabilities = get_default_capabilities(),
          },

          -- NOTE: Alternative here is inside of config's `opts`
          --  We simply have an 'exclude' list -> excluded_lsps[<foo>] = { enabled = false } thing
          -- Otherwise we just let layering (refer to root level init.lua)
          -- Or -- more likely, `mason-lspconfig.nvim` automatic_enable.exclude = { ... }' handle this.

          -- stylua = { enabled = false }, -- not as an lsp!
          -- tsserver = { enabled = false }, -- handled by pmizio/typescript-tools.nvim

          -- ts_ls = { enabled = false }, -- handled by pmizio/typescript-tools.nvim
        }, -- END ret.servers

        -- keys = apply_keys(vim.g.lsp_binds_type or "builtin"), -- TODO: make this a config option, and allow for fzf/snacks/etc

        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts: vim.lsp.Config):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
        -------------
      } -- END ret

      ---@return LSPConfigReturn
      return ret
    end,

    ---@param opts LSPConfigReturn
    config = function(_, opts)
      --

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- TEST: [overlap] : I don't think this is needed when using
      -- mason-tool-installer and delegating everything down to it.
      if opts.servers["*"] then
        vim.lsp.config("*", { capabilities = opts.servers["*"].capabilities })
      end

      -- NOTE: technically we should be doing a preload/package check here for `mason-lspconfig.nvim`
      -- and just pcall(require, mason-lspconfig) &
      -- call setup() on it, but we already have a dependency on it, so it's fine.

      ---------
    end,
  }, -- END nvim-lspconfig

  {
    "mason-org/mason.nvim", -- UI/Market
    cmd = "Mason",
    --------------- -- lazy = true,
    build = ":MasonUpdate",
    -- function() vim.cmd("Mason") end,
    keys = { { "<Leader>pm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {},
  }, -- END mason.nvim

  {
    "mason-org/mason-lspconfig.nvim", -- Traqnslates
    -- A) nvim-lspconfig <--> mason.nvim names.
    -- B) Handles the `mason install -> vim.lsp.enable()` flow.
    ------------------ -- lazy = true,
    lazy = true,
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { "neovim/nvim-lspconfig" }, ------------------ -- lazy = true
    },
    opts = {
      -- these MUST be actual lspconfig names, not mason (or even mason-lspconfig translated names)!
      automatic_enable = {
        -- Blacklist, says 'start every installed server, except these ones'
        exclude = {
          "c3_lsp",
          "rust_analyzer", -- handled `mrcjkb/rustaceanvim`
          "ts_ls", -- typescript-language-server, handled by `pmizio/typescript-tools.nvim`
          "tsc", -- TS 7 `tsc --lsp`. Not the tsserver typescript-tools drives. Doubles `gd`.
          "biome", -- installed for format/lint not started as LSP
        },
      },
    },

    config = function(_, opts)
      -- TODO: [automatic] : may want to modify the opts.automatic_enable stuff ?

      require("mason-lspconfig").setup(opts)
    end,
  }, -- END mason-lspconfig.nvim

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim", -- Extends -
    -- Two part:
    --  A) Allows handing anything available in Mason into the ensure_installed opts
    --      if `integrations.["mason-lspconfig"] = true`, then those can be either name type
    --      Similar for mason-nvim-dap as well
    --  B) Allows conditionals inside of it's ensure_installed table.
    --      Entirely replaaces the WHITELIST approach of mason-lspconfig.nvim, and allows for more complex logic.
    --
    lazy = false,
    event = "VeryLazy",
    dependencies = {
      -- { "mason-org/mason.nvim", lazy = true },
      -- { "mason-org/mason-lspconfig.nvim", lazy = true },
      -- { "mfussenegger/nvim-dap", lazy = true },
      { "mason-org/mason.nvim" },
      { "mason-org/mason-lspconfig.nvim" },
      { "mfussenegger/nvim-dap", lazy = true },
    },

    -- opts_extend = { "ensure_installed" },

    opts = {
      -- ensure_installed = require("lang_tables").mason_all(),
      ensure_installed = installables.flatten(),
      auto_update = true,
      run_on_start = true,
      start_delay = 3000,
      de_bounce_hours = 10, -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce. Used only if run_on_start is true.

      -- interop for naming conventions between tools
      integrations = {
        ["mason-lspconfig"] = true,
        ["mason-null-ls"] = false,
        ["mason-nvim-dap"] = true,
      },
    },
    -- end,
  }, -- END mason-tool-installer.nvim
}
