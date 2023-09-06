return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local lualine = require("lualine").setup{

-- TODO: Get a lualine config from somewhere lol.

        }
        local lazy_status = require("lazy.status")
    end,
}
