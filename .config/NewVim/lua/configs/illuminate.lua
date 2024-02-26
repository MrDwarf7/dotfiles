local illuminate = require("illuminate")

illuminate.configure({
    providers = {
        "lsp",
        "treesitter",
        "regex",
    },
    delay = 100, -- Default value
})
