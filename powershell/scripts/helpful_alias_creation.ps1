function SafeNewAlias
{
    param (
        [string]$Alias,
        [string]$Command
    )
    if (-not (Get-Alias -Name $Alias -ErrorAction SilentlyContinue))
    {
        New-Alias -Name $Alias -Value $Command
    } 
}

# Generic Aliases
SafeNewAlias -Alias grep -Command Select-String
SafeNewAlias -Alias which -Command Get-Command
SafeNewAlias -Alias ln -Command New-SymLink
SafeNewAlias -Alias npp -Command notepad++.exe


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
#
#

