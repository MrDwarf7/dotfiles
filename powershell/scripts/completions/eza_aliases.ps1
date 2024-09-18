$env:LIST_CLIENT = "eza $args";

function RunEza {
    param (
        $Path = $args,
        $CliArgs = ""
    )
    $executable = "eza";
    $eza_args = "$CliArgs $path";
    & Invoke-Expression "$executable $eza_args";

}

function ClearAndList {
    param (
        $path = $args
    )
    Clear-Host
    $eza_args = "-a --tree --level=1 --icons=always $path";
    & RunEza -Path $path -CliArgs $eza_args;
    # Invoke-Expression $env:LIST_CLIENT $eza_args;
}

New-Alias -Name ca -Value ClearAndList -Force;

function EasyList {
    param (
        $path = $args
    )
    $eza_args = "-alh --color=always --level=1 $path";
    & RunEza -Path $path -CliArgs $eza_args;
}
New-Alias -Name l -Value EasyList -Force;

function AltList {
    param (
        $path = $args
    )
    $eza_args = "-a --tree --level=1 --icons=always $path";
    & RunEza -Path $path -CliArgs $eza_args;
}

New-Alias -Name la -Value AltList -Force

function ListTree {
    param (
        $path = $args
    )
    $eza_args = "-a --tree --level=2 --icons=always $path";
    & RunEza -Path $path -CliArgs $eza_args;
}

New-Alias -Name lt -Value ListTree -Force;


# function ChildForClient {
#     param (
#         $Client,
#         [string]$Eza,
#         [string]$System
#     )
#
#     if ([String]::IsNullOrEmpty($Client)) {
#         $Client = Get-ChildItem
#         $env:LIST_CLIENT = $Client
#     }
#
#     switch ($client.ToLower()) {
#         "eza" {
#             $env:LIST_CLIENT = "eza"
#         }
#         default {
#             $env:LIST_CLIENT = "ls"
#         }
#     }
#     return $env:LIST_CLIENT
# }
# function GenericListClientUse {
#     param (
#     $Client,
#     [string]$EzaArgs,
#     [string]$GetChildItemArgs
#     )
#
#     if ([String]::IsNullOrEmpty($Client)) {
#         $Client = Get-ChildItem
#         $env:LIST_CLIENT = $Client
#     }
#
#     if ($Client -eq "eza") {
#         return "eza $EzaArgs"
#     } else {
#         Get-ChildItem $GetChildItemArgs
#     }
# }
# # Provide ALL info (etc)
# New-Alias -Name l -Value "$env:LIST_CLIENT -lah --color=always --level=1" -Force
# # provide standard levels (ie: hiddens but not list etc.)
# New-Alias -Name ls -Value "$env:LIST_CLIENT -ah --color=automatic" -Force
# # Simple list with icons included, less clutter
# New-Alias -Name lt -Value "$env:LIST_CLIENT -a --tree --level=2 --icons=always" -Force
# # same as ls with extra info
# New-Alias -Name la -Value "$env:LIST_CLIENT -a --tree --level=1 --icons=always" -Force
# # New-Alias ca="clear && $env:LIST_CLIENT -a --tree --level=1 --icons=always"
