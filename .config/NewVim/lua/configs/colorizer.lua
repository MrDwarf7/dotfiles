local colorizer = require("colorizer")

colorizer.setup({
    filetypes = { "css",
        "html",
        "javascript",
        "lua",
        "markdown",
        "scss",
        "txt",
        "vim",
        "yaml",
        "json",
        "typescript",
        "typescriptreact",
        "javascriptreact",
        "norg",
        "org",
        "pandoc",
        "markdown"
    },
    user_default_options = {
        tailwind = "both",
        css = true,
        css_fn = true,
        names = false,
    }
})
