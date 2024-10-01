$env:LIST_CLIENT = "ls";

function ClearAndList {
    param ($path = ".")
    Clear-Host;
    Get-ChildItem $path -Force;
}
New-Alias -Name ca -Value ClearAndList -Force


function EasyList {
    param ($path = ".")
    Get-ChildItem $path -Force;
}
New-Alias -Name l -Value EasyList -Force

function AltList {
    param ($path = ".")
    Get-ChildItem $path -Force;
}
New-Alias -Name la -Value AltList -Force
