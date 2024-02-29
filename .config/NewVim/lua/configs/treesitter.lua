local treesitter = require("nvim-treesitter.configs")
-- local treesitter_configs = require("nvim-treesitter.configs")
local commentstring = require("ts_context_commentstring")
local buffer = require("util.buffer")

treesitter.setup({
    ensure_installed = {
        "bash",
        "c",
        "cpp",
        "c_sharp",
        "css",
        "embedded_template",
        "gitattributes",
        "gitcommit",
        "git_config",
        "gitignore",
        "git_rebase",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "rust",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
    },
    highlight = {
        enable = true,
        disable = function(_, buf)
            if buffer.is_large(buf) then
                return true
            end
        end,
    },
    incremental_selection = {
        enable = false,
    },
    indent = {
        enable = true,
        disable = function(lang, buf)
            if lang == "html" or lang == "javascript" or lang == "typescript" or lang == "css" or "rust" or buffer.is_large(buf) then
                return true
            end
        end,
    },
    autotag = {
        enable = true,
    },
    sync_install = false,
    auto_install = true,
})

commentstring.setup({
    enable_auto_comment = true,
})
