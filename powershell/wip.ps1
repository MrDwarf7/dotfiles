
# function IsStringOrNull {
#     param(
#         [Parameter(Mandatory = $false)]
#         $number
#     );
#
#     if ($null -eq $number) {
#     Write-Host "Is null"
#        { return [bool]$true };
#     }
#
#     if (-not($number -match "^\d+$")) {
#         Write-Host "Not a number"
#         { return [bool]$true };
#     } else {
#         Write-Host "Is a number"
#         { return [bool]$false };
#     };
# }


# function navup {
#     param (
#         [Parameter(Mandatory = $false)]
#         $level_in = $args[0],
#
#         [Parameter(Mandatory = $false)]
#         [int]$new_level = 0,
#         
#         [Parameter(Mandatory = $false)]
#         [string]$prefix = "..\"
#
#     );
#
#     # Write-Host "Level In: $level_in";
#     # Write-Host "New Level INIT: $new_level";
#     #
#     # if (-not(IsStringOrNull($level_in))) {
#     #     if ($level_in -lt 0 -or $level_in -eq 0 -or $level_in -eq 1) {
#     #         $new_level = 1;
#     #    };
#     #     # $new_level = 0;
#     # }
#     #
#     #
#     # # $new_level = EnsureCondition($level_in, $new_level);
#     # $prefix = $prefix * $new_level;
#     # Write-Host "Prefix: $prefix";
#     # Set-Location -Path $prefix;
#
#     Write-Host "Level In BEFORE NULL CH: $level_in";
#     Write-Host "New level  BEFORE NULL CH: $new_level";
#     $level_base = $level_in;
#     if (IsStringOrNull([ref]$level_base).Equals($true)) {
#         $level_in = [int]0;
#     };
#
#     Write-Host "Level In AFTER NULL CH: $level_in";
#     Write-Host "New level AFTER NULL CH: $new_level";
#
#     # if it isn't empty, basically
#     # if (-not($null -eq $level_in)) {
#     #     Write-Host "Not null -> level = level_in - 1"
#     #     $new_level = $level_in - 1;
#     # }
#     # Write-Host "New Level: $new_level";
#
#
#     # if (-not($null -eq $level_in))  {
#     #     Write-Host "Not null -> level = level_in - 1"
#     #     $new_level = $level_in - 1;
#     # } else {
#     #     Write-Host "Is null -> level = 0"
#     #     $new_level = 0;
#     # };
#
#     # Write-Host "New Level: $new_level";
#     # $prefix = "..\";
#
#     if ($level_in -lt 0 -or $level_in -eq 0) {
#         Write-Host "Is lt 0 || 0 -> level = 0";
#         $new_level = 1;
#     };
#
#     $prefix = $prefix * $new_level;
#     Write-Host "Prefix: $prefix";
#
#     Set-Location -Path $prefix;
# }


# function navup($level = $args[0]) {
#     # We want to take the level provided and go up that many directories
#     # If the level is not provided, we want to go up one directory
#     # If the level is greater than the number of directories we have, we want to go to the root directory
#     $prefix = "..\"
#
#     if ($null -eq $level) {
#         Write-Host "Is null -> level = 0"
#         $level = 0
#     } else {
#         if ($level -lt 0 -or $level -eq 0) {
#         Write-Host "Is lt 0 || 0 -> level = 0"
#             $level = 0
#         }
#         Write-Host "didn't meet any condition, ret level"
#         $level
#     }
#
#     $level = $level + 2
#
#     $prefix = $prefix * $level
#     Set-Location -Path $prefix
# }
#




# New-Alias -Name 1 -Value NavigateUp -Force
# New-Alias -Name 2 -Value NavigateUp -Force
# New-Alias -Name 3 -Value NavigateUp -Force
# New-Alias -Name 4 -Value NavigateUp -Force
# New-Alias -Name 5 -Value NavigateUp -Force
# New-Alias -Name 6 -Value NavigateUp -Force

# Cargo Aliases
#
# Not currently working while function c is in place
# SafeNewAlias -Alias cb -Command CargoBuild
# SafeNewAlias -Alias cr -Command CargoRun
# SafeNewAlias -Alias crq -Command CargoRunQuiet
# SafeNewAlias -Alias cbr -Command CargoBuildRelease
# SafeNewAlias -Alias crr -Command CargoRunRelease
# SafeNewAlias -Alias ct -Command CargoTest
# SafeNewAlias -Alias cc -Command CargoCheck
# SafeNewAlias -Alias ccl -Command CargoClean
# SafeNewAlias -Alias cu -Command CargoUpdate
# SafeNewAlias -Alias cdoc -Command CargoDoc
# SafeNewAlias -Alias cup -Command CargoUpgrade
# SafeNewAlias -Alias cu -Command CargoUpdate
# SafeNewAlias -Alias cdoc -Command CargoDoc
# SafeNewAlias -Alias cup -Command CargoUpgrade
#
