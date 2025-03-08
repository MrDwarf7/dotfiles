# $LazyLoadProfile = [PowerShell]::Create()
# [void]$LazyLoadProfile.AddScript(@'
#     Import-Module DockerCompletion
#     Import-Module PSReadLine
#     Import-Module -Name CompletionPredictor
# '@)
#
# $LazyLoadProfileRunspace = [RunspaceFactory]::CreateRunspace()
# $LazyLoadProfile.Runspace = $LazyLoadProfileRunspace
# $LazyLoadProfileRunspace.Open()
# [void]$LazyLoadProfile.BeginInvoke()
#
# $null = Register-ObjectEvent -InputObject $LazyLoadProfile -EventName InvocationStateChanged -Action {
#     Import-Module PSReadLine
#     Import-Module -Name DockerCompletion
#     Import-Module PSReadLine
#     Import-Module -Name CompletionPredictor
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
