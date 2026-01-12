---@alias BindsLiteral "fzf" | "builtin" | "snacks"

---@enum BindsTypeE
local BindsTypeE = {
  fzf = "fzf",
  builtin = "builtin",
  snacks = "snacks",
}

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
--- methods
---@field handle_binds_type fun(self: config.LSP, binds_type?: BindsType): BindsLiteral
---@field get_default_capabilities fun(self: config.LSP): table<string, any>
---@field fzf_lua_binds fun()
---@field builtin_binds fun()
---@field setup_lsp fun(self: config.LSP, binds_type?: BindsType)
---@field setup fun(opts?: config.LSP.Opts): config.LSP
local LSP = {}

function LSP:handle_binds_type(binds_type)
  local bt = nil

  if type(binds_type) == "nil" then
    ---@cast binds_type BindsLiteral
    bt = BindsTypeE.builtin
    -- return "builtin"
  end

  if type(binds_type) == "table" then
    -- convert to string
    if binds_type == BindsTypeE.fzf then
      bt = BindsTypeE.fzf
      -- return "fzf"
    elseif binds_type == BindsTypeE.snacks then
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

  self.binds_type = bt

  -- ---@cast binds_type BindsLiteral
  -- return "builtin"

  if bt ~= nil then
    return bt
  end

  require("utils").output.warn("LSP:handle_binds_type: unknown binds_type, defaulting to 'builtin'")
  return BindsTypeE.builtin
end

function LSP:get_default_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- required by nvim-ufo -- we don't use it atm tho
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end

---@class config.LSP.handle_builtins.Opts
---@field method? string
---@field operation? fun(): nil

function LSP.builtin()
  local map = require("config.keymaps")
  local tsutils = require("utils.tsutils")
  local handle_builtins = tsutils.handle_builtins

  -- stylua: ignore start
  -- map("n", "gd", function() handle_builtins({ method = "textDocument/definition" }) end,
  map("n", "gd", function() handle_builtins({ operation = vim.lsp.buf.definition }) end,
    { desc = "[G]oto [d]efinition" })

  -- map("n", "gD", function() handle_builtins({ method = "textDocument/declaration" }) end,
  map("n", "gD", function() handle_builtins({ operation = vim.lsp.buf.declaration }) end,
    { desc = "[G]oto [D]eclaration" })

  -- map("n", "gr", function() handle_builtins({ method = "textDocument/references" }) end,
  map("n", "gr", function() handle_builtins({ operation = vim.lsp.buf.references }) end,
    { desc = "[G]oto [r]eferences" })

  -- map("n", "gt", function() handle_builtins({ method = "textDocument/typeDefinition" }) end,
  map("n", "gt", function()
      handle_builtins({ operation = vim.lsp.buf.type_definition })
    end,
    { desc = "[G]oto [t]ype Definition" })

  map("n", "gi", function() handle_builtins({ operation = vim.lsp.buf.implementation }) end,
    { desc = "[G]oto [I]mpl" })

  map("n", "]]", function()
    local cnext_op = function() vim.cmd("cnext") end
    tsutils.handle_builtins({ operation = cnext_op })
  end, { silent = true, desc = "qf next" })

  map("n", "[[", function()
    local cprev_op = function() vim.cmd("cprev") end
    tsutils.handle_builtins({ operation = cprev_op })
  end, { silent = true, desc = "qf prev" })
  -- stylua: ignore end
end

function LSP.fzf_lua_binds()
  local map = vim.keymap.set

  map("n", "gd", function()
    require("fzf-lua").lsp_definitions({ jump1 = true, ignore_current_line = true })
  end, { desc = "[G]oto [d]efinition" })
  map("n", "gD", function()
    require("fzf-lua").lsp_declarations({ jump1 = true, ignore_current_line = true })
  end, { desc = "Goto T[y]pe Definition" })
  map("n", "gr", function()
    require("fzf-lua").lsp_references({ jump1 = true, ignore_current_line = true })
  end, { desc = "[G]oto [r]eferences" })
  map("n", "gt", function()
    require("fzf-lua").lsp_typedefs({ jump1 = true, ignore_current_line = true })
  end, { desc = "Goto T[y]pe Definition" })
  map("n", "gi", function()
    require("fzf-lua").lsp_implementations({ jump1 = true, ignore_current_line = true })
  end, { desc = "[G]oto [I]mpl" })
end

function LSP.snacks_binds()
  local Snacks = require("snacks")

  ---@type snacks.picker.Config
  local opts = {
    --
    auto_confirm = true,
    show_delay = 0,
    jump = {
      tagstack = true,
      reuse_win = false,
    },
    jump1 = true,
  }

  local map = vim.keymap.set
  -- stylua: ignore start
  map("n", "gd", function() Snacks.picker.lsp_definitions(opts) end, { desc = "Snacks Goto Definition" })
  map("n", "gD", function() Snacks.picker.lsp_declarations(opts) end, { desc = "Snacks Goto Declaration" })
  map("n", "gr", function() Snacks.picker.lsp_references(opts) end, { nowait = true, desc = "Snacks References" })
  map("n", "gi", function() Snacks.picker.lsp_implementations(opts) end, { desc = "Snacks Goto Implementation" })
  map("n", "gt", function() Snacks.picker.lsp_type_definitions(opts) end,{ desc = "Snacks Goto T[y]pe Definition" })
  map("n", "gai", function() Snacks.picker.lsp_incoming_calls(opts) end, { desc = "Snacks C[a]lls Incoming" })
  map("n", "gao", function() Snacks.picker.lsp_outgoing_calls(opts) end, { desc = "Snacks C[a]lls Outgoing" })
  map("n", "<Leader>ls", function() Snacks.picker.lsp_symbols(opts) end, { desc = "Snacks LSP Symbols" })
  map("n", "<Leader>lS", function() Snacks.picker.lsp_workspace_symbols(opts) end, { desc = "Snacks LSP Workspace Symbols" })
  map("n", "<Leader>l`", function() Snacks.picker.lsp_config(opts) end, { desc = "Snacks Pulls up the capabilities of various LSP servers" })
  -- stylua: ignore end
end

function LSP:setup_lsp()
  local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
  local lsp_servers = {}

  if vim.fn.isdirectory(lsp_dir) == 1 then
    for _, file in ipairs(vim.fn.readdir(lsp_dir)) do
      if file:match("%.lua$") and file ~= "init.lua" and not file:match("^_.*%.lua$") then
        local server_name = file:gsub("%.lua$", "")
        -- if not vim.tbl_contains(already_found, server_name) and not already_found[server_name] then -- skip auto-discovered servers
        --   table.insert(lsp_servers, server_name)
        -- end
        table.insert(lsp_servers, server_name)
      end
    end
  end

  -- lsp_servers = vim.tbl_filter(function(server)
  --   return not already_found[server]
  -- end, lsp_servers)

  -- figure out if it's a
  -- BindsLiteral, or BindsTypeE
  -- it'll now always be a string here --
  -- binds_type = self.binds_type or self:handle_binds_type(binds_type)
  -- binds_type or LSP:handle_binds_type(binds_type)

  -- Folke's impl. in snacks for adding (pushing) an item to the tag stack
  -- https://github.com/folke/snacks.nvim/blob/fe7cfe9800a182274d0f868a74b7263b8c0c020b/lua/snacks/picker/actions.lua#L35-L102

  -- Neovim's default LSP behaviour for adding to tag stack (on lsp jumps)
  -- https://github.com/neovim/neovim/blob/ac3859a4410e50794a083f23796e4f8ae2a24b04/runtime/lua/vim/lsp/buf.lua#L179-L239

  if self.binds_type == BindsTypeE.fzf then
    LSP.fzf_lua_binds()
  elseif self.binds_type == BindsTypeE.snacks then
    LSP.snacks_binds()
  elseif self.binds_type == BindsTypeE.builtin then
    LSP.builtin()
  else -- default/fall-through case
    LSP.builtin()
  end

  -- if type(binds_type) == "string" and binds_type == "fzf" then
  --   LSP.fzf_lua_binds()
  -- elseif type(binds_type) == "string" and binds_type == "builtin" then
  --   LSP.builtin()
  -- end

  local map = vim.keymap.set
  map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

  map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Lsp Action" })
  map("n", "<leader>lc", vim.lsp.codelens.run, { desc = "CodeLens" })
  map("n", "<leader>lC", vim.lsp.codelens.refresh, { desc = "Refresh & Display Codelens" })
  map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
  map("n", "<Leader>lh", vim.diagnostic.open_float, { desc = "float" })
  map("n", "<Leader>lf", function()
    -- return vim.lsp.buf.format({ async = false })
    if package.loaded["conform"] then
      local conform = require("conform")
      conform.format({ timeout_ms = 3000 })
    elseif package.loaded["conform"] == nil then
      return vim.lsp.buf.format({ async = false })
    end
  end, { desc = "format [lspconfig]" })

  -- and then enable **_ALL_** the servers found

  vim.lsp.enable(lsp_servers, true)
end

function LSP.setup(opts)
  opts = opts or {}
  opts.binds_type = opts.binds_type or LSP:handle_binds_type(opts.binds_type)
  -- local binds_type = opts.binds_type

  -- if type(binds_type) == "nil" then
  --   binds_type = "fzf"
  -- end

  -- remove all default binds
  for _, bind in ipairs({ "grn", "gra", "gri", "grr", "grt" }) do
    pcall(vim.keymap.del, "n", bind)
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ctx)
      -- local client = assert(vim.lsp.get_client_by_id(ctx.data.client_id))
      local client = vim.lsp.get_client_by_id(ctx.data.client_id)
      if not client then
        require("utils").output.warn("LSP client not found for id: " .. tostring(ctx.data.client_id))
        return
      end

      --- Disable semantic tokens
      ---@diagnostic disable-next-line need-check-nil
      client.server_capabilities.semanticTokensProvider = nil

      if not opts.setup_lsp or opts.setup_lsp == nil then
        LSP:setup_lsp()
      elseif opts.setup_lsp and type(opts.setup_lsp) == "function" then
        opts.setup_lsp(opts.binds_type)
      else
        require("utils").output.warn("opts.setup_lsp is not a function")
        return nil
      end

      if client.name == "ruff" then
        client.server_capabilities.hoverProvider = false
      end

      if client.server_capabilities.documentHighlightProvider then
        local gid = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_create_autocmd("CursorHold", {
          group = gid,
          buffer = ctx.buf,
          callback = function()
            vim.lsp.buf.document_highlight()
          end,
        })

        vim.api.nvim_create_autocmd("CursorMoved", {
          group = gid,
          buffer = ctx.buf,
          callback = function()
            vim.lsp.buf.clear_references()
          end,
        })
      end
    end,
    nested = true,
    desc = "Configure buffer keymap and behaviour based on LSP",
  })

  local capabilities = nil
  if opts.get_capabilities and type(opts.get_capabilities) == "function" then
    capabilities = opts.get_capabilities()
  else
    capabilities = LSP:get_default_capabilities()
  end

  ---@type vim.lsp.config
  vim.lsp.config("*", {
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 500,
    },
  })
  -- LSP.binds_type = opts.binds_type
  -- LSP.get_capabilities = opts.get_capabilities

  ---@type config.LSP
  setmetatable(LSP, {
    __index = function(table, key)
      return rawget(table, key)
    end,
    binds_type = opts.binds_type,
    get_capabilities = opts.get_capabilities,
    capabilities = capabilities,
  })

  return LSP
end

---@return config.LSP
return LSP
