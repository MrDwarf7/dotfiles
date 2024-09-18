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
function cl {
    # $cleanText = ""
    Add-Type -Assembly PresentationCore
    $clipText = (get-location).ToString() | Out-String -Stream

    if ($clipText.StartsWith("Microsoft.PowerShell.Core\FileSystem::")) {
        $clipText = $clipText.Replace("Microsoft.PowerShell.Core\FileSystem::", "")
    }
    [Windows.Clipboard]::SetText($clipText)
}

function lzgt {
    lazygit $args
}

function lg {
    lazygit $args
}

function nf {
    if (-not (fastfetch --help)) {
        try {
            scoop install neofetch
        } catch {
            scoop bucket add extras
        } finally {
            scoop install neofetch
        }
    }
   fastfetch 
}

function yy {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}

function lzd {
    lazydocker $args
}

function gitgo {
    param(
        [string]$baseCommitMessage = "Bump"
    )
    if ($args) {
        $argumentsIn = $args
    }
    if (-not $args) {
        $argumentsIn = $baseCommitMessage
    }
    gst && gaa && gcam "$($argumentsIn)." && git push
    return
}

function scoopup {
    scoop update && scoop update --all && scoop cleanup * && scoop cache rm *
}

function nodeup {
    $env:NODE_TLS_REJECT_UNAUTHORIZED = "0"
    pnpm -g update && pnpm -g upgrade && yarn global upgrade && npm -g update && npm -g upgrade
    # unset $env:NODE_TLS_REJECT_UNAUTHORIZED
}

function rustupgrader {
    rustup update
}

function sysup {
    if (-not ($env:NODE_TLS_REJECT_UNAUTHORIZED)) {
        $env:NODE_TLS_REJECT_UNAUTHORIZED = "0"
    }
    scoopup
    nodeup
    rustupgrader
    winget upgrade JanDeDobbeleer.OhMyPosh -s winget
    Write-Host
    Write-Host "System update complete [scoopup, nodeup]" -NoNewline -ForegroundColor Green -BackgroundColor Black
    Write-Host
}

function npp {
    notepad++ $args
}

function scpdir {
    Push-Location "$env:USERPROFILE\scoop\"
    Get-ChildItem
}

function baconget {
    $baconFile = "$dotfiles_dir\.config\bacon\bacon.toml"
    $currentDir = Get-Location

    if (-not (Test-Path $baconFile )) {
        Write-Host "Bacon file not found at: $baconFile "
        return
    }
    Copy-Item $baconFile $currentDir
    Write-Host "Bacon file copied to: $currentDir"
}

function dot {
    param(
        $path
    )
    # Write-Host "From dot function call path variable is: ", $path
    # Write-Host "From dot function call literal args is: ", $args

    $path = if ($path) {
        Join-Path $dotfiles_dir $path.Replace('/', '\')
    } else {
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


function refresh {
    Import-Module "C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1";
    refreshenv;
    Write-Host "Chocolatey environment refreshed." -ForegroundColor Green;
    if ($args.Count -gt 0) {
        Write-Host "Extra arguments detected: $args" -ForegroundColor Yellow;
        . SourceProfile  $args;
    }
    . SourceProfile  
}

function SourceProfile {
    # Define the possible values for no-clear
    $possibleClear = "c", "-", "cls", "clear", "-clear", "clr", "screen", "-screen", "clear-screen", "-clear-screen", "cls-", "clr", "cl", "BEGONE", "THOT", "wipe"

    # Check if noClear argument is one of the specified values
    if ($args.Count -gt 0 -and $possibleClear -contains $args[0]) {
        # Reload the profile without clearing the console
        . $PROFILE
        Clear-Host
    } else {
        # Reload the profile and clear the console
        . $PROFILE
    }
}

New-Alias -Name p -Value SourceProfile -Force
New-Alias -Name pro -Value SourceProfile -Force

function . {
    Start-Process .
}

function cd2 {
    Set-Location ../../
}

function touch {
    New-Item $args
}

function zip {
    param (
        [string]$ItemToCompress,
        [string]$OptionalDestination
    )
    $ItemName = (Get-Item $ItemToCompress).Name
    $ParentFolder = (Split-Path -Path $ItemToCompress -Parent)

    if ([String]::IsNullOrEmpty($OptionalDestination)) {
        $DefaultLocation = Join-Path -Path $ParentFolder -ChildPath $ItemName

        Compress-Archive -Path $ItemToCompress -DestinationPath "$DefaultLocation.zip"
    } else {
        Compress-Archive -Path $ItemToCompress -DestinationPath "$OptionalDestination\$ItemName.zip"
    }
}

function uzip {
    param (
        [string]$ItemToUnzip,
        [string]$OptionalDestination
    )
    $ItemName = (Get-Item $ItemToUnzip).Name
    $ParentFolder = (Split-Path -Path $ItemToUnzip -Parent)

    if ([String]::IsNullOrEmpty($OptionalDestination)) {
        $DefaultLocation = Join-Path -Path $ParentFolder -ChildPath $ItemName

        Expand-Archive -Path $ItemToUnzip -DestinationPath "$DefaultLocation\$ItemName"
    } else {
        Expand-Archive -Path $ItemToUnzip -DestinationPath "$OptionalDestination\"
    }
}
# END - Linux Functions
