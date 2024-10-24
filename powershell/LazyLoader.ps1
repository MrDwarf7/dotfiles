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
