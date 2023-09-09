return {
    "dnlhc/glance.nvim",
    config = function()
        require("glance").setup({
            theme = {
                enable = true,
                mode = 'auto'
            },
            border = {
                enable = false,
                top_char = "─",
                bottom_char = "─",
            }
        })
    end,
    keys = {
        { "lD", "<CMD>Glance definitions<CR>",      desc = "Glance definitions" },
        { "lR", "<CMD>Glance references<CR>",       desc = "Glance references" },
        { "lT", "<CMD>Glance type_definitions<CR>", esc = "Glance type_definitions" },
        { "lI", "<CMD>Glance implementations<CR>",  desc = "Glance implementations" }
    }
}
