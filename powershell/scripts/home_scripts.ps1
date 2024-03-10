$powershell_dir = "$dotfiles_dir\powershell"
$powershell_scripts_dir = "$powershell_dir\scripts"
$powershell_completions = "$powershell_scripts_dir\completions\"

$home_theme = '1MrDwarf7Theme.omp.json'
$backup_theme = 'chips.omp.json'


# Not required at work
. "$powershell_scripts_dir\wsl_func_shell.ps1"

. "$powershell_scripts_dir\navigation_func_home.ps1"

. "$powershell_completions\completion_docker-compose.ps1"


try
{
    oh-my-posh init pwsh --config $env:POSH_THEMES_PATH\$home_theme | Invoke-Expression
} catch
{
    oh-my-posh init pwsh --config $env:POSH_THEMES_PATH\$backup_theme | Invoke-Expression
}

Import-Module git-aliases -DisableNameChecking
Import-Module posh-cargo
Import-Module DockerCompletion
Import-Module PSReadLine
Import-Module -Name CompletionPredictor
