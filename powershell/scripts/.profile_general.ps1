$powershell_dir = "$dotfiles_dir\powershell"
$powershell_scripts_dir = "$powershell_dir\scripts"
$powershell_completions = "$powershell_scripts_dir\completions"

. "$powershell_scripts_dir\.func_vim_shell.ps1"
. "$powershell_scripts_dir\general.ps1"
. "$powershell_scripts_dir\python.ps1"

. "$powershell_completions\gh-cli.ps1"
. "$powershell_completions\az-cli.ps1"
. "$powershell_completions\atac.ps1"
. "$powershell_completions\general.ps1"
. "$powershell_completions\jj.ps1"
. "$powershell_completions\jj_aa.ps1" # Same as jj
