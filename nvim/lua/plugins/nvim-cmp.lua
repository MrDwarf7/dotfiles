-- return {
--    { "hrsh7th/nvim-cmp" },
--    event = "InsertEnter",
--    dependencies = {
--       "hrsh7th/cmp-buffer",
--       "hrsh7th/cmp-path",
--       "L3MON4D3/LuaSnip",
--       "saadparwaiz1/cmp_luasnip",
--       "rafamadriz/friendly-snippets",
--    },
--    config = function()
--       local cmp = require("cmp")
--
--       local luasnip = require("luasnip")
--       -- Loads vscode style snippets from installed plugins (so here it's friendly snippets)
--       require("luasnip.loaders.from_vscode").lazy_load()
--
--       cmp.setup({
--          completion = {
--             completeopt = "menu,menuone,preview,noselect", -- Info via :h completeopt
--          },
--          snippet = { --configure how nvim-cmp interacts with snippet engine
--             expand = function(args)
--             luasnip.lsp_expand(args.body)
--             end,
--          },
--          mapping = cmp.mapping.preset .insert({
--             ["<C-k>"] = cmp.mapping.select_prev_item(),
--             ["<C-j>"] = cmp.mapping.select_prev_item(),
--             ["<C-n>"] = cmp.mapping.scroll_docs(-4),
--             ["<C-p>"] = cmp.mapping.scroll_docs(4),
--             ["<C-Space>"] = cmp.mapping.complete(),
--             ["<C-e>"] = cmp.mapping.abort(),
--             ["<CR>"] = cmp.mapping.confirm({ select = false }),
--          }),
--          -- Sources for autocompletion
--          -- This also handles priority of the recommendations and can be changed to suite
--          sources = cmp.config.sources({
--             { name = "luasnip" },--snippets
--             { name = "buffer" }, --text within current buffer
--             { name = "path" }, --file system paths
--          }),
--       })
--    end,
-- }


return {
   {
      "hrsh7th/nvim-cmp",
      dependencies = {
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-nvim-lua",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-cmdline",
         "hrsh7th/cmp-buffer",
         "L3MON4D3/LuaSnip",
         "saadparwaiz1/cmp_luasnip",
         "onsails/lspkind.nvim",

      "rafamadriz/friendly-snippets",

      },
      config = function()
         local ls = require("luasnip")
         vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
         vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

         local lspkind = require("lspkind")
         local cmp = require("cmp")
         cmp.setup({
            snippet = {
               expand = function(args)
                  require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
               end,
            },
            window = {
               completion = cmp.config.window.bordered(),
               documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
               ["<C-b>"] = cmp.mapping.scroll_docs(-4),
               ["<C-f>"] = cmp.mapping.scroll_docs(4),
               ["<CR>"] = cmp.mapping.confirm({ select = true }),
               ["<Tab>"] = cmp.mapping.select_next_item(),
               ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            }),
            sources = cmp.config.sources({
               { name = "nvim_lsp" },
               { name = "luasnip" },
               { name = "nvim_lua" },
               { name = "buffer" },
      { name = "luasnip" },--snippets
            }),
            enabled = function()
               -- disable completion in comments
               local context = require("cmp.config.context")

               -- keep command mode completion enabled
               if vim.api.nvim_get_mode().mode == "c" then
                  return true
               else
                  return not context.in_treesitter_capture("comment")
                     and not context.in_syntax_group("Comment")
               end
            end,
            formatting = {
               format = lspkind.cmp_format({
                  mode = "symbol_text",
                  maxwidth = 50,
                  ellipsis_char = "...",
                  menu = {
                     buffer = "[Buffer]",
                     nvim_lsp = "[LSP]",
                     nvim_lua = "[Lua]",
                     luasnip = "[LuaSnip]",
                     latex_symbols = "[Latex]",
                  },
               }),
            },
         })

         cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
               { name = "buffer" },
            },
         })

         cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
               { { name = "path" } },
               { { name = "cmdline" } }
            ),
         })
      end,
   },
}
