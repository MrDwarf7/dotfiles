$Global:current = Get-Location
$Global:current_dir_name = (Get-Item $current).Name
$Global:dummyText = "int main() { 
    return 0;
}"

function Check-Meson-Existence {
    $meson = Get-Command meson
    if ($meson -eq $null) {
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


function Init-C-Meson {
    Invoke-Expression "echo $dummyText > main.cpp"
    Mkdir build
    Invoke-Expression Build-Script
}

function Build-Script {
    $runnable = "ninja -C build"
    Invoke-Expression $runnable
}

function Run-The-Exe {
    $build_dir = Join-Path $current "build"
    $exe_name = "$current_dir_name.exe"
    $runnable = "$build_dir/$exe_name"
    Invoke-Expression $runnable
}

function Build-Run {
    Build-Script
    Run-The-Exe
}

function Show-New-Commands {
    $cols=@(
    [PSCustomObject]@{Command="c"; Description="Init-C-Meson"},
    [PSCustomObject]@{Command="b"; Description="Build-Script"},
    [PSCustomObject]@{Command="rr"; Description="Run-The-Exe"},
    [PSCustomObject]@{Command="br"; Description="Build-Run"}
    )

    $cols | Format-Table -AutoSize

    Write-Host "New Commands " -ForegroundColor Green -NoNewline
    Write-Host "are available for use"
}

function main {
    New-Alias -Name c -Value Init-C-Meson -Force
    New-Alias -Name b -Value Build-Script -Force
    New-Alias -Name rr -Value Run-The-Exe -Force
    New-Alias -Name br -Value Build-Run -Force

    Invoke-Expression Check-Meson-Existence
    Invoke-Expression Show-New-Commands
}

Invoke-Expression main
