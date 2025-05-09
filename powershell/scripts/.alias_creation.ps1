
# using namespace System.Collections.Generic;
# using namespace System.Collections.ObjectModel;
# using namespace System.Collections.Concurrent;

function SafeNewAlias {
  param (
    [string]$Alias,
    [string]$Command
  )
  if (-not (Get-Alias -Name ${Alias} -ErrorAction SilentlyContinue)) {
    New-Alias -Name ${Alias} -Value ${Command}
  }
  if ((Get-Alias -Name ${Alias} -ErrorAction SilentlyContinue).Definition -ne ${Command}) {
    Remove-Alias -Name ${Alias}
    New-Alias -Name ${Alias} -Value ${Command}
  }
}

# Formatted via powershell version for now
function FWhich {
  param (
    [string]$cmd
  )
  $commandInfo = Get-Command -ErrorAction "SilentlyContinue" $cmd
  if ($commandInfo) {
    $commandInfo.Source
  } else {
    Write-Output "Command not found: $cmd"
  }
}

function WhichCD {
  param(
    [string]$commandName
  )

  $execPath = (Get-Command $commandName).Source

  if (-not $execPath) {
    Write-Warning "Command not found: $commandName"
    return
  }
  $directory = [System.IO.Path]::GetDirectoryName($execPath)
  Set-Location -Path $directory
}
# New-Alias -Name cdd -Value WhichCD -Force


function Remove-Wrapper {
  # Initialize flags and paths
  $force = $false
  $recurse = $false
  $paths = @()

  # Process each argument
  foreach ($arg in $args) {
    switch -Regex ($arg) {
      '^-(.*r.*)$' {
        $recurse = $true
      }
      '^-(.*f.*)$' {
        $force = $true
      }
      Default {
        $paths += $arg
      }
    }
  }

  Write-Host "Force: $force"
  Write-Host "Recurse: $recurse"
  Write-Host "Paths: $paths"
  Write-Host "Args: $args"

  foreach ($path in $paths) {
    try {
      $resolvedPath = Resolve-Path -Path $path

      if (Test-Path $resolvedPath -PathType Container) {
        [System.IO.Directory]::Delete($resolvedPath, $recurse)
      } else {
        if ($force) {
          Set-ItemProperty -Path $resolvedPath -Name IsReadOnly -Value $false
        }
        [System.IO.File]::Delete($resolvedPath)
      }
    } catch {
      Write-Error "Failed to remove path:  $path"
      Write-Error "Failed to remove res path:  $resolvedPath"
      Write-Host "Force: $force"
      Write-Host "Recurse: $recurse"
      Write-Host "Paths: $paths"
      Write-Host "Args: $args"
    }
  }
}

function TempDir {
  $c_temp_folder = "c:\temp"
  Push-Location $c_temp_folder
  la
}


function ManPageWindow {
  param (
    [string]$command
  )
  Get-Help -Name $command -ShowWindow
}

function ManPage {
  param(
    [string]$command
  )
  Get-Help -Name $command -Full | Out-String -Width 120 | less --quiet --silent --line-numbers
  # | bat --paging=always --decorations=always
}

function CleanLess {
  return less --quiet --silent --line-numbers $args
}

# Not working as intended at all but eh
# New-Alias -Name lessp -Value CleanLess -Force
# New-Alias -Name lessp -Value CleanLess -Force
# SafeNewAlias -Alias lessp -Command CleanLess $args

function CargoBuildEverything {
  $command = "cargo build && cargo build --release $args"
  Invoke-Expression $command
}

function CargoRunEverything {
  $command = "cargo run && cargo run --release $args"
  Invoke-Expression $command
}

function ZoxideAdd {
  zoxide add .
}

function ZoxideEdit {
  zoxide edit
}

function ZoxideQuery {
  zoxide query $args
}


function NavigateToRust {
  Invoke-Expression "z Rust"
}

function time { 
  $Command = "$args";
  Measure-Command { 
    Invoke-Expression $Command 2>&1 | Out-Default
  }
}

function timen { 
  $Command = "$args";
  Measure-Command { 
    Invoke-Expression $Command 2>&1 | Out-Null
  }
}

function ffff() {
  $max = 23;
  $min = 2;

  If (-not (Test-CommandExists "fastfetch")) {
    Write-Output "fastfetch is not installed"
    return
  }

  Clear-Host;
  for ($i = $min; $i -lt $max; $i++) {
    Write-Host
    Write-Host
    Write-Host "Example $i"

    $config = "examples/$i";
    Invoke-Expression "fastfetch --config $config";
  }
}

function fastfetchin() {
  $num = 21
  $config = "--config examples/$num"

  If (-not (Test-CommandExists "fastfetch")) {
    Write-Output "fastfetch is not installed"
    return
  }
  Write-Host
  Write-Host
  Invoke-Expression "fastfetch $config";
  Write-Host
}

. "$powershell_scripts_dir\symbolic_junction.ps1"

function launchwsl {
  wsl.exe -d Arch --cd ~
}

function GitPushAlias {
  git push $args
}

function GitLastFive {
  git reflog -5 $args
}

$null = Invoke-Expression (
  [System.Text.StringBuilder]::new().
  Append("New-Alias -Name npp -Value notepad++.exe -Force").
  Append("`n").
  Append("New-Alias -Name c -Value cat -Force").
  Append("`n").
  Append("New-Alias -Name b -Value bat -Force").
  Append("`n").
  Append("New-Alias -Name gu -Value gitui -Force").
  Append("`n").
  Append("New-Alias -Name rst -Value NavigateToRust -Force").
  Append("`n").
  Append("New-Alias -Name grep -Value Select-String -Force").
  Append("`n").
  Append("New-Alias -Name manwin -Value ManPageWindow -Force").
  Append("`n").
  Append("New-Alias -Name man -Value ManPage -Force").
  Append("`n").
  Append("New-Alias -Name rm -Value Remove-Wrapper -Force").
  Append("`n").
  Append("New-Alias -Name z. -Value ZoxideAdd -Force").
  Append("`n").
  Append("New-Alias -Name z.. -Value ZoxideEdit -Force").
  Append("`n").
  Append("New-Alias -Name zq -Value ZoxideQuery -Force").
  Append("`n").
  Append("New-Alias -Name cargos -Value CargoBuildEverything -Force").
  Append("`n").
  Append("New-Alias -Name cargosr -Value CargoRunEverything -Force").
  Append("`n").
  Append("New-Alias -Name ff -Value fastfetchin -Force").
  Append("`n").
  Append("New-Alias -Name cdd -Value WhichCD -Force").
  Append("`n").
  Append("New-Alias -Name which -Value FWhich -Force").
  Append("`n").
  Append("New-Alias -Name tmp -Value TempDir -Force").
  Append("`n").
  Append("New-Alias -Name aw -Value launchwsl -Force").
  Append("`n").
  Append("New-Alias -Name ma -Value makers $args -Force").
  Append("`n").
  Append("New-Alias -Name gp -Value GitPushAlias -Force").
  Append("`n").
  Append("New-Alias -Name grl -Value GitLastFive -Force").
  Append("`n").
  Append("New-Alias -Name aa -Value jj $args -Force").
  Append("`n").
  Append("New-Alias -Name ja -Value jj $args -Force").
  Append("`n").
  Append("New-Alias -Name dustex -Value DustExclude $args -Force").
  Append("`n").
  Append("New-Alias -Name isym -Value IsSymbolicLink -Force").
  Append("`n").
  Append("New-Alias -Name t -Value tv $args -Force").
  Append("`n").
  Append("New-Alias -Name lzd -Value lazydocker $args -Force").
  Append("`n").
  Append("New-Alias -Name lg -Value lazygit $args -Force").
  Append("`n").
  Append("New-Alias -Name lzgt -Value lazygit $args -Force").
  Append("`n").
  Append("New-Alias -name unlink -Value Remove-SymbolicJunction -Force").
  Append("`n").
  Append("New-Alias -Name ln -Value CreateNewSymbolic -Force").
  ToString()
) > $null;

# Required due to alias clash with Git-Aliases
function GoLangUpdateTool {
  param(
    $arguments = $args
  )
  $g = "$HOME\go\bin\gup"
  Invoke-Expression("$g $arguments")
}
# Required due to alias clash with Git-Aliases
New-Alias -Name glup -Value GoLangUpdateTool -Force
