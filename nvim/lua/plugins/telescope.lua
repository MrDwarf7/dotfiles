return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
    config = function()
    require("telescope").setup(opts)
        local builtin = require('telescope.builtin')

        -- Which-Key reigster for group
        local wk = require("which-key") 
        wk.register({
            f = {
                name = "Find(Telescope)", -- optional group name
                f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
                r = { "<cmd>Telescope oldfiles<cr>", "Find Recents", noremap = true}, -- additional options for creating the keymap
                b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
                g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
                h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
                j = { "<cmd>Telescope jumplist<cr>", "Jumplist" },
                - = { "<cmd>Telescope colorscheme<cr>", "Temp Colorscheme" },
            },
        }, { prefix = "<leader>" })
    end,
}
