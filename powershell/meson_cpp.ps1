$Global:current = Get-Location
$Global:current_dir_name = (Get-Item $current).Name
$Global:dummyText = "int main() { 
    return 0;
}"

function CheckMesonExistence {
    $meson = Get-Command meson
    if ($null -eq $meson) {
        Write-Host "Meson is not installed. Please install it."
        Write-Host "Consider running scoop install meson"
        Read-Host "Would you like to install it now? (y/n)"
        $response = Read-Host
        if ($response -eq "y") {
            Invoke-Expression "scoop install meson"
        }
        return
    }
    return
}


function InitCMeson {
    Invoke-Expression "echo $dummyText > main.cpp"
    Mkdir build
    Invoke-Expression BuildScript
}

function BuildScript {
    $runnable = "ninja -C build"
    Invoke-Expression $runnable
}

function RunTheExe {
    $build_dir = Join-Path $current "build"
    $exe_name = "$current_dir_name.exe"
    $runnable = "$build_dir/$exe_name"
    Invoke-Expression $runnable
}


function BuildRun {
    BuildScript
    RunTheExe
}

function ShowNewCommands {
    $cols=@(
    [PSCustomObject]@{Command="mc"; Description="InitCMeson"},
    [PSCustomObject]@{Command="mb"; Description="BuildScript"},
    [PSCustomObject]@{Command="mr"; Description="RunTheExe"},
    [PSCustomObject]@{Command="mbr"; Description="BuildRun"}
    )

    $cols | Format-Table -AutoSize

    Write-Host "New Commands " -ForegroundColor Green -NoNewline
    Write-Host "are available for use"
}

function main {

    Invoke-Expression CheckMesonExistence
    Invoke-Expression ShowNewCommands
}

if ($MyInvocation.InvocationName -eq ".\meson_cpp.ps1") {
    Invoke-Expression main
}

# if ($LASTEXITCODE -ne 0) {
#     return Write-Host "Error: $LASTEXITCODE"
# }


New-Alias -Name mc -Value InitCMeson -Force
New-Alias -Name mb -Value BuildScript -Force
New-Alias -Name mr -Value RunTheExe -Force
New-Alias -Name mbr -Value BuildRun -Force
