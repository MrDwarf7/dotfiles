function sign_executable {
    param(
        [string]$exePath,
        [string]$certPath,
        [string]$signtoolPath
    )

    # Prompt for the EXE location if not provided
    if (-not $exePath) {
        $exePath = Read-Host "Enter the full path to the EXE file"
    }

    # Check if the EXE file exists
    if (-not (Test-Path $exePath)) {
        Write-Error "EXE file not found at the path: $exePath"
        return
    }

    # Check for existing certificate, prompt for cert location if not provided
    if (-not $certPath) {
        $certPath = Read-Host "Enter the full path to save the new certificate (including file name and .pfx extension)"
    }

    if (-not (Test-Path $certPath)) {
        # Generate a self-signed certificate
        $cert = New-SelfSignedCertificate -DnsName "Localhost" -CertStoreLocation "cert:\LocalMachine\My" -NotAfter (Get-Date).AddYears(5)
        Export-PfxCertificate -Cert "cert:\LocalMachine\My\$($cert.Thumbprint)" -FilePath $certPath -Password (ConvertTo-SecureString -String "password" -Force -AsPlainText)
        Write-Host "Certificate generated and saved to: $certPath"
    } else {
        Write-Host "Using existing certificate at: $certPath"
    }

    # Prompt for signtool.exe location if not provided
    if (-not $signtoolPath) {
        $signtoolPath = Read-Host "Enter the full path to signtool.exe"
    }

    # Check if signtool exists
    if (-not (Test-Path $signtoolPath)) {
        Write-Error "signtool.exe not found at the path: $signtoolPath"
        return
    }

    # Sign the EXE
    $signCmd = "& `"$signtoolPath`" sign /f `"$certPath`" /p password `"$exePath`" /fd SHA256"
    Invoke-Expression $signCmd

    Write-Host "EXE signed successfully."
}


