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

function time { 
    $Command = "$args";
    Measure-Command { 
        Invoke-Expression $Command 2>&1 | Out-Default
    }
}

function timen { 
    $Command = "$args";
    Measure-Command { 
        Invoke-Expression $Command 2>&1 | Out-Null
    }
}

function ffff() {
    $max = 23;
    $min = 2;

    Clear-Host;
    for ($i = $min; $i -lt $max; $i++) {
        Write-Host
        Write-Host
        Write-Host "Example $i"

        $config = "examples/$i";
        Invoke-Expression "fastfetch --config $config";
    }
}

function fastfetchin() {
    $num = 21
    $config = "--config examples/$num"

    Write-Host
    Write-Host
    Invoke-Expression "fastfetch $config";
    Write-Host
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

New-Alias -Name clif -Value cargo-clif -Force
New-Alias -Name cliff -Value cargo-clif -Force

New-Alias -Name ff -Value fastfetchin -Force
