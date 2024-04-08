function archsh {
    & 'C:\Windows\system32\wsl.exe' -d Arch --cd ~ --user dwarf
}

function debsh {
    & 'C:\Windows\system32\wsl.exe' -d Debian --cd ~ --user dwarf
}

function nixsh {
    & 'C:\Windows\system32\wsl.exe' -d NixOS --cd ~
}

function ubsh {
    & 'C:\Windows\system32\wsl.exe' -d Ubuntu --cd ~ --user dwarf
}

function disloc {
    if (-not ($args)) {
    (Get-ChildItem HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss | ForEach-Object { Get-ItemProperty $_.PSPath }) | Select-Object DistributionName, BasePath
    } elseif ($args -eq "v" -or "V") {
    (Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss" -Recurse)
    } else {
        Write-Error ErrorAction
    }
}

# END - Shell functions

#Easily open unix related terminals

# BEGIN - WSL specific things
function wsllv {
    wsl --list --verbose
}

function wsls {
    wsl --shutdown
}

