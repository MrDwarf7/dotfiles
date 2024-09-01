function SafeNewAlias {
    param (
        [string]$Alias,
        [string]$Command
    )
    if (-not (Get-Alias -Name ${Alias} -ErrorAction SilentlyContinue)) {
        New-Alias -Name ${Alias} -Value ${Command}
    }
    if ((Get-Alias -Name ${Alias} -ErrorAction SilentlyContinue).Definition -ne ${Command}) {
        Remove-Alias -Name ${Alias}
        New-Alias -Name ${Alias} -Value ${Command}
    }
}

# Formatted via powershell version for now
function FWhich {
    param (
        [string]$cmd
    )
    $commandInfo = Get-Command -ErrorAction "SilentlyContinue" $cmd
    if ($commandInfo) {
        $commandInfo.Source
    } else {
        Write-Output "Command not found: $cmd"
    }
}


function WhichCD {
    param(
        [string]$commandName
    )

    $execPath = (Get-Command $commandName).Source

    if (-not $execPath) {
        Write-Warning "Command not found: $commandName"
        return
    }

    $directory = [System.IO.Path]::GetDirectoryName($execPath)

    Set-Location -Path $directory
}


function Remove-Wrapper {
    # Initialize flags and paths
    $force = $false
    $recurse = $false
    $paths = @()

    # Process each argument
    foreach ($arg in $args) {
        switch -Regex ($arg) {
            '^-(.*r.*)$' {
                $recurse = $true
            }
            '^-(.*f.*)$' {
                $force = $true
            }
            Default {
                $paths += $arg
            }
        }
    }

    Write-Host "Force: $force"
    Write-Host "Recurse: $recurse"
    Write-Host "Paths: $paths"
    Write-Host "Args: $args"

    foreach ($path in $paths) {
        try {
            $resolvedPath = Resolve-Path -Path $path

            if (Test-Path $resolvedPath -PathType Container) {
                [System.IO.Directory]::Delete($resolvedPath, $recurse)
            } else {
                if ($force) {
                    Set-ItemProperty -Path $resolvedPath -Name IsReadOnly -Value $false
                }
                [System.IO.File]::Delete($resolvedPath)
            }
        } catch {
            Write-Error "Failed to remove path:  $path"
            Write-Error "Failed to remove res path:  $resolvedPath"
            Write-Host "Force: $force"
            Write-Host "Recurse: $recurse"
            Write-Host "Paths: $paths"
            Write-Host "Args: $args"
        }
    }
}

function ManPageWindow {
    param (
        [string]$command
    )
    Get-Help -Name $command -ShowWindow
}

function ManPage {
    param(
        [string]$command
    )
    Get-Help -Name $command -Full | Out-String -Width 120 | less --quiet --silent --line-numbers
    # | bat --paging=always --decorations=always
}

function CleanLess {
    param(
        $parsedArgs
    )
    return less --quiet --silent --line-numbers $parsedArgs
}


function CargoBuilEverything {
    $command = "cargo build && cargo build --release $args"
    Invoke-Expression $command
}


function CargoRunEverything {
    $command = "cargo run && cargo run --release $args"
    Invoke-Expression $command
}


function ZoxideAdd {
    zoxide add .
}

function ZoxideEdit {
    zoxide edit
}

function ZoxideQuery {
    zoxide query $args
}


function NavigateToRust {
    Invoke-Expression "z Rust"
}


New-Alias -Name manwin -Value ManPageWindow -Force
New-Alias -Name man -Value ManPage -Force

# Not working as intended at all but eh
SafeNewAlias -Alias less -Command CleanLess $args

New-Alias -Name which -Value FWhich -Force
New-Alias -Name cdd -Value  WhichCD -Force
New-Alias -Name rm -Value Remove-Wrapper -Force

SafeNewAlias -Alias bpsa -Command sar
SafeNewAlias -Alias br -Command broot.exe
SafeNewAlias -Alias grep -Command Select-String
SafeNewAlias -Alias ln -Command New-SymLink
SafeNewAlias -Alias npp -Command notepad++.exe

New-Alias -Name z. -Value ZoxideAdd -Force
New-Alias -Name z.. -Value ZoxideEdit -Force
New-Alias -Name zq -Value ZoxideQuery -Force


New-Alias -Name cargos -Value CargoBuilEverything -Force
New-Alias -Name cargosr -Value CargoRunEverything -Force

New-Alias -Name rst -Value NavigateToRust -Force

# Cargo Aliases
#
# Not currently working while function c is in place
# SafeNewAlias -Alias cb -Command CargoBuild
# SafeNewAlias -Alias cr -Command CargoRun
# SafeNewAlias -Alias crq -Command CargoRunQuiet
# SafeNewAlias -Alias cbr -Command CargoBuildRelease
# SafeNewAlias -Alias crr -Command CargoRunRelease
# SafeNewAlias -Alias ct -Command CargoTest
# SafeNewAlias -Alias cc -Command CargoCheck
# SafeNewAlias -Alias ccl -Command CargoClean
# SafeNewAlias -Alias cu -Command CargoUpdate
# SafeNewAlias -Alias cdoc -Command CargoDoc
# SafeNewAlias -Alias cup -Command CargoUpgrade
# SafeNewAlias -Alias cu -Command CargoUpdate
# SafeNewAlias -Alias cdoc -Command CargoDoc
# SafeNewAlias -Alias cup -Command CargoUpgrade
