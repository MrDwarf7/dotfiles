#Update OhMyPosh using this command -
# winget upgrade JanDeDobbeleer.OhMyPosh -s winget
#
# Typer-Cli completion.
# Installed via pip install typer-cli


Invoke-Expression (
    [System.Text.StringBuilder]::new().Append("Invoke-Expression (&starship init powershell)").
        Append("`n").
        Append("Invoke-Expression (& { (zoxide init powershell | Out-String) })").
        Append("`n").
        Append("Invoke-Expression (& { (gh completion -s powershell | Out-String) })") 
    ).ToString() > $null

# $prompt = ""
# function Invoke-Starship-PreCommand {
#     $current_location = $executionContext.SessionState.Path.CurrentLocation
#     if ($current_location.Provider.Name -eq "FileSystem") {
#         $ansi_escape = [char]27
#         $provider_path = $current_location.ProviderPath -replace "\\", "/"
#         $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
#     }
#     $host.ui.Write($prompt)
# }


$dotfiles_dir = "$HOME\dotfiles"
$powershell_dir = "$dotfiles_dir\powershell"
$powershell_scripts_dir = "$powershell_dir\scripts"

# Store current PSModulePath before we wipe it
$currentPSModulePath = $env:PSModulePath
# Set a var for work PSModulePath 
$workDefaultPSModulePath = "C:\Applications\PowerShell_start\Modules"
$env:PSModulePath=[NullString]
$env:PYTHON_PATH=[NullString]

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
