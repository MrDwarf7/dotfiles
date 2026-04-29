---@alias BindsLiteral "fzf" | "builtin" | "snacks"

---@enum BindsTypeE
local BindsTypeE = {
  fzf = "fzf",
  builtin = "builtin",
  snacks = "snacks",
}
setmetatable(BindsTypeE, {
  __call = function(_, value)
    if type(value) == "string" then
      for _, v in pairs(BindsTypeE) do
        if v == value then
          return v
        end
      end
    elseif type(value) == "table" and value.__enum == "BindsTypeE" then
      return value
    end

    error("Invalid BindsType: " .. tostring(value))
  end,
  __enum = "BindsTypeE",
})

---@alias BindsType BindsLiteral|BindsTypeE

---@class config.LSP.Opts
---@field binds_type? BindsType|nil
---@field get_capabilities? fun(): table<string, any>|nil
---
--- This will cause the funcion given to run over the default keybindings,
--- allowing you to define your own function that maps out the keys
--- ( remember to include gd, gf etc. also)
---@field setup_lsp? fun(binds_type?: BindsType)|nil

---@class config.LSP
--- fields
---@field binds_type? BindsType -- Store it for later
---
--- assigned fields as func's
---@field get_capabilities? fun(): table<string, any>
---
---
---@field capabilities? table<string, any>
---
---
--- methods
-- ---@field handle_binds_type fun(binds_type?: BindsType): BindsLiteral
---@field get_default_capabilities fun(): table<string, any>
-- ---@field fzf_lua_binds fun()
-- ---@field builtin_binds fun()
-- ---@field setup_lsp_binds fun(self: config.LSP, binds_type?: BindsType)
---@field setup fun(opts?: config.LSP.Opts): config.LSP
local LSP = {
  capabilities = nil,
  get_capabilities = nil,
}

---@param binds_type BindsType|nil
---@return BindsLiteral
local function handle_binds_type(binds_type)
  local bt = nil

  if type(binds_type) == "nil" then
    ---@cast binds_type BindsLiteral
    bt = BindsTypeE.builtin
    -- return "builtin"
  end

  if type(binds_type) == "table" then
    -- convert to string
    if type(binds_type) == "table" and binds_type.__enum == "BindsTypeE" then
      -- if binds_type == BindsTypeE.fzf then
      bt = BindsTypeE.fzf
      -- return "fzf"
      -- elseif binds_type == BindsTypeE.snacks then
    elseif type(binds_type) == "table" and binds_type.__enum == "BindsTypeE" and binds_type == BindsTypeE.snacks then
      bt = BindsTypeE.snacks
      -- return "snacks"
    else
      bt = BindsTypeE.builtin
      -- return "builtin"
    end
  elseif type(binds_type) == "string" then
    ---@cast binds_type BindsLiteral
    bt = binds_type
    -- return binds_type
  end

  -- LSP.binds_type = bt

  -- ---@cast binds_type BindsLiteral
  -- return "builtin"

  if bt ~= nil then
    return bt
  end

  require("utils").output.warn("LSP:handle_binds_type: unknown binds_type, defaulting to 'builtin'")
  return BindsTypeE.builtin
end

function LSP.get_default_capabilities()
  local capabilities = {}

  local blink_cmp_ok, blink_cmp = pcall(require, "blink.cmp")
  if blink_cmp_ok then
    capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      blink_cmp.get_lsp_capabilities({
        textDocument = {
          completion = {
            snippetSupport = true,
          },
        },
      }, true)
    )
  else
    capabilities = vim.lsp.protocol.make_client_capabilities()
  end

  -- required by nvim-ufo -- we don't use it atm tho
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  -- LSP.capabilities = capabilities
  return capabilities
end

---@class config.LSP.handle_builtins.Opts
---@field method? string
---@field operation? fun(): nil

local function setup_lsp_binds(binds_type)
  -- Folke's impl. in snacks for adding (pushing) an item to the tag stack
  -- https://github.com/folke/snacks.nvim/blob/fe7cfe9800a182274d0f868a74b7263b8c0c020b/lua/snacks/picker/actions.lua#L35-L102

  -- Neovim's default LSP behaviour for adding to tag stack (on lsp jumps)
  -- https://github.com/neovim/neovim/blob/ac3859a4410e50794a083f23796e4f8ae2a24b04/runtime/lua/vim/lsp/buf.lua#L179-L239

  if binds_type == BindsTypeE.fzf then
    require("config.lsp_binds_fzf").setup()
  elseif binds_type == BindsTypeE.snacks then
    require("config.lsp_binds_snacks").setup()
  elseif binds_type == BindsTypeE.builtin then
    require("config.lsp_binds_builtin").setup()
  else -- default/fall-through case
    require("config.lsp_binds_builtin").setup()
  end

  local map = function(lhs, rhs, opts)
    vim.keymap.set("n", lhs, rhs, opts)
  end

  map("<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  map("<leader>la", vim.lsp.buf.code_action, { desc = "Lsp Action" })
  map("<leader>lc", vim.lsp.codelens.run, { desc = "CodeLens" })
  map("<leader>lC", function()
    vim.lsp.codelens.enable(true, { bufnr = vim.api.nvim_get_current_buf() })
  end, { desc = "Refresh & Display Codelens" })
  map("<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
  map("<Leader>lh", vim.diagnostic.open_float, { desc = "float" })
  map("<Leader>lf", function()
    if package.loaded["conform"] then
      local conform = require("conform")
      conform.format({ timeout_ms = 3000 })
    else
      -- elseif package.loaded["conform"] == nil then
      return vim.lsp.buf.format({ async = false })
    end
  end, { desc = "format [lspconfig]" })

  -- and then enable **_ALL_** the servers found

  map("[[", function()
    -- if the qf list or location list is open, navigate that instead of buffers
    local ql = require("utils").list.find_qf("q")
    dd(ql)
    if #ql > 0 then
      return vim.cmd.cprev()
    end
    local ll = require("utils").list.find_qf("l")
    if #ll > 0 then
      return vim.cmd.lprev()
    end
  end, { desc = "Prev item in LIST" })

  map("]]", function()
    -- if the qf list or location list is open, navigate that instead of buffers
    local ql = require("utils").list.find_qf("q")
    if #ql > 0 then
      return vim.cmd.cnext()
    end
    local ll = require("utils").list.find_qf("l")
    if #ll > 0 then
      return vim.cmd.lnext()
    end
  end, { desc = "Next item in LIST" })

  -- local servers = require("lang_tables").get("mason", "lsps", "all")
  -- vim.lsp.enable(servers, true)
  --
  -- vim.lsp.config("*", {
  --   capabilities = LSP:get_default_capabilities(),
  -- })
end

local clear_defaults = function()
  for _, bind in ipairs({ "grn", "gra", "gri", "grr", "grt" }) do
    pcall(vim.keymap.del, "n", bind)
  end
end

---@param client vim.lsp.Client
---@param client_name? string Will default to client.name if not provided
---@param server_capabilities_index string
---@param value_as? any|nil
local disable_capability = function(client, client_name, server_capabilities_index, value_as)
  if not client_name or type(client_name) ~= "string" then
    client_name = client.name
  end
  if client.name == client_name then
    -- client.server_capabilities[server_capabilities_index] = value_as or nil
    client.server_capabilities[server_capabilities_index] = value_as or nil
  end
end

---@type integer
local config_lsp_groud_id = vim.api.nvim_create_augroup("ConfigLSP", { clear = true })

---@param opts config.LSP.Opts
---@param lsp config.LSP
local lsp_attach_autocmd = function(opts, lsp)
  -- Do a couple of things on attach:
  -- 2. diable semantic tokens
  -- 3. setup lsp binds
  -- 4. disable hover provider for ruff
  --
  -- Secondly we also
  -- Setup an autocmd for detach, to clear highlights and autocmds on detach
  -- artefacts (otherwise we get 'stuck' highlights when the server detaches but the buffer is still open)
  --

  -- local config_lsp_groud_id = vim.api.nvim_create_augroup("ConfigLSP", { clear = true })

  local setup_binds = function()
    if opts.setup_lsp and type(opts.setup_lsp) == "function" then
      opts.setup_lsp(opts.binds_type)
      return
    end
    if not opts.setup_lsp or opts.setup_lsp == nil then
      setup_lsp_binds(opts.binds_type)
      return
    end
    -- require("utils").output.warn("opts.setup_lsp is not a function")
    -- return nil
  end

  ---@param client vim.lsp.Client
  local conf_fn = function(client)
    vim.lsp.config[client.name] = {
      capabilities = lsp.capabilities or lsp.get_capabilities(),
      flags = {
        -- debounce_text_changes = 200, -- default is 150ms but it'll show things like buffer comp. for a split second
        debounce_text_changes = 500,
      },
    }
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    group = config_lsp_groud_id,
    callback = function(ctx)
      pcall(vim.treesitter.start, ctx.buf, vim.bo.filetype)

      local client = vim.lsp.get_client_by_id(ctx.data.client_id)
      if not client then
        require("utils").output.warn("LSP client not found for id: " .. tostring(ctx.data.client_id))
        return
      end

      conf_fn(client)

      -- vim.lsp.config[client.name] = {
      --   capabilities = lsp.capabilities or lsp.get_capabilities(),
      --   flags = {
      --     -- debounce_text_changes = 200, -- default is 150ms but it'll show things like buffer comp. for a split second
      --     debounce_text_changes = 500,
      --   },
      -- }

      disable_capability(client, nil, "semanticTokensProvider", nil)
      disable_capability(client, "ruff", "hoverProvider", false)
      -- client.server_capabilities.semanticTokensProvider = nil

      pcall(setup_binds)

      -- if not opts.setup_lsp or opts.setup_lsp == nil then
      --   setup_lsp_binds(opts.binds_type)
      -- elseif opts.setup_lsp and type(opts.setup_lsp) == "function" then
      --   opts.setup_lsp(opts.binds_type)
      -- else
      --   require("utils").output.warn("opts.setup_lsp is not a function")
      --   return nil
      -- end
    end,
    -- nested = true,
    desc = "Configure buffer keymap and behaviour based on LSP",
  })
end

function LSP.setup(opts)
  opts = opts or {}
  opts.binds_type = opts.binds_type or handle_binds_type(opts.binds_type)

  LSP.binds_type = opts.binds_type

  clear_defaults()

  if opts.get_capabilities and type(opts.get_capabilities) == "function" then
    LSP.get_capabilities = opts.get_capabilities
  else
    LSP.get_capabilities = LSP.get_default_capabilities
  end
  LSP.capabilities = LSP.get_capabilities()

  lsp_attach_autocmd(opts, LSP)

  vim.diagnostic.config({
    -- virtual_lines = true,
    virtual_text = true,
    underline = true,
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
  })

  ---@type config.LSP
  LSP = setmetatable(LSP, {
    __index = function(table, key)
      return rawget(table, key)
    end,
    binds_type = opts.binds_type,
    -- get_capabilities = opts.get_capabilities,
    -- capabilities = capabilities,
  })

  return LSP
end

---@return config.LSP
return LSP
