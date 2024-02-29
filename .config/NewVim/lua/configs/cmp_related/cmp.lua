if vim.opt.diff:get() then
    return
end

local M = {}

local cmp = require("cmp")

local cmp_deps = require("configs.cmp_related.cmp_deps")

local lspkind_formatting_style = cmp_deps.lspkind_setup()
local border = cmp_deps.cmp_boarder()
local mapping = cmp_deps.cmp_mappings(cmp)


M.cmp_setup_opts = function()
    local opts = {
        window = {
            completion = {
                completion = cmp.config.window.bordered(),
                winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
                scrollbar = false,
            },
            documentation = {
                border = border,
                winhighlight = "Normal:CmpDoc",
            },
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        preselect = cmp.PreselectMode.None,

        formatting = lspkind_formatting_style,

        mapping = mapping,

        sources = {
            { name = "copilot",           group_index = 2 },
            { name = "nvim_lsp",          group_index = 2 },
            { name = "luasnip",           group_index = 2 },
            { name = "buffer",            group_index = 2, max_item_count = 15 },
            { name = "nvim_lua",          group_index = 2 },
            { name = "path",              group_index = 2 },
            -- My additions here
            -- { name = "nvim_lsp_signature_help", group_index = 3 },
            { name = "cmp-git" },
            { name = "cmp-cmdline" },
            { name = "cmp-luasnip-choice" },

            { name = "crates" },
            { name = "cmp-pypi" },
        }
    }
    return opts
end



M.cmp_full_setup = function()
    local opts = M.cmp_setup_opts()
    cmp.setup(opts)
end



return M
