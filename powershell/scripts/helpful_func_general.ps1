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
    scoop update && scoop update --all
}

function dot
{
    if (-not $args)
    {
        # Write-Host "Not Args: "
        Push-Location "C:\"
        Push-Location $dotfiles_dir
        Get-ChildItem
        Write-Host "Fetching: "
        git fetch
        Write-Host "Status: "
        git status
        return
    } elseif (-not ($null -eq $args))
    {
        Write-Host "Args present: '$args'"
        Push-Location "C:\"
        $basePath = "$dotfiles_dir/$args"
        Push-Location $basePath
        Get-ChildItem
        Write-Host "Fetching: "
        git fetch
        Write-Host "Status: "
        git status
        return
    }
} 

# END - Shell functions / Helpful functions

function pro
{
    . $PROFILE
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

function z
{
    zoxide $args
}


function CargoBuild
{
    cargo build $args
}

function CargoRun
{
    cargo run $args
}

function CargoTest
{
    cargo test $args
}

function CargoCheck
{
    cargo check $args
}

function CargoClean
{
    cargo clean $args
}

function CargoDoc
{
    cargo doc $args
}

function CargoUpdate
{
    cargo update $args
}

function CargoUpgrade
{
    cargo upgrade $args
}

function CargoBuildRelease
{
    cargo build --release $args
}

New-alias cb CargoBuild
New-alias cr CargoRun
New-alias ct CargoTest
New-alias cc CargoCheck
New-alias ccl CargoClean
New-alias cd CargoDoc
New-alias cu CargoUpdate
New-alias cup CargoUpgrade
New-alias cbr CargoBuildRelease



