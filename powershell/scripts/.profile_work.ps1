# Import-Module PSReadLine
# Import-Module git-aliases -DisableNameChecking
Import-Module -Name DockerCompletion
Import-Module -Name CompletionPredictor

$work_app_dir = "C:\Applications"
$work_scripts_dir = "$work_app_dir\PowerShell_start\scripts"
# $work_scripts_dir = "$work_app_dir\PowerShell_start\scripts"
# $work_theme = '1Custom_Work_powerlevel10k_rainbow.omp.json'
# $backup_theme = 'chips.omp.json'

$PYTHON_PATH=[NullString] | Select-Object -Property "Python3"

. "$work_scripts_dir\navigation_func_work.ps1"
. "$work_scripts_dir\python_func_work.ps1"
. "$work_scripts_dir\shell_alias_func_work.ps1"
. "$work_scripts_dir\wsl_func_shell.ps1"

function workconf {
    if (-not ($args)) {
        Push-Location $work_scripts_dir
    }
    if ( $args) {
        if ($args -eq "vim") {
            vim $work_scripts_dir
        }
        if ($args -eq "code") {
            code $work_scripts_dir
        }
    }
}
