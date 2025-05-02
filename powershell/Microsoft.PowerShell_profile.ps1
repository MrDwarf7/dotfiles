# String builder voodoo - shown to be bette performance than either sets or a loop lol...
# This is something used wherever multiple invocations are needed for other parts of the profile
Invoke-Expression (
    [System.Text.StringBuilder]::new().Append("Invoke-Expression (&starship init powershell)").
    Append("`n").
    Append("Invoke-Expression (& { (zoxide init powershell | Out-String) })").
    Append("`n").
    Append("Invoke-Expression (& { (gh completion -s powershell | Out-String) })").
    Append("`n").
    Append("Invoke-Expression (& { (carapace _carapace | Out-String) })")
).ToString() > $null -ErrorAction SilentlyContinue

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
$env:HOME_PROFILE = $true
$env:PDM_IGNORE_ACTIVE_VENV = $true
$env:BAT_CONFIG_DIR = "$dotfiles_dir\.config\bat"
$env:BAT_CONFIG_PATH = "$env:BAT_CONFIG_DIR\bat.conf"
$env:BAT_THEME="Monokai Extended Bright"
$env:EDITOR = $env:VISUAL = 'nvim'
$env:EDITOR = 'nvim'
$env:FZF_DEFAULT_COMMAND = 'fd --type file'
$env:FZF_CTRL_T_COMMAND = '$env:FZF_DEFAULT_COMMAND'
$env:STARSHIP_CONFIG = "$dotfiles_dir\.config\starship\starship.toml"
$env:CARAPACE_BRIDGES = 'all'

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
function isWorkMachine  {
    if ($env:COMPUTERNAME -clike "*LG*") {
        $env:HOME_PROFILE = $false
        return [bool]$true 
    } else {
        return [bool]$false
    }
}

# Ensure safe creation of aliases, all aliases are created in the alias_creation.ps1
# ALIAS
. "$powershell_scripts_dir\.alias_creation.ps1"
# END - Tooling Functions

# Work
if (isWorkMachine -eq $true) {
    $env:PSModulePath = $workDefaultPSModulePath
    . "$powershell_scripts_dir\.profile_work.ps1"
}

# Not work/ AKA Home
if (-not (isWorkMachine)) {
    # $env:PAGER = less
    # $env:BAT_PAGER = less -RF
    $env:PSModulePath = $currentPSModulePath
    . "$powershell_scripts_dir\.profile_home.ps1"
}

# Has - [vim, func_gen, func_py, comp_gen, comp_gh, comp_az, comp_atac]
. "$powershell_scripts_dir\.profile_general.ps1"

if ($env:LIST_CLIENT -eq "eza") {
    . "$powershell_completions\.alias_eza.ps1"
} else {
    . "$powershell_completions\.alias_system_ls.ps1"
}

Write-Host -NoNewLine "`e[5 q" # Set the cursor to a blinking line.
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
# Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
