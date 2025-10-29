---@class LSP.Opts
---@field binds_type? BindsType

local LSP = {}

LSP.get_default_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- required by nvim-ufo -- we don't use it atm tho
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end

function LSP.fzf_lua_binds()
  local map = vim.keymap.set

	-- stylua: ignore start
	map("n", "gd", "<CMD>FzfLua lsp_definitions jump1=true ignore_current_line=true<CR>",
		{ desc = "[G]oto [d]efinition" })
	map("n", "gD", "<CMD>FzfLua lsp_declarations jump1=true ignore_current_line=true<CR>",
		{ desc = "Goto T[y]pe Definition" })
	map("n", "gr", "<CMD>FzfLua lsp_references jump1=true ignore_current_line=true<CR>",
		{ desc = "[G]oto [r]eferences" })
	map("n", "gt", "<CMD>FzfLua lsp_typedefs jump1=true ignore_current_line=true<CR>",
		{ desc = "Goto T[y]pe Definition" })
	map("n", "gi", "<CMD>FzfLua lsp_implementations jump1=true ignore_current_line=true<CR>",
		{ desc = "[G]oto [I]mpl" })
  -- stylua: ignore end
end

function LSP.builtin()
  local map = vim.keymap.set
	-- stylua: ignore start
	map("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [d]efinition" })
	map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto T[y]pe Definition" })
	map("n", "gr", vim.lsp.buf.references, { desc = "[G]oto [r]eferences" })
	map("n", "gt", vim.lsp.buf.type_definition, { desc = "Goto T[y]pe Definition" })
	map("n", "gi", vim.lsp.buf.implementation, { desc = "[G]oto [I]mpl" })
  -- stylua: ignore end
end

---@alias BindsType "fzf" | "builtin"

---@param binds_type? BindsType
function LSP.setup_lsp(binds_type)
  local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
  local lsp_servers = {}

  if vim.fn.isdirectory(lsp_dir) == 1 then
    for _, file in ipairs(vim.fn.readdir(lsp_dir)) do
      if file:match("%.lua$") and file ~= "init.lua" and not file:match("^_.*%.lua$") then
        local server_name = file:gsub("%.lua$", "")
        table.insert(lsp_servers, server_name)
      end
    end
  end

  -- handle nil case
  if not binds_type then
    binds_type = "builtin"
  end

  if type(binds_type) == "string" and binds_type == "fzf" then
    LSP.fzf_lua_binds()
  elseif type(binds_type) == "string" and binds_type == "builtin" then
    LSP.builtin()
  end

  local map = vim.keymap.set
  map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

  map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Lsp Action" })
  map("n", "<leader>lc", vim.lsp.codelens.run, { desc = "CodeLens" })
  map("n", "<leader>lC", vim.lsp.codelens.refresh, { desc = "Refresh & Display Codelens" })
  map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
  map("n", "<Leader>lh", vim.diagnostic.open_float, { desc = "float" })
  map("n", "<Leader>lf", function()
    if package.loaded["conform"] then
      return require("conform").format()
    elseif package.loaded["conform"] == nil then
      pcall(require, "conform")
      return vim.lsp.buf.format({ async = true })
    end
  end, { desc = "format [lspconfig]" })

  vim.lsp.enable(lsp_servers)
end

---@param opts? LSP.Opts
function LSP.setup(opts)
  opts = opts or {}
  opts.binds_type = opts.binds_type or "builtin"
  local binds_type = opts.binds_type

  -- if type(binds_type) == "nil" then
  --   binds_type = "fzf"
  -- end

  -- remove all the weird default binds
  for _, bind in ipairs({ "grn", "gra", "gri", "grr", "grt" }) do
    pcall(vim.keymap.del, "n", bind)
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ctx)
      local client = assert(vim.lsp.get_client_by_id(ctx.data.client_id))
      if not client then
        return
      end

      --- Disable semantic tokens
      ---@diagnostic disable-next-line need-check-nil
      client.server_capabilities.semanticTokensProvider = nil

      LSP.setup_lsp(binds_type)
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

  local capabilities = LSP.get_default_capabilities()
  -- require("lsp_utils").get_default_capabilities()

  vim.lsp.config("*", {
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 500,
    },
  })
end

return LSP
