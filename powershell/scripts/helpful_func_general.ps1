# $data_projects = "Data-Sets"
# $downloaded = "Downloads"
# $docker_projects = "Docker"
# $go_projects = "Go"
# $powershell_projects = "PowerShell"
# $python_projects = "Python"
# $rust_projects = "Rust"
# $web_projects = "Web"
# $testing_projects = "Testing"

# BEGIN - Shell functions / Helpful functions
function cl
{
    Add-Type -Assembly PresentationCore
    $clipText = (get-location).ToString() | Out-String -Stream
    [Windows.Clipboard]::SetText($clipText)
}

function lzgt
{
    lazygit $args
}

function lg
{
    lazygit $args
}


function nf
{
    if (-not (neofetch --help))
    {
        try
        {
            scoop install neofetch
        } catch
        {
            scoop bucket add extras
        } finally
        {
            scoop install neofetch
        }
    }
    neofetch
}

function lzdk
{
    lazydocker $args
}

function gitgo
{
    param(
        [string]$baseCommitMessage = "Bump"
    )
    if ($args)
    {
        $argumentsIn = $args
    }
    if (-not $args)
    {
        $argumentsIn = $baseCommitMessage
    }
    gst && gaa && gcam "$($argumentsIn)." && git push
    return
}

function scoopup
{
    scoop update && scoop update --all && scoop cleanup * && scoop cache rm *
}

function nodeup
{
    $env:NODE_TLS_REJECT_UNAUTHORIZED = "0"
    pnpm -g update && pnpm -g upgrade && yarn global upgrade && npm -g update && npm -g upgrade
    # unset $env:NODE_TLS_REJECT_UNAUTHORIZED
}

function sysup
{
    if (-not ($env:NODE_TLS_REJECT_UNAUTHORIZED))
    {
        $env:NODE_TLS_REJECT_UNAUTHORIZED = "0"
    }
    scoopup
    nodeup
    winget upgrade JanDeDobbeleer.OhMyPosh -s winget
    Write-Host
    Write-Host "System update complete [scoopup, nodeup]" -NoNewline -ForegroundColor Green -BackgroundColor Black
    Write-Host
}

function scpdir
{
    Push-Location "$env:USERPROFILE\scoop\"
    Get-ChildItem
}


function dot
{
    param(
        $path
    )
    Write-Host "From dot function call path variable is: ", $path
    Write-Host "From dot function call literal args is: ", $args

    $path = if ($path)
    {
        Join-Path $dotfiles_dir $path.Replace('/', '\')
    } else
    {
        $dotfiles_dir
    }
    Push-Location "C:\"
    Push-Location $path
    Get-ChildItem
    Write-Host "Fetching: "
    git fetch
    Write-Host "Status: "
    git status
    return
}

# END - Shell functions / Helpful functions

function pro
{
    # Define the possible values for no-clear
    $possibleClear = "c", "-", "cls", "clear", "-clear", "clr", "screen", "-screen", "clear-screen", "-clear-screen", "cls-", "clr", "cl", "BEGONE", "THOT", "wipe"

    # Check if noClear argument is one of the specified values
    if ($args.Count -gt 0 -and $possibleClear -contains $args[0].ToLower())
    {
        # Reload the profile without clearing the console
        . $PROFILE
        Clear-Host
    } else
    {
        # Reload the profile and clear the console
        . $PROFILE
    }
}

function ca
{
    param ($path = ".")
    Clear-Host
    Get-ChildItem $path -Force
}

function .
{
    Start-Process .
}

function la
{
    param ($path = ".")
    Get-ChildItem $path -Force
}

function l
{
    param ($path = ".")
    Get-ChildItem $path -Force
}

function cd2
{
    Set-Location ../../
}

function touch
{
    New-Item $args
}

function zip
{
    param (
        [string]$ItemToCompress,
        [string]$OptionalDestination
    )
    $ItemName = (Get-Item $ItemToCompress).Name
    $ParentFolder = (Split-Path -Path $ItemToCompress -Parent)

    if ([String]::IsNullOrEmpty($OptionalDestination))
    {
        $DefaultLocation = Join-Path -Path $ParentFolder -ChildPath $ItemName

        Compress-Archive -Path $ItemToCompress -DestinationPath "$DefaultLocation.zip"
    } else
    {
        Compress-Archive -Path $ItemToCompress -DestinationPath "$OptionalDestination\$ItemName.zip"
    }
}

function uzip
{
    param (
        [string]$ItemToUnzip,
        [string]$OptionalDestination
    )
    $ItemName = (Get-Item $ItemToUnzip).Name
    $ParentFolder = (Split-Path -Path $ItemToUnzip -Parent)

    if ([String]::IsNullOrEmpty($OptionalDestination))
    {
        $DefaultLocation = Join-Path -Path $ParentFolder -ChildPath $ItemName

        Expand-Archive -Path $ItemToUnzip -DestinationPath "$DefaultLocation\$ItemName"
    } else
    {
        Expand-Archive -Path $ItemToUnzip -DestinationPath "$OptionalDestination\"
    }
}

return {
    {
        "neovim/nvim-lspconfig",
        event = "BufEnter",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "jay-babu/mason-nvim-dap.nvim",
        },

        -- Mason LSP CONFIG
        -- allows specifically for a cross over in the naming schema between
        -- the actual lsp server, and the naming conventions for the connections.
        -- in the below list - go to Mason, hit / to start a search and cancel it,
        -- this will give ghost text of the udnerlying name - Which is what you want to use here.

        config = function()
            local utils = require("utils")
            local on_attach = utils.on_attach("omnifunc", "vim:lua.vim.lsp.omnifunc")

            require("mason").setup({
                ui = {
                    border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
                    icons = {
                        package_pending = " ",
                        package_installed = "󰄳 ",
                        package_uninstalled = " 󰚌",
                    },
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "tsserver",
                    "biome",
                    --"awk_ls", -- Un-updated (requires running LTS version of node via NVM)
                    "azure_pipelines_ls",
                    "bashls",
                    "clangd",
                    "cmake",
                    "cssls",
                    "docker_compose_language_service",
                    "dockerls",
                    "eslint",
                    "html",
                    "taplo",
                    "marksman",
                    "powershell_es",
                    "prismals",
                    "tailwindcss",
                    "ruff_lsp",
                    "pyright",
                    --"rust_analyzer", -- Since using Rustaceanvim, DO NOT SETUP via lspconfig call
                    "slint_lsp",
                    "vimls",
                    "yamlls",
                    "zls",
                },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,
                }, -- handlers end
            })

            -- require("lspconfig")["bashls"].setup({
            -- 	on_attach = on_attach,
            -- 	filetypes = {
            -- 		"sh",
            -- 		"zsh",
            -- 		"bash",
            -- 	},
            -- })

            vim.keymap.set("n", "<Leader>lt", ":TodoLocList<CR>", { desc = "list [t]odo's" })
            -- LSP attach autocmds are called within the autocmds file (group = LspAuGroup)
        end,
    },

    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup({
                commented = true,
            })
        end,
    },

    {
        "lvimuser/lsp-inlayhints.nvim",
        opts = {},
    },

    {
        "mrcjkb/rustaceanvim",
        version = "^4", -- Recommended
        dependencies = {
            "lvimuser/lsp-inlayhints.nvim",
        },
        ft = { "rust" },
        config = function()
            vim.g.rustaceanvim = {
                inlay_hints = {
                    highlight = "NonText",
                },
                tools = {
                    hover_actions = {
                        auto_focus = true,
                    },
                },
                server = {
                    on_attach = function(client, bufnr)
                        require("lsp-inlayhints").on_attach(client, bufnr)
                        require("dap-ui")
                    end,
                },
            }

            local bufnr = vim.api.nvim_get_current_buf()
            vim.keymap.set("n", "<Leader>la", function()
                vim.cmd.RustLsp("codeAction")
            end, { silent = true, buffer = bufnr, desc = "[a]ction" })

            vim.keymap.set("n", "<Leader>lc", function()
                vim.cmd.RustLsp("flyCheck")
            end, { silent = true, buffer = bufnr, desc = "[c]heck" })

            vim.keymap.set("n", "<Leader>dd", function()
                vim.cmd.RustLsp("debuggables")
            end, { silent = true, buffer = bufnr, desc = "[d]ebuggables" })

            vim.keymap.set("n", "<Leader>dr", function()
                vim.cmd.RustLsp("runnables")
            end, { silent = true, buffer = bufnr, desc = "[r]un" })

            vim.keymap.set("n", "<Leader>lh", function()
                vim.cmd.RustLsp("hover")
            end, { silent = true, buffer = bufnr, desc = "[h]over" })
        end,
    },

    -- Dap things here, specific to mason
    -- {
    -- 	"jay-babu/mason-nvim-dap.nvim",
    -- 	event = "BufReadPre",
    -- 	dependencies = {
    -- 		"williamboman/mason.nvim",
    -- 	},
    -- 	config = function()
    -- 		require("mason-nvim-dap").setup({
    -- 			ensure_installed = {
    -- 				"python",
    -- 				"bash",
    -- 				"cppdbg",
    -- 				"codelldb",
    -- 				"chrome",
    -- 			},
    --
    -- 			automatic_installation = {
    -- 				-- exclude = {
    -- 				-- 	"bash",
    -- 				-- 	"chrome",
    -- 				-- 	"cppdbg",
    -- 				-- },
    -- 			},
    -- 			handler = {},
    -- 		})
    -- 	end,
    -- },
}
# END - Linux Functions
