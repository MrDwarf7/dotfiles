return {
    "tiagovla/tokyodark.nvim",
    opts = {
        -- custom options here
        priority = 1000,
        -- transparent_background = true,
        gamma = 0.95,
    },
    config = function(_, opts)
        require("tokyodark").setup(opts) -- calling setup is optional
        vim.cmd [[colorscheme tokyodark]]
    end,
}
