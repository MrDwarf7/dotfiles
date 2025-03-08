$powershell_dir = "$dotfiles_dir\powershell"
$powershell_scripts_dir = "$powershell_dir\scripts"
$powershell_completions = "$powershell_scripts_dir\completions"
# $broot_source = "${env:APPDATA}\dystroy\broot\config\launcher\powershell\br.ps1"

# Not required at work
. "$powershell_scripts_dir\.func_wsl_shell.ps1"
. "$powershell_scripts_dir\.navigation_home.ps1"
. "$powershell_completions\docker-compose.ps1"
. "$powershell_completions\ein.ps1"
. "$powershell_completions\gix.ps1"

Import-Module gsudoModule
Import-Module git-aliases -DisableNameChecking
Import-Module DockerCompletion
# Import-Module PSReadLine
Import-Module -Name CompletionPredictor
# . "$env:APPDATA\dystroy\broot\config\launcher\powershell\br.ps1"
# . $broot_source
