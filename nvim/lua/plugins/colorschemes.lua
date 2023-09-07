-- Currently: catppuccin
return {
    {
        "catppuccin/nvim",
        enabled = true,
        priority = 1000,
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                background = {
                    light = "latte",
                    dark = "mocha",
                },
                color_overrides = {
                    mocha = {
                        rosewater = "#efc9c2",
                        flamingo = "#ebb2b2",
                        pink = "#f2a7de",
                        mauve = "#b889f4",
                        red = "#ea7183",
                        maroon = "#ea838c",
                        peach = "#f39967",
                        yellow = "#eaca89",
                        green = "#96d382",
                        teal = "#78cec1",
                        sky = "#91d7e3",
                        sapphire = "#68bae0",
                        blue = "#739df2",
                        lavender = "#a0a8f6",
                        text = "#b5c1f1",
                        subtext1 = "#a6b0d8",
                        subtext0 = "#959ec2",
                        overlay2 = "#848cad",
                        overlay1 = "#717997",
                        overlay0 = "#63677f",
                        surface2 = "#505469",
                        surface1 = "#3e4255",
                        surface0 = "#2c2f40",
                        base = "#1a1c2a",
                        mantle = "#141620",
                        crust = "#0e0f16",
                    },
                },
                styles = { --For time  being not sure if blank tables prevent renders lol
                    comments = { "italic" },
                    conditionals = {},
                    loops = {},
                    functions = { "italic" },
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                },
                transparent_background = false,
                term_colors = true,
                show_end_of_buffer = true,
                inergrations = {
                    telescope = true,
                    -- harpoon = true,
                    mason = true,
                    -- neotest = true,
                },
                custom_highlights = function(colors)
                    return {
                        NormalFloat = { bg = colors.crust },
                        FloatBorder = { bg = colors.crust, fg = colors.crust },
                        VertSplit = { bg = colors.base, fg = colors.surface0 },
                        CursorLineNr = { fg = colors.surface2 },
                        Pmenu = { bg = colors.crust, fg = "" },
                        PmenuSel = { bg = colors.surface0, fg = "" },
                        TelescopeSelection = { bg = colors.surface0 },
                        TelescopePromptCounter = { fg = colors.mauve },
                        TelescopePromptPrefix = { bg = colors.surface0 },
                        TelescopePromptNormal = { bg = colors.surface0 },
                        TelescopeResultsNormal = { bg = colors.mantle },
                        TelescopePreviewNormal = { bg = colors.crust },
                        TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
                        TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
                        TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
                        TelescopePromptTitle = { fg = colors.surface0, bg = colors.surface0 },
                        TelescopeResultsTitle = { fg = colors.mantle, bg = colors.mantle },
                        TelescopePreviewTitle = { fg = colors.crust, bg = colors.crust },
                        IndentBlanklineChar = { fg = colors.surface0 },
                        IndentBlanklineContextChar = { fg = colors.surface2 },
                        GitSignsChange = { fg = colors.peach },
                        NvimTreeIndentMarker = { link = "IndentBlanklineChar" },
                        NvimTreeExecFile = { fg = colors.text },
                        IlluminatedWordText = { bg = colors.surface1, fg = "" },
                        IlluminatedWordRead = { bg = colors.surface1, fg = "" },
                        IlluminatedWordWrite = { bg = colors.surface1, fg = "" },
                    }
                end,
            })

            vim.api.nvim_command("colorscheme catppuccin")
        end,
    },
    {
        "oxfist/night-owl.nvim",
        lazy = false,  -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            -- vim.cmd.colorscheme("night-owl")
        end,
    },
    {
        "Mofiqul/vscode.nvim",
        config = function()
            require("vscode").setup({})
            -- vim.cmd("colorscheme vscode")
        end
    }
}
