
$powershell_dir = "$dotfiles_dir\powershell"
$powershell_scripts_dir = "$powershell_dir\scripts"
$powershell_completions = "$powershell_scripts_dir\completions\"

. "$powershell_scripts_dir\vim_func_shell.ps1"

. "$powershell_scripts_dir\helpful_func_general.ps1"

# . "$powershell_scripts_dir\match_statement_tests.ps1"

. "$powershell_scripts_dir\helpful_func_python.ps1"

##

. "$powershell_completions\completion_general.ps1"

. "$powershell_completions\completion_gh-cli.ps1"

. "$powershell_completions\completion_az-cli.ps1"

. "$powershell_completions\completions_atac.ps1"
