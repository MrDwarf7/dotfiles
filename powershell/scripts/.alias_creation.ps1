
# using namespace System.Collections.Generic;
# using namespace System.Collections.ObjectModel;
# using namespace System.Collections.Concurrent;

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
# New-Alias -Name which -Value FWhich -Force

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
# New-Alias -Name cdd -Value WhichCD -Force


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

function TempDir {
    $c_temp_folder = "c:\temp"
    Push-Location $c_temp_folder
    la
}
New-Alias -Name tmp -Value TempDir -Force

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
    return less --quiet --silent --line-numbers $args
}
# Not working as intended at all but eh
# New-Alias -Name lessp -Value CleanLess -Force
# New-Alias -Name lessp -Value CleanLess -Force
# SafeNewAlias -Alias lessp -Command CleanLess $args

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

    If (-not (Test-CommandExists "fastfetch")) {
        Write-Output "fastfetch is not installed"
        return
    }

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

    If (-not (Test-CommandExists "fastfetch")) {
        Write-Output "fastfetch is not installed"
        return
    }

    Write-Host
    Write-Host
    Invoke-Expression "fastfetch $config";
    Write-Host
}

. "$powershell_scripts_dir\symbolic_junction.ps1"

function launchwsl {
    wsl.exe -d Arch --cd ~
}

function GitPushAlias {
    git push $args
}



$null = Invoke-Expression (
    [System.Text.StringBuilder]::new().
        Append("New-Alias -Name npp -Value notepad++.exe -Force").
        Append("`n").
        Append("New-Alias -Name c -Value cat -Force").
        Append("`n").
        Append("New-Alias -Name b -Value bat -Force").
        Append("`n").
        Append("New-Alias -Name gu -Value gitui -Force").
        Append("`n").
        Append("New-Alias -Name rst -Value NavigateToRust -Force").
        Append("`n").
        Append("New-Alias -Name grep -Value Select-String -Force").
        Append("`n").
        Append("New-Alias -Name manwin -Value ManPageWindow -Force").
        Append("`n").
        Append("New-Alias -Name man -Value ManPage -Force").
        Append("`n").
        Append("New-Alias -Name rm -Value Remove-Wrapper -Force").
        Append("`n").
        Append("New-Alias -Name z. -Value ZoxideAdd -Force").
        Append("`n").
        Append("New-Alias -Name z.. -Value ZoxideEdit -Force").
        Append("`n").
        Append("New-Alias -Name zq -Value ZoxideQuery -Force").
        Append("`n").
        Append("New-Alias -Name cargos -Value CargoBuilEverything -Force").
        Append("`n").
        Append("New-Alias -Name cargosr -Value CargoRunEverything -Force").
        Append("`n").
        Append("New-Alias -Name ff -Value fastfetchin -Force").
        Append("`n").
        Append("New-Alias -Name cdd -Value WhichCD -Force").
        Append("`n").
        Append("New-Alias -Name which -Value FWhich -Force").
        Append("`n").
        Append("New-Alias -Name tmp -Value TempDir -Force").
        Append("`n").
        Append("New-Alias -Name aw -Value launchwsl -Force").
        Append("`n").
        Append("New-Alias -Name ma -Value makers $args -Force").
        Append("`n").
        Append("New-Alias -Name gp -Value GitPushAlias -Force").
    ToString()
) > $null;

# | Out-Null

# New-Alias -Name manwin -Value ManPageWindow -Force
# New-Alias -Name man -Value ManPage -Force
# New-Alias -Name rm -Value Remove-Wrapper -Force
# New-Alias -Name z. -Value ZoxideAdd -Force
# New-Alias -Name z.. -Value ZoxideEdit -Force
# New-Alias -Name zq -Value ZoxideQuery -Force
# New-Alias -Name cargos -Value CargoBuilEverything -Force
# New-Alias -Name cargosr -Value CargoRunEverything -Force
# New-Alias -Name ff -Value fastfetchin -Force
#
#
# function launchwsl {
#     wsl.exe -d Arch --cd ~
# }
# New-Alias -Name aw -Value launchwsl -Force
#
# # New-Alias -Name rst -Value NavigateToRust -Force
# # New-Alias -Name c -Value cat -Force
# # New-Alias -Name b -Value bat -Force
# # New-Alias -Name gu -Value gitui -Force
#
#
# SafeNewAlias -Alias bpsa -Command sar
# SafeNewAlias -Alias br -Command broot.exe
# SafeNewAlias -Alias grep -Command Select-String
# # SafeNewAlias -Alias ln -Command New-SymLink
# # SafeNewAlias -Alias npp -Command notepad++.exe
#
#







#
# Testing things 
# function InvokeAliases() {
#     param(
#         [List[string]]$list
#     )
#     $null = foreach($alias in $list) {
#         Invoke-Expression $alias > $null
#     }
# }
#
# $list_holder = [System.Collections.Generic.List[string]]::new();
# function AssembleList() {
#     param(
#         [string]$alias,
#         [List[string]]$list
#     )
#     $list.Add($alias)
#     return $list
# }
#
# $aliases_bare = @(
#         New-Alias -Name npp -Value 'notepad++.exe' -Force
#         New-Alias -Name c -Value cat -Force
#         New-Alias -Name b -Value bat -Force
#         New-Alias -Name gu -Value gitui -Force
#         New-Alias -Name rst -Value NavigateToRust -Force
#         New-Alias -Name grep -Value Select-String -Force
#         New-Alias -Name manwin -Value ManPageWindow -Force
#         New-Alias -Name man -Value ManPage -Force
#         New-Alias -Name rm -Value Remove-Wrapper -Force
#         New-Alias -Name z. -Value ZoxideAdd -Force
#         New-Alias -Name z.. -Value ZoxideEdit -Force
#         New-Alias -Name zq -Value ZoxideQuery -Force
#         New-Alias -Name cargos -Value CargoBuilEverything -Force
#         New-Alias -Name cargosr -Value CargoRunEverything -Force
#         New-Alias -Name ff -Value fastfetchin -Force
#         New-Alias -Name cdd -Value WhichCD -Force
#         New-Alias -Name which -Value FWhich -Force
#         New-Alias -Name tmp -Value TempDir -Force
#         New-Alias -Name aw -Value launchwsl -Force
# )
# Write-Host "Aliases: $aliases_bare"
# $list_holder = foreach ($alias in $aliases_bare) {
#     $list_holder = AssembleList -alias $alias -list $list_holder
# }
# Write-Host( "List Holder: $list_holder")
# InvokeAliases -list $list_holder






# $list_holder = AssembleList -alias "New-Alias -Name npp -Value notepad++.exe -Force" -list $list_holder


# $alias_list = [List[string]]::new();
# $alias_list.
#         Add("New-Alias -Name npp -Value notepad++.exe -Force").
#         Add("New-Alias -Name c -Value cat -Force").
#         Add("New-Alias -Name b -Value bat -Force").
#         Add("New-Alias -Name gu -Value gitui -Force").
#         Add("New-Alias -Name rst -Value NavigateToRust -Force").
#         Add("New-Alias -Name grep -Value Select-String -Force").
#         Add("New-Alias -Name manwin -Value ManPageWindow -Force").
#         Add("New-Alias -Name man -Value ManPage -Force").
#         Add("New-Alias -Name rm -Value Remove-Wrapper -Force").
#         Add("New-Alias -Name z. -Value ZoxideAdd -Force").
#         Add("New-Alias -Name z.. -Value ZoxideEdit -Force").
#         Add("New-Alias -Name zq -Value ZoxideQuery -Force").
#         Add("New-Alias -Name cargos -Value CargoBuilEverything -Force").
#         Add("New-Alias -Name cargosr -Value CargoRunEverything -Force").
#         Add("New-Alias -Name ff -Value fastfetchin -Force").
#         Add("New-Alias -Name cdd -Value WhichCD -Force").
#         Add("New-Alias -Name which -Value FWhich -Force").
#         Add("New-Alias -Name tmp -Value TempDir -Force").
#         Add("New-Alias -Name aw -Value launchwsl -Force")

# "New-Alias -Name npp -Value notepad++.exe -Force",
#         "New-Alias -Name c -Value cat -Force",
#         "New-Alias -Name b -Value bat -Force",
#         "New-Alias -Name gu -Value gitui -Force",
#         "New-Alias -Name rst -Value NavigateToRust -Force",
#         "New-Alias -Name grep -Value Select-String -Force",
#         "New-Alias -Name manwin -Value ManPageWindow -Force",
#         "New-Alias -Name man -Value ManPage -Force",
#         "New-Alias -Name rm -Value Remove-Wrapper -Force",
#         "New-Alias -Name z. -Value ZoxideAdd -Force",
#         "New-Alias -Name z.. -Value ZoxideEdit -Force",
#         "New-Alias -Name zq -Value ZoxideQuery -Force",
#         "New-Alias -Name cargos -Value CargoBuilEverything -Force",
#         "New-Alias -Name cargosr -Value CargoRunEverything -Force",
#         "New-Alias -Name ff -Value fastfetchin -Force",
#         "New-Alias -Name cdd -Value WhichCD -Force",
#         "New-Alias -Name which -Value FWhich -Force",
#         "New-Alias -Name tmp -Value TempDir -Force",
