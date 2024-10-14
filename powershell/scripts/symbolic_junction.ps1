function HandleRelativePath($currentLoc, $path) {

    if ($path.EndsWith("\") -or $path.EndsWith("/")) {
        $path = $path.Substring(0, $path.Length - 1);
    }

    if ($null -eq $currentLoc) {
        $currentLoc = Get-Location;
    }
    if ($path.StartsWith(".") -or $path.StartsWith("..")) {
        $newPath = $currentLoc.Path + $path.Substring(1);
        return $newPath;
    }
    if ($path.StartsWith("~")) {
        return $env:USERPROFILE + $path.Substring(1);
    }
    return $path;
}

function New-SymbolicJunction($folderToResolveTo, $turnFolderIntoSym) {
    if (Get-Service -Name cexecsvc -ErrorAction SilentlyContinue) {
        cmd.exe /d /c "mklink /j `"$turnFolderIntoSym`" `"$folderToResolveTo`"";
    } else {
        New-Item -Path $turnFolderIntoSym -ItemType Junction -Value $folderToResolveTo | Out-Null;
    };
    attrib.exe $turnFolderIntoSym +R /L;
}

function CreateNewSymbolic {
    $folderToResolveTo = $args[0];
    $turnFolderIntoSym = $args[1];

    $folderToResolveTo = HandleRelativePath $null $folderToResolveTo;
    $turnFolderIntoSym = HandleRelativePath $null $turnFolderIntoSym;

    if (-not(Test-Path $turnFolderIntoSym)) {
        New-Item -Path $turnFolderIntoSym -ItemType Directory | Out-Null;
    };

    New-SymbolicJunction -folderToResolveTo $folderToResolveTo -turnFolderIntoSym $turnFolderIntoSym | Out-Null;
}

New-Alias -Name ln -Value CreateNewSymbolic -Force;

function Remove-SymbolicJunction([string]$pathToUnlink) {
    $pathToUnlink = HandleRelativePath $null $pathToUnlink;

    if (Test-Path $pathToUnlink) {
        attrib.exe -R /L $pathToUnlink
    };

    if (Get-Service -Name cexecsvc -ErrorAction SilentlyContinue) {
        cmd.exe /d /c "rmdir `"$pathToUnlink`"";
    } else {
        Remove-Item -Path $pathToUnlink -Force -Recurse;
    };
}

New-Alias -name unlink -Value Remove-SymbolicJunction -Force;