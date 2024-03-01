local cmd = vim.cmd
local lsp = vim.lsp
local map = vim.keymap.set
local opt_local = vim.opt_local

local current_buffer = vim.api.nvim_get_current_buf()

if vim.opt.diff:get() then
    cmd([[LspStop]])
    return
end

local nvim_lsp_windows = require("lspconfig.ui.windows")
local buffer_util = require("util.buffer")
local handlers = require("util.lsp-handlers")
local lsp_capabilities = require("util.lsp-capabilities")
local lsp_mappings = require("util.lsp-mappings")
local nvim_lsp = require("lspconfig")
local nvim_lsp_servers_list = require("configs.lsp_related.nvim-lsp-servers")

local M = {}

M.lsp_on_attach = function()
    if buffer_util.islarge(0) then
        print("(LSP) Large file detected, disabling LSP")
        cmd([[LspStop]])
    end

    vim.api.nvim_buf_set_option(current_buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")
    --
    ---- Because we are inside the on_attach we will be using -
    -- these keymaps should be called whenever a new server is attached
    -- Meaning that we should be able to use these keymaps for any server
    -- and override them if needed
    local opts = { buffer = current_buffer }

    map("n", "<Leader>lR", require("telescope.builtin").lsp_references, { desc = "[r]eferences" })
    map("n", "<Leader>ls", require("telescope.builtin").lsp_document_symbols, { desc = "[s]ymbols" })

    map("n", "<Leader>lS", function()
            require("telescope.builtin").lsp_workspace_symbols({
                query = vim.fn.input("Lsp Workspace Symbols> "),
            })
        end,
        { desc = "workspace [S]ymbols" })

    lsp_mappings.lsp_binds(opts)
end

-- Global global mappings
map("n", "<Leader>l%", ":LspRestart<CR>", { silent = false })

local global_lsp_opts = { buffer = current_buffer }
lsp_mappings.lsp_binds(global_lsp_opts)


-- adds border to lsp windows (ie: :LspInfo and stuff)
nvim_lsp_windows.default_options.border = "single"
lsp.handlers["textDocument/hover"] = handlers.hover
lsp.handlers["textDocument/signatureHelp"] = handlers.signature_help
lsp.handlers["textDocument/diagnostics_border"] = handlers.diagnostics_border

-- Boorder for the <leader>lh command
vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    signs = true,
    update_in_insert = true,
    float = { border = "single" }, -- This line
})

-- nvim-cmp completion plugin handles a LOT of LSP capabilities - we need to tell
-- the lang servers that we can do that
local capabilities = lsp_capabilities.default_capabilities()

nvim_lsp_servers_list.lsp_server_setups(M.lsp_on_attach, capabilities)
return M
