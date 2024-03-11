function SafeNewAlias
{
    param (
        [string]$Alias,
        [string]$Command
    )
    if (-not (Get-Alias -Name ${Alias} -ErrorAction SilentlyContinue))
    {
        New-Alias -Name ${Alias} -Value ${Command}
    }
    if ((Get-Alias -Name ${Alias} -ErrorAction SilentlyContinue).Definition -ne ${Command})
    {
        Remove-Alias -Name ${Alias}
        New-Alias -Name ${Alias} -Value ${Command}
    }
}

# Formatted via powershell version for now
function fwhich
{
    param (
        [string]$cmd
    )
    Get-Command -ErrorAction "SilentlyContinue" $cmd
    | Format-Table Source
}

function RemoveWrapper
{
    if ($args -eq $null)
    {

        Remove-Item $args
        return
    }

    if ($args.Contains("r") -or $args.Contains("R"))
    {
        Remove-Item -Recurse $args
        return
    }

    if ($args.Contains("f") -or $args.Contains("F"))
    {
        Remove-Item -Force $args
        return
    }

    if ($args.Contains("f") -or $args.Contains("F") -and $args.Contains("r") -or $args.Contains("R"))
    {
        Remove-Item -Force -Recurse $args
        return
    }
}

# Generic Aliases
SafeNewAlias -Alias grep -Command Select-String
SafeNewAlias -Alias ln -Command New-SymLink
SafeNewAlias -Alias npp -Command notepad++.exe
SafeNewAlias -Alias bpsa -Command sar
SafeNewAlias -Alias rm -Command RemoveWrapper $args


# New-Alias -Name which -Value where.exe
SafeNewAlias -Alias which -Command where.exe

SafeNewAlias -Alias br -Command broot.exe


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


# SafeNewAlias -Alias goto -Command cx $args

# Git Aliases - WIP
#

