$env:LIST_CLIENT = "eza $args";

function RunEza {
    param (
        $Path,
        $CliArgs = ""
    )
    $executable = "eza";
    $eza_args = "$CliArgs $Path";
    & Invoke-Expression "$executable $eza_args";
}

function ClearAndList {
    param (
        $ag = $args
    )
    Clear-Host
    $eza_args = "-a --tree --level=1 --icons=always";
    & RunEza -Path $ag -CliArgs $eza_args;
}

New-Alias -Name ca -Value ClearAndList -Force;

function EasyList {
    param (
        $ag = $args
    )
    $eza_args = "-alh --color=always --level=1";
    & RunEza -Path $ag -CliArgs $eza_args;
}

New-Alias -Name l -Value EasyList -Force;

function AltList {
    param (
        $ag = $args
    )
    $eza_args = "-a --tree --level=1 --icons=always";
    & RunEza -Path $ag -CliArgs $eza_args;
}

New-Alias -Name la -Value AltList -Force

function ListTree {
    param (
        $ag = $args
    )
    $eza_args = "-a --tree --level=2 --icons=always";
    & RunEza -Path $ag -CliArgs $eza_args;
}

New-Alias -Name lt -Value ListTree -Force;
