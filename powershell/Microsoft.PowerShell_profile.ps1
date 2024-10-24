#Update OhMyPosh using this command -
# winget upgrade JanDeDobbeleer.OhMyPosh -s winget
#
# Typer-Cli completion.
# Installed via pip install typer-cli

$currentPSModulePath = $env:PSModulePath
$workDefaultPSModulePath = "C:\Applications\PowerShell_start\Modules"
$env:PSModulePath=[NullString]
$env:PYTHON_PATH=[NullString]
# Invoke-Expression (& { (zoxide init powershell | Out-String) })

# $LazyLoadProfile = [PowerShell]::Create()
# [void]$LazyLoadProfile.AddScript(@'
#     Import-Module DockerCompletion
#     Import-Module PSReadLine
#     Import-Module -Name CompletionPredictor
#     Import-Module C:\Applications\PowerShell_start\Modules\posh-git\1.1.0\posh-git.psm1
# '@)
#
# $LazyLoadProfileRunspace = [RunspaceFactory]::CreateRunspace()
# $LazyLoadProfile.Runspace = $LazyLoadProfileRunspace
# $LazyLoadProfileRunspace.Open()
# [void]$LazyLoadProfile.BeginInvoke()
#
# $null = Register-ObjectEvent -InputObject $LazyLoadProfile -EventName InvocationStateChanged -Action {
#     Import-Module PSReadLine
#     Import-Module posh-git
#     Import-Module -Name DockerCompletion
#     Import-Module PSReadLine
#     Import-Module -Name CompletionPredictor
#     # Import-Module "$HOME\scoop\apps\posh-git\1.1.0\posh-git.psm1"
#     # Import-Module C:\Applications\PowerShell_start\Modules\posh-git\1.1.0\posh-git.psm1
#     # $global:GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "MM-dd HH:mm:ss") '
#     # $global:GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Magenta
#     # $global:GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'
#     # $global:GitPromptSettings.DefaultPromptAfterSuffix.Text = ''
#     #
#     $LazyLoadProfile.Dispose()
#     $LazyLoadProfileRunspace.Close()
#     $LazyLoadProfileRunspace.Dispose()
# }
#


# Dotfiles copy
$env:HOME_PROFILE = $false
$env:POSH_GIT_ENABLED = $true
$env:PDM_IGNORE_ACTIVE_VENV = $true
$env:BAT_CONFIG_PATH = "$dotfiles_dir\.config\bat\bat.conf"
$env:BAT_THEME="Monokai Extended Bright"
$env:EDITOR = $env:VISUAL = 'nvim'
$env:EDITOR = 'nvim'
$env:FZF_DEFAULT_COMMAND = 'fd --type file'
$env:FZF_CTRL_T_COMMAND = '$env:FZF_DEFAULT_COMMAND'
$env:STARSHIP_CONFIG = "$dotfiles_dir\.config\starship\starship.toml"

$dotfiles_dir = "$HOME\dotfiles"
$powershell_dir = "$dotfiles_dir\powershell"
$powershell_scripts_dir = "$powershell_dir\scripts"

# BEGIN - Tooling Functions
function Test-CommandExists ([Parameter(Mandatory = $true)][string] $Command) {
    return [bool](Get-Command $Command -ErrorAction SilentlyContinue)
}

if (Test-CommandExists "eza") {
    $env:LIST_CLIENT = "eza"
} 

if (Test-CommandExists "atac") {
    $env:ATAC_KEY_BINDINGS = "$dotfiles_dir\.config\atac\key_bindings.toml"
} 

# Work.sort of
function checkEnvironment {
    if ($env:COMPUTERNAME -clike "*LG*") {
        $env:HOME_PROFILE = $false
        return $true
    } else {
        return $false
    }
}

# Ensure safe creation of aliases, all aliases are created in the helpful_alias_creation.ps1
# ALIAS
. "$powershell_scripts_dir\helpful_alias_creation.ps1"
# END - Tooling Functions

Invoke-Expression (& { (zoxide init powershell | Out-String) })
Invoke-Expression -Command $(gh completion -s powershell | Out-String)

# Work
if (checkEnvironment -eq $true) {
    $env:PSModulePath = $workDefaultPSModulePath


    . "$powershell_scripts_dir\work_scripts.ps1"
}

# Not work/ AKA Home
if (-not (checkEnvironment)) {
    # $env:PAGER = less
    # $env:BAT_PAGER = less -RF

    $env:PSModulePath = $currentPSModulePath
    # TODO: Actually add this as an env key at home also not here

    # $env:WZT_GPU_FRONTEND = "WebGPU"
    # $env:WZT_GPU_POWER_PREF = "HighPerformance"

    # This is now static for all profiles
    # Invoke-Expression (& { (zoxide init powershell | Out-String) })
    . "$powershell_scripts_dir\home_scripts.ps1"
}

. "$powershell_scripts_dir\general_scripts.ps1"


if ($env:LIST_CLIENT -eq "eza") {
    . "$powershell_completions\eza_aliases.ps1"
} else {
    . "$powershell_completions\system_ls_aliases.ps1"
}

