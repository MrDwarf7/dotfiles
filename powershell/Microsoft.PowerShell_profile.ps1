#Update OhMyPosh using this command -
# winget upgrade JanDeDobbeleer.OhMyPosh -s winget
#
# Typer-Cli completion.
# Installed via pip install typer-cli
$env:PSModulePath=[NullString]

# Dotfiles copy
$env:HOME_PROFILE = $false
$env:POSH_GIT_ENABLED = $true
$env:PDM_IGNORE_ACTIVE_VENV = $true

$dotfiles_dir = "$HOME\dotfiles"
# $config_dir = "$dotfiles_dir\.config"

# $work_app_dir = "C:\Applications"
# $work_scripts_dir = "$work_app_dir\PowerShell_start\scripts"


$powershell_dir = "$dotfiles_dir\powershell"
$powershell_scripts_dir = "$powershell_dir\scripts"
# $powershell_completions = "$powershell_scripts_dir\completions\"

# $work_theme = '1Custom_Work_powerlevel10k_rainbow.omp.json'
# $home_theme = '1MrDwarf7Theme.omp.json'
# $backup_theme = 'chips.omp.json'

# Unused for time being as they just sit in my dotfiles atm anyway lol
#
# $home_GitHub = "E:\GitHub"
# $home_scripts_dir = "D:\Documents\PowerShell\home_scripts"

### START MAIN SCRIPT

# function MyViCliEditor
# {
#     $env:XDG_CONFIG_HOME = "$dotfiles_dir"
#     nvim -u $HOME\.vimrc
# }
# FunctionName | Invoke-Expression, this works but needs a handler for it

$env:EDITOR = $env:VISUAL = 'nvim'



# $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# if (Test-Path($ChocolateyProfile))
# {
#     Import-Module "$ChocolateyProfile"
# }
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
        $env:HOME_PROFILE = $false
        return $true
    } else
    {
        return $false
    }
}

# Ensure safe creation of aliases, all aliases are created in the helpful_alias_creation.ps1
. "$powershell_scripts_dir\helpful_alias_creation.ps1"

# END - Tooling Functions

# Work
if (checkEnvironment)
{
    . "$powershell_scripts_dir\work_scripts.ps1"
}

# Not work/ AKA Home
if (-not (checkEnvironment))
{
    . "$powershell_scripts_dir\home_scripts.ps1"
}

. "$powershell_scripts_dir\general_scripts.ps1"


#Raw Functions


# Linux Functions # these are also present in the scripts/helpful_func_general.ps1
# I just don't want it breaking with the amount I change things haha

# function pro
# {
#     . $PROFILE
# }



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
# Invoke-Expression (&starship init powershell)
# Invoke-Expression (& { (zoxide init powershell | Out-String) })


# BEGIN - Alias(s)
# Import-Module DockerCompletion
#Git aliases from Oh-my-zsh Git plugin for PWSH
# Import-Module git-aliases -DisableNameChecking
# removed pending testings
# Import-Module posh-cargo




