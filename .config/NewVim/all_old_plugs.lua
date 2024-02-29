-- TODO: wil probably have to move these back up into the main seciton, sadly.
-- May be able to move the table itself to a "standalone" file, to keep this cleaner.
-- but will have to remember the order the require(xyz) calls are made WILL affect the load order.

{ -- Start of namespace registrations

    "folke/tokyonight.nvim",
    "prichrd/netrw.nvim",

    --------------------- BASICS
    "nvim-lua/plenary.nvim",


    {
        { "tpope/vim-fugitive",                event = "VeryLazy" }, -- Automatic setup
        { "nvim-telescope/telescope-dap.nvim", event = "BufReadPost" }, -- Automatic setup
        { "tpope/vim-surround",                event = "BufEnter" }, -- Automatic setup

    },
    "folke/neodev.nvim",
    "nvim-tree/nvim-web-devicons",

    "folke/trouble.nvim",

    "tpope/vim-repeat",

    "ggandor/leap.nvim",

    --------------------- END BASICS
    --------------------- BASICS TWO
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",

    "numToStr/Comment.nvim",
    "nvim-lualine/lualine.nvim",

    --"norcalli/nvim-colorizer.lua", -- going to try NvChad's version of this plugin
    "NvChad/nvim-colorizer.lua",

    "folke/todo-comments.nvim",
    "mbbill/undotree",

    "RRethy/vim-illuminate",
    "lukas-reineke/indent-blankline.nvim",

    ---- TELESCOPE PLUGINS
    "ThePrimeagen/harpoon",                         -- Telescope
    "nvim-telescope/telescope-fzy-native.nvim",     -- Telescope
    "AckslD/nvim-neoclip.lua",                      -- Telescope
    "nvim-telescope/telescope-live-grep-args.nvim", -- Telescope
    "cljoly/telescope-repo.nvim",                   -- Telescope

    -- 'nvim-telescope/telescope-ui-select.nvim', -- 'nvim-treesitter/playground', -- Test first tho

    ---- END TELESCOPE PLUGINS
    --------------------- END BASICS TWO
    --------------------- LSP
    "williamboman/mason.nvim", -- KEEP ORDER (Mason, Mason-Lspconfig, nvim-lspconfig)
    -- "williamboman/mason-lspconfig.nvim", -- KEEP ORDER (Mason, Mason-Lspconfig, nvim-lspconfig)
    "neovim/nvim-lspconfig",   -- KEEP ORDER (Mason, Mason-Lspconfig, nvim-lspconfig) -- nvim-cmp requires this

    -- "lvimuser/lsp-inlayhints.nvim",
    "pmizio/typescript-tools.nvim",
    "nvimdev/lspsaga.nvim",


    --------------------- END LSP
    --------------------- DAP (kinda)
    "jay-babu/mason-nvim-dap.nvim",
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",

    --------------------- END DAP
    --------------------- COMPLETION
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "petertriho/cmp-git",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",

    -- Not already present/don't need
    -- "hrsh7th/cmp-nvim-lsp-signature-help",
    -- "rafamadriz/friendly-snippets",
    -- "doxnit/cmp-luasnip-choice",


    -- END Not already presents


    "windwp/nvim-autopairs",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",

    "zbirenbaum/copilot.lua", -- TODO: get this working lol
    "zbirenbaum/copilot-cmp",

    "saecki/crates.nvim",
    "vrslev/cmp-pypi",

    { "onsails/lspkind.nvim", event = "VeryLazy" },

    --------------------- END COMPLETION
    --------------------- FORMATTING

    "mfussenegger/nvim-lint",
    "stevearc/conform.nvim",

    --------------------- END FORMATTING
    --------------------- UI

    "j-hui/fidget.nvim",

    -- "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify",
    -- "stevearc/dressing.nvim",
    -- "folke/noice.nvim",

    --------------------- END UI
    --------------------- MISC

    -- "mrcjkb/rustaceanvim",
    "ray-x/go.nvim",
    "Civitasv/cmake-tools.nvim",
    "kdheepak/lazygit.nvim",
    "lewis6991/gitsigns.nvim",

    "sindrets/diffview.nvim",


    "kevinhwang91/nvim-ufo",

    "sindrets/winshift.nvim",

    --  test this over the netrw++ type upgrade
    -- {
    --     'echasnovski/mini.files',
    --     version = false,
    --     config = function()
    --         require('mini.files').setup({mappings = {go_in_plus = 'l'}})
    --     end
    --
    -- }

    --------------------- END MISC
}, -- END of namespace registrations



















--     {
--         "nvim-telescope/telescope.nvim",
--     }
--
--
--
--     {
--         "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
--     }
--
--
--     {
--         "numToStr/Comment.nvim"
--     }
--
--
--     {
--         "nvim-lualine/lualine.nvim",
--     }
--
--
--     {
--         "norcalli/nvim-colorizer.lua",
--     }
--
--
--     {
--         "folke/todo-comments.nvim",
--     }
--
--
--     {
--         "mbbill/undotree",
--     }
--
--
--     {
--         "RRethy/vim-illuminate",
--     }
--
--
--     {
--         "lukas-reineke/indent-blankline.nvim",
--     }
--
--
--     {
--         "ThePrimeagen/harpoon", -- Telescope
--     }
--
--
--
-- ---- TELESCOPE PLUGINS
--
--
--     {
--         "nvim-telescope/telescope-fzy-native.nvim", -- Telescope
--     }
--
--
--     {
--         "AckslD/nvim-neoclip.lua", -- Telescope
--     }
--
--
--     {
--         "nvim-telescope/telescope-live-grep-args.nvim", -- Telescope
--     }
--
--
--     {
--         "cljoly/telescope-repo.nvim", -- Telescope
--     }
--
-- -- 'nvim-telescope/telescope-ui-select.nvim', -- 'nvim-treesitter/playground', -- Test first tho
--
-- ---- END TELESCOPE PLUGINS
-- --------------------- END BASICS TWO
--
--
--
--
-- --------------------- LSP
--
--
--
--
--
--
--
--
--     {
--         "williamboman/mason.nvim", -- KEEP ORDER (Mason, Mason-Lspconfig, nvim-lspconfig)
--     }
--
--
--     {
--         "williamboman/mason-lspconfig.nvim", -- KEEP ORDER (Mason, Mason-Lspconfig, nvim-lspconfig)
--     }
--
--
--     {
--         "neovim/nvim-lspconfig", -- KEEP ORDER (Mason, Mason-Lspconfig, nvim-lspconfig) -- nvim-cmp requires this
--     }
--
--
--     {
--         "lvimuser/lsp-inlayhints.nvim",
--     }
--
-- --------------------- END LSP
--
--
-- --------------------- DAP (kinda)
--
--
--
--
--
--
--
--     {
--         "jay-babu/mason-nvim-dap.nvim",
--     }
--
--
--     {
--         "nvim-telescope/telescope-dap.nvim",
--     }
--
--
--     {
--         "mfussenegger/nvim-dap",
--     }
--
--
--     {
--         "rcarriga/nvim-dap-ui",
--     }
--
--
--     {
--         "theHamsta/nvim-dap-virtual-text",
--     }
--
--
-- --------------------- END DAP
--
-- --------------------- COMPLETION
--
--
--
--
--
--
--     {
--         "hrsh7th/nvim-cmp",
--     }
--
--
--     {
--         "hrsh7th/cmp-buffer",
--     }
--
--
--     {
--         "hrsh7th/cmp-path",
--     }
--
--
--     {
--         "hrsh7th/cmp-cmdline",
--     }
--
--     {
--         "petertriho/cmp-git",
--     }
--
--
--     {
--         "hrsh7th/cmp-nvim-lsp",
--     }
--
--
--     {
--         "hrsh7th/cmp-nvim-lsp-signature-help",
--     }
--
--
--     {
--         "hrsh7th/cmp-nvim-lua",
--     }
--
--
--     {
--         "windwp/nvim-autopairs",
--     }
--
--
--     {
--         "L3MON4D3/LuaSnip",
--     }
--
--
--     {
--         "rafamadriz/friendly-snippets",
--     }
--
--
--     {
--         "saadparwaiz1/cmp_luasnip",
--     }
--
--
--     {
--         "doxnit/cmp-luasnip-choice",
--     }
--
--
--     {
--         "zbirenbaum/copilot.lua",
--     }
--
--
--     {
--         "zbirenbaum/copilot-cmp",
--     }
--
--
--
--
--
--
--     {
--         "saecki/crates.nvim",
--     }
--
--
--     {
--         "vrslev/cmp-pypi",
--     }
--
--
--     {
--         "onsails/lspkind.nvim",
--
--         --------------------- END COMPLETION
--
--     }
--
--
-- --------------------- FORMATTING
--
--
--     {
--         "mfussenegger/nvim-lint",
--     }
--
--
--     {
--         "stevearc/conform.nvim",
--     }
--
-- --------------------- END FORMATTING
--
--
--
-- --------------------- UI
--
--
--
-- --------------------- UI
--     {
--         "MunifTanjim/nui.nvim",
--     }
--
--
--     {
--         "rcarriga/nvim-notify",
--     }
--
--
--     {
--         "stevearc/dressing.nvim",
--     }
--
--
--     {
--         "j-hui/fidget.nvim",
--     }
--
--
--     {
--         "folke/noice.nvim",
--
--         --------------------- END UI
--     }
--
--
-- --------------------- MISC
--
--     {
--         "mrcjkb/rustaceanvim",
--     }
--
--
--     {
--         "kdheepak/lazygit.nvim",
--     }
--
--
--     {
--         "lewis6991/gitsigns.nvim",
--     }
--
--
--     {
--         "sindrets/winshift.nvim",
--     }
--
-- --------------------
