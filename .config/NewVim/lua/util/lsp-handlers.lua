local lsp = vim.lsp

local M = {}

M.hover = lsp.with(lsp.handlers.hover, {
    border = "single",
})

M.signature_help = lsp.with(lsp.handlers.signature_help, {
    border = "single",
})

M.diagnostics_border = lsp.with(lsp.handlers.diagnostic, {
    border = "single",
})


return M
