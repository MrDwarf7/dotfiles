#
function RemoteProcessLauncher {
    param(
        [string]$ProcessFolder,
        [string]$ProcessExecutable,
        $additionalArgs = $args
    )

    if ([String]::IsNullOrEmpty($ProcessFolder)) {
        Write-Host "ProcessFolder is null or empty, defaulting."
        $ProcessFolder = "C:\WINDOWS\system32"
    }

    if ([String]::IsNullOrEmpty($ProcessExecutable)) {
        Write-Host "ProcessExecutable is null or empty, defaulting."
        $ProcessExecutable = "notepad.exe"
    }

    $ProcessPath = "$ProcessFolder\$ProcessExecutable"
    # Write-Host "ProcessPath: $ProcessPath"

    Start-Process -FilePath $ProcessPath -ArgumentList $additionalArgs -PassThru

}
