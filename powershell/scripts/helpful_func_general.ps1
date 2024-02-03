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
# END - Linux Functions
