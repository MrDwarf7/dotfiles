#Update OhMyPosh using this command -
# winget upgrade JanDeDobbeleer.OhMyPosh -s winget
#
# Typer-Cli completion. 
# Installed via pip install typer-cli

# Dotfiles copy
$env:HOME_PROFILE = $false
$env:POSH_GIT_ENABLED = $true

$dotfiles_dir = "$HOME\dotfiles"
$work_app_dir = "C:\Applications"
$work_scripts_dir = "$work_app_dir\PowerShell_start\scripts"

$powershell_dir = "$dotfiles_dir\powershell"
$powershell_scripts_dir = "$powershell_dir\scripts"

$work_theme = '1Custom_Work_powerlevel10k_rainbow.omp.json'
$home_theme = '1MrDwarf7Theme.omp.json'
$backup_theme = 'chips.omp.json'

# Unused for time being as they just sit in my dotfiles atm anyway lol
#
# $home_GitHub = "E:\GitHub"
# $home_scripts_dir = "D:\Documents\PowerShell\home_scripts"

### START MAIN SCRIPT

# BEGIN - Alias(s)
Import-Module DockerCompletion
#Git aliases from Oh-my-zsh Git plugin for PWSH
Import-Module git-aliases -DisableNameChecking

New-Alias grep Select-String
New-Alias which Get-Command
New-Alias ln New-SymLink

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile))
{
    Import-Module "$ChocolateyProfile"
}
# END - Alias(s)


# BEGIN - Tooling Functions
function Test-CommandExists ([Parameter(Mandatory = $true)][string] $Command)
{
    return [bool](Get-Command $Command -ErrorAction SilentlyContinue)
}
# Work.sort of
function checkEnvironment
{
    if ($env:COMPUTERNAME -clike "*LG*")
    {
        return $true
    } else
    {
        return $false
    }
}
# END - Tooling Functions

# Work
if (checkEnvironment)
{
    . "$work_scripts_dir\navigation_func_work.ps1"

    . "$work_scripts_dir\python_func_work.ps1"

    . "$work_scripts_dir\shell_alias_func_work.ps1"

    try
    {
        oh-my-posh init pwsh --config $env:LOCALAPPDATA\Programs\oh-my-posh\themes\$work_theme | Invoke-Expression
    } catch
    {
        oh-my-posh init pwsh --config $env:LOCALAPPDATA\Programs\oh-my-posh\themes\$backup_theme | Invoke-Expression
    }

    # oh-my-posh init pwsh --config $env:LOCALAPPDATA\Programs\oh-my-posh\themes\$work_theme | Invoke-Expression
}

# Not work/ AKA Home
if (-not (checkEnvironment))
{
    # Not required at work
    . "$powershell_scripts_dir\wsl_func_shell.ps1"

    . "$powershell_scripts_dir\navigation_func_home.ps1"


    try
    {
        oh-my-posh init pwsh --config $env:LOCALAPPDATA\Programs\oh-my-posh\themes\$home_theme | Invoke-Expression
    } catch
    {
        oh-my-posh init pwsh --config $env:LOCALAPPDATA\Programs\oh-my-posh\themes\$backup_theme | Invoke-Expression
    }

    # oh-my-posh init pwsh --config $env:LOCALAPPDATA\Programs\oh-my-posh\themes\$home_theme | Invoke-Expression
}

. "$powershell_scripts_dir\completion_scripts.ps1"
                          
. "$powershell_scripts_dir\vim_func_shell.ps1"
                          
. "$powershell_scripts_dir\helpful_func_general.ps1"
                          
. "$powershell_scripts_dir\helpful_func_python.ps1"

#Raw Functions

function workconf
{
    if (-not ($args))
    {
        Start-Process $work_scripts_dir
    }
    if ( $args)
    {
        if ($args -eq "vim")
        {
            vim $work_scripts_dir
        }
        if ($args -eq "code")
        {
            code $work_scripts_dir
        } 
    }
}

# Linux Functions # these are also present in the scripts/helpful_func_general.ps1, 
# I just don't want it breaking with the amount I change things haha

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

# if I decide to start using starship, well this is how I would do it.
#Invoke-Expression (&starship init powershell)



