$env:LIST_CLIENT = "eza $args";

function RunEza {
  param (
    $Path,
    $CliArgs
  )
  if (-not $Path) {
    $Path = ".";
  }
  # Write-Host "Running eza with: $CliArgs $Path";
  & Invoke-Expression("eza $CliArgs `"$Path`"");

  ## Previous way of doing this lol
  # $executable = "eza";
  # $eza_args = "$CliArgs $Path";
  # & Invoke-Expression "$executable $eza_args";
}

function ClearAndList {
  param (
    $ag = $args
  )
  Clear-Host
  $eza_args = "-lah --color=always --follow-symlinks --icons=always --git";
  & RunEza -Path $ag -CliArgs $eza_args;
}
New-Alias -Name ca -Value ClearAndList -Force;

function EasyList {
  param (
    $ag = $args
  )
  $eza_args = "-lah --color=always --follow-symlinks --icons=always";
  & RunEza -Path $ag -CliArgs $eza_args;
}
New-Alias -Name la -Value EasyList -Force;

function AltList {
  param (
    $ag = $args
  )
  $eza_args = "-a --color=always --follow-symlinks --icons=always --git --tree --level=1";
  & RunEza -Path $ag -CliArgs $eza_args;
}
New-Alias -Name l -Value AltList -Force

function ListTree {
  param (
    [string]$ag = $args,
    [int]$d = 3
  )

  $eza_args = "-a --color=always --follow-symlinks --icons=always --git --tree --level=$d";
  & RunEza -Path $ag -CliArgs $eza_args;
}
New-Alias -Name lt -Value ListTree -Force;
