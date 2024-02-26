local highlight = vim.highlight
local lsp_buf = vim.lsp.buf
local map = vim.keymap.set
local lsp = vim.lsp

local opt = vim.opt
local fn = vim.fn
local g = vim.g

local M = {}

M.lsp_binds = function(opts, _extra_opts)
    map({ "n", "v" }, "<Leader>lA", function()
        lsp_buf.code_action()
    end, opts, { desc = "Code [a]ction" })

    map("n", "gd", function()
        lsp_buf.definition()
    end, opts, { desc = "[d]efinition" })

    map("n", "gD", function()
        lsp_buf.declaration()
    end, opts, { desc = "[D]eclaration" })

    map("n", "gi", function()
        lsp_buf.implementation()
    end, opts, { desc = "[i]mplementations" })

    map("n", "K", function()
        lsp_buf.hover()
    end, opts)

    map("n", "gr", function()
        lsp_buf.references()
    end, opts, { desc = "[r]eferences" })

    map("n", "<Leader>lR", function()
        lsp_buf.rename()
    end, opts, { desc = "[R]ename" })

    map("n", "<C-k>", function()
        lsp_buf.signature_help()
    end, opts, { desc = "Signature Help" })

    --------- Extra's

    map("n", "gI", function()
        lsp_buf.incoming_calls()
    end, opts, { desc = "[i]ncoming" })


    map("n", "gO", function()
        lsp_buf.outgoing_calls()
    end, opts, { desc = "[O]utgoing" })

    map("n", "gt", function()
        lsp_buf.type_definition()
    end, opts, { desc = "[T]ype" })

    ----- Diag calls

    map("n", "]d", function()
        vim.diagnostic.goto_next()
    end, opts, { desc = "[diag] next" })

    map("n", "[d", function()
        vim.diagnostic.goto_prev()
    end, opts, { desc = "[diag] prev" })

    map("n", "<Leader>lh", function()
        vim.diagnostic.open_float()
    end, opts, { desc = "[h]over" })

    ------ Misc - they should probably go into format related

    map("n", "<Leader>lf", function()
        lsp_buf.format({ async = true })
    end, opts, { desc = "[f]ormat (lsp)" })
    --
    _extra_opts = _extra_opts or {}
end


return M
