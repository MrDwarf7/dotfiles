---@alias BindsLiteral "fzf" | "builtin" | "snacks"

---@enum BindsTypeE
local BindsTypeE = {
  fzf = "fzf",
  builtin = "builtin",
  snacks = "snacks",
}

---@alias BindsType BindsLiteral|BindsTypeE

---@class config.LSP.Opts
---@field binds_type? BindsType
---@field get_capabilities? fun(): table<string, any>
---
--- This will cause the funcion given to run over the default keybindings,
--- allowing you to define your own function that maps out the keys
--- ( remember to include gd, gf etc. also)
---@field setup_lsp? fun(binds_type?: BindsType)
---
---@class config.LSP
--- fields
---@field binds_type? BindsType -- Store it for later
---
--- assigned fields as func's
---@field get_capabilities? fun(): table<string, any>
---
--- methods
---@field handle_binds_type fun(binds_type?: BindsType): BindsLiteral
---@field get_default_capabilities fun(): table<string, any>
---@field fzf_lua_binds fun()
---@field builtin_binds fun()
---@field setup_lsp fun(binds_type?: BindsType)
---@field setup fun(opts?: config.LSP.Opts): config.LSP
local LSP = {}

function LSP.handle_binds_type(binds_type)
  if type(binds_type) == "nil" then
    ---@cast binds_type BindsLiteral
    return "builtin"
  end

  if type(binds_type) == "table" then
    -- convert to string
    if binds_type == BindsTypeE.fzf then
      return "fzf"
    elseif binds_type == BindsTypeE.snacks then
      return "snacks"
    else
      return "builtin"
    end
  elseif type(binds_type) == "string" then
    ---@cast binds_type BindsLiteral
    return binds_type
  end

  ---@cast binds_type BindsLiteral
  return "builtin"
end

LSP.get_default_capabilities = function()
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
    jump = {
      tagstack = true,
      reuse_win = false,
    },
    debug = {
      files = true,
    },
    -- on_show = function(picker)
    --   if picker:count() == 1 then
    --     local loc = picker.get()
    --     local encoding = vim.lsp.get_clients()[1].offset_encoding
    --     dd(loc)
    --     dd(encoding)
    --     vim.lsp.util.show_document(loc, encoding, { jump1 = true })
    --   else
    --     local i = picker:current()
    --     dd(i)
    --   end
    -- end,
  }

  local map = vim.keymap.set
  -- stylua: ignore start
  map("n", "gd", function() Snacks.picker.lsp_definitions(opts) end, { desc = "Goto Definition" })
  map("n", "gD", function() Snacks.picker.lsp_declarations(opts) end, { desc = "Goto Declaration" })
  map("n", "gr", function() Snacks.picker.lsp_references(opts) end, { nowait = true, desc = "References" })
  map("n", "gi", function() Snacks.picker.lsp_implementations(opts) end, { desc = "Goto Implementation" })
  map("n", "gt", function() Snacks.picker.lsp_type_definitions(opts) end,{ desc = "Goto T[y]pe Definition" })
  map("n", "gai", function() Snacks.picker.lsp_incoming_calls(opts) end, { desc = "C[a]lls Incoming" })
  map("n", "gao", function() Snacks.picker.lsp_outgoing_calls(opts) end, { desc = "C[a]lls Outgoing" })
  map("n", "<Leader>ls", function() Snacks.picker.lsp_symbols(opts) end, { desc = "LSP Symbols" })
  map("n", "<Leader>lS", function() Snacks.picker.lsp_workspace_symbols(opts) end, { desc = "LSP Workspace Symbols" })
  map("n", "<Leader>l`", function() Snacks.picker.lsp_config(opts) end, { desc = "Pulls up the capabilities of various LSP servers" })
  -- stylua: ignore end
end

function LSP.setup_lsp(binds_type)
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
  binds_type = LSP.handle_binds_type(binds_type)

  if binds_type == "fzf" then
    LSP.fzf_lua_binds()
  elseif binds_type == "snacks" then
    LSP.snacks_binds()
  else
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

  vim.lsp.enable(lsp_servers)
end

function LSP.setup(opts)
  opts = opts or {}
  opts.binds_type = LSP.handle_binds_type(opts.binds_type)
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

      local lsp_fn = nil
      if opts.setup_lsp and type(opts.setup_lsp) == "function" then
        lsp_fn = opts.setup_lsp
      else
        lsp_fn = LSP.setup_lsp
      end

      if type(lsp_fn) ~= "nil" then
        lsp_fn(opts.binds_type)
      else
        LSP.setup_lsp(opts.binds_type)
      end

      -- LSP.setup_lsp(binds_type)

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
    capabilities = LSP.get_default_capabilities()
  end

  vim.lsp.config("*", {
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 500,
    },
  })
  LSP.binds_type = opts.binds_type
  LSP.get_capabilities = opts.get_capabilities
  return LSP
end

---@return config.LSP
return LSP
