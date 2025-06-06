# $data_projects = "Data-Sets"
# $downloaded = "Downloads"
# $docker_projects = "Docker"
# $go_projects = "Go"
# $powershell_projects = "PowerShell"
# $python_projects = "Python"
# $rust_projects = "Rust"
# $web_projects = "Web"
# $testing_projects = "Testing"

# BEGIN - Shell functions / Helpful functions
function cl {
  # $cleanText = ""
  Add-Type -Assembly PresentationCore;
  $clipText = (get-location).ToString() | Out-String -Stream;

  if ($clipText.StartsWith("Microsoft.PowerShell.Core\FileSystem::")) {
    $clipText = $clipText.Replace("Microsoft.PowerShell.Core\FileSystem::", "");
  }
  [Windows.Clipboard]::SetText($clipText);
}

function nf {
  if (-not (fastfetch --help)) {
    try {
      scoop install neofetch;
    } catch {
      scoop bucket add extras;
    } finally {
      scoop install neofetch;
    };
  };
  fastfetch ;
}

# enum CursorStyle {
#   block_blink = 1
#   block = 2
#   underline_blink = 3
#   underline = 4
#   bar_blink = 5
#   bar = 6
# }

<#
  .SYNOPSIS
  set cursor style
#>
# function Set-CursorStyle {
#   param (
#     # style
#     [Parameter(Mandatory)]
#     [CursorStyle]$Style
#   )
#
#   Write-Output "`e[$([int]$Style) q"
# }

function y {
  $tmp = [System.IO.Path]::GetTempFileName();
  yazi $args --cwd-file="$tmp";
  $cwd = Get-Content -Path $tmp;
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
    Set-Location -LiteralPath $cwd;
  };
  Remove-Item -Path $tmp;
  # Set-CursorStyle -Style bar
}

function DustExclude {
  param(
    [string]$path = "."
  );
  $exclude = "-X C:\Windows -X 'C:\Program Files\' -X C:\ProgramData -X 'C:\Program Files (x86)\' -X 'C:\Applications\GitWork_Projects\Arch_WSL\*'";

  if ($null -eq $path) {
    $path = $path;
  } elseif ($path -eq 'C' -or 'c' -or "C:\" -or "c:\") {
    $path = "C:\";
  } else {
    $path = $path # not empty && not c drive;
  };

  if (-not (Test-CommandExists "dust.exe")) {
    Write-Host("Dust command found.");
    $answer = Read-Host("Would you like to install it? (Y/n)");
    # powershell_es ignore start
    switch ($answer.Trim().ToLower()) {
      "y" {
        scoop install dust;
      };
      "n" {
        Write-Host("Dust not installed.");
      };
      default {
        scoop install dust ;
      };
    };
    DustExclude $args; # Recurse call after installing dust, using same args
  };
  Write-Host("Running Dust with exclude flags.");

  dust.exe $exclude $path $args;
};

function gitgo {
  param(
    [string]$baseCommitMessage = "Bump"
  );
  if ($args) {
    $argumentsIn = $args;
  };
  if (-not $args) {
    $argumentsIn = $baseCommitMessage;
  }
  gst && gaa && gcam "$($argumentsIn)." && git push;
  return;
}

function gfp {
  Write-Host "Fetching all remotes and pulling all branches." -ForegroundColor DarkBlue
  git fetch --all $args;
  Write-Host "Pulling all branches." -ForegroundColor DarkYellow
  git pull --all $args;
  return;
}

function ScoopUpgrade {
  scoop update && scoop update --all && scoop cleanup * && scoop cache rm *;
}
New-Alias -Name scoopup -Value ScoopUpgrade -Force;

function NodeUpgrade {
  $env:NODE_TLS_REJECT_UNAUTHORIZED = "0";
  # && yarn global upgrade  ## Yarn is no longer really a package manger, it's more a project manager now
  pnpm -g update && pnpm -g upgrade && npm -g update && npm -g upgrade;
  # unset $env:NODE_TLS_REJECT_UNAUTHORIZED
}
New-Alias -Name nodeup -Value NodeUpgrade -Force;

function RustUpgrader {
  rustup update;
}
New-Alias -Name rupper -Value RustUpgrader -Force;

function CargoBinUpdater() {
  if (-not (Test-CommandExists("cargo install-update"))) {
    # Install the updater tool
    cargo install cargo-update;
  };
  cargo install-update -a;
}
New-Alias -Name cbu -Value CargoBinUpdater -Force;

function SystemUpgrade {
  if (-not ($env:NODE_TLS_REJECT_UNAUTHORIZED)) {
    $env:NODE_TLS_REJECT_UNAUTHORIZED = "0";
  };

  ScoopUpgrade;
  NodeUpgrade;
  RustUpgrader;

  if (isWorkMachine -eq $true) {
    Write-Host "Running second RustUpgrader";
    RustUpgrader;
  };
  # We want to update rust first, then call update for the tooling bins
  CargoBinUpdater;

  Write-Host "System update complete [ScoopUpgrade, NodeUpgrade]" -NoNewline -ForegroundColor Green -BackgroundColor Black;
  Write-Host;
}
New-Alias -Name sysup -Value SystemUpgrade -Force;

function scpd {
  Push-Location "$env:USERPROFILE\scoop\";
  la;
}

function CargoBinList() {
  if (-not (Test-CommandExists("cargo install-update"))) {
    # Install the updater tool
    cargo install cargo-update;
  };
  cargo install-update -l;
}
New-Alias -Name cbl -Value CargoBinList -Force;

function baconget {
  $baconFile = "$dotfiles_dir\.config\bacon\bacon.toml";
  $currentDir = Get-Location;

  if (-not (Test-Path $baconFile )) {
    Write-Host "Bacon file not found at: $baconFile ";
    return;
  };
  Copy-Item $baconFile $currentDir;
  Write-Host "Bacon file copied to: $currentDir";
}

function dot {
  param(
    [string]$path
  );
  # Write-Host "From dot function call path variable is: ", $path
  # Write-Host "From dot function call literal args is: ", $args

  $path = if ($path) {
    Join-Path $dotfiles_dir $path.Replace('/', '\');
  } else {
    $dotfiles_dir;
  };
  Push-Location "C:\";
  Push-Location $path;
  la;
  Write-Host "Fetching: ";
  git fetch;
  Write-Host "Status: ";
  git status;
}

# END - Shell functions / Helpful functions

function IsSymbolicLink([string]$path) {
  $file = Get-Item $path -Force -ErrorAction SIlentlyContinue;
  return [bool]($file.Attributes -band [IO.FileAttributes]::ReparsePoint);
}

function refresh {
  Import-Module "C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1";
  refreshenv;
  Write-Host "Chocolatey environment refreshed." -ForegroundColor Green;
  if ($args.Count -gt 0) {
    Write-Host "Extra arguments detected: $args" -ForegroundColor Yellow;
    . SourceProfile  $args;
  };
  . SourceProfile;
}

function SourceProfile {
  # Define the possible values for no-clear
  $possibleClear = "c", "-", "cls", "clear", "-clear", "clr", "screen", "-screen", "clear-screen", "-clear-screen", "cls-", "clr", "cl", "BEGONE", "THOT", "wipe";

  # Check if noClear argument is one of the specified values
  if ($args.Count -gt 0 -and $possibleClear -contains $args[0]) {
    # Reload the profile without clearing the console
    . $PROFILE;
    Clear-Host;
  } else {
    # Reload the profile and clear the console
    . $PROFILE;
  };
}
New-Alias -Name p -Value SourceProfile -Force;
New-Alias -Name pro -Value SourceProfile -Force;

function . {
  Start-Process .;
  return;
}

function cd2 {
  Set-Location ../../;
  return;
}

function touch {
  New-Item $args;
  return;
}

function zip {
  param (
    [string]$ItemToCompress,
    [string]$OptionalDestination
  );
  $ItemName = (Get-Item $ItemToCompress).Name;
  $ParentFolder = (Split-Path -Path $ItemToCompress -Parent);

  if ([String]::IsNullOrEmpty($OptionalDestination)) {
    $DefaultLocation = Join-Path -Path $ParentFolder -ChildPath $ItemName;
    Compress-Archive -Path $ItemToCompress -DestinationPath "$DefaultLocation.zip";
  } else {
    Compress-Archive -Path $ItemToCompress -DestinationPath "$OptionalDestination\$ItemName.zip";
  };
  return;
}

function uzip {
  param (
    [string]$ItemToUnzip,
    [string]$OptionalDestination
  );
  $ItemName = (Get-Item $ItemToUnzip).Name;
  $ParentFolder = (Split-Path -Path $ItemToUnzip -Parent);

  if ([String]::IsNullOrEmpty($OptionalDestination)) {
    $DefaultLocation = Join-Path -Path $ParentFolder -ChildPath $ItemName;
    Expand-Archive -Path $ItemToUnzip -DestinationPath "$DefaultLocation\$ItemName";
  } else {
    Expand-Archive -Path $ItemToUnzip -DestinationPath "$OptionalDestination\";
  };
  return;
}
# END - Linux Functions


### Version 1
function ListBlockDevices2 {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $false)][Alias("l")]
    [switch]$List
  );

  # Helper function to format sizes in a human-readable format
  function Format-Size {
    param ($size);
    if ([string]::IsNullOrEmpty($size)) {
      $size = 0
    };
    if ($size -ge 1TB) {
      "{0:N2} TB" -f ($size / 1TB);
    } elseif ($size -ge 1GB) {
      "{0:N2} GB" -f ($size / 1GB);
    } elseif ($size -ge 1MB) {
      "{0:N2} MB" -f ($size / 1MB);
    } else {
      "$size bytes";
    };
  };

  # Retrieve all disks and volumes
  $disks = Get-Disk;
  $volumes = Get-Volume | Select-Object *, @{Name="PartitionGuid"; Expression={ 
      if ($_.UniqueId -match '\\\\\?\\Volume\{([^\}]+)\}\\') {
        $matches[1] ;
      } else {
        $null ;
      } ;
    };
  }

  if ($List) {
    # List view: flat table format
    $items = @()
    foreach ($disk in $disks) {
      $items += [PSCustomObject]@{
        Name       = "disk$($disk.Number)"
        # FriendlyName = $disk.FriendlyName
        Type       = "disk"
        Size       = Format-Size $disk.TotalSize
        FSType     = "N/A"
        MountPoint = "N/A"
      }
      $partitions = Get-Partition -DiskNumber $disk.Number -ErrorAction SilentlyContinue;
      foreach ($partition in $partitions) {
        $volume = $volumes | Where-Object { $_.PartitionGuid -eq $partition.Guid };
        $fsType = if ($volume) {
          $volume.FileSystemType;
        } else {
          "N/A" ;
        };
        $mountPoint = if ($volume.DriveLetter) {
          "$($volume.DriveLetter):";
        } else {
          "N/A";
        };
        $items += [PSCustomObject]@{
          Name       = "disk$($disk.Number)p$($partition.PartitionNumber)"
          Type       = "part"
          Size       = Format-Size $partition.Size
          FSType     = $fsType
          MountPoint = $mountPoint
        }
      };
    };
    $items | Format-Table -AutoSize;
  } else {
    # Tree view: hierarchical format
    foreach ($disk in $disks) {
      Write-Host("");
      Write-Host "DISK $($disk.Number): $($disk.FriendlyName), $(Format-Size $disk.TotalSize)"
      $partitions = Get-Partition -DiskNumber $disk.Number -ErrorAction SilentlyContinue
      foreach ($partition in $partitions) {
        $volume = $volumes | Where-Object { $_.PartitionGuid -eq $partition.Guid }
        $driveLetter = if ($volume.DriveLetter) {
          "$($volume.DriveLetter):";
        } else {
          "N/A";
        };
        $fsType = if ($volume) {
          $volume.FileSystemType;
        } else {
          "N/A";
        };
        Write-Host "  PART $($partition.PartitionNumber): $(Format-Size $partition.Size), $($partition.Type), $driveLetter, $fsType";
      };
    };
  };
}
New-Alias -Name lsblk2 -Value ListBlockDevices2 -Force;

function ListBlockDevices {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $false)][Alias("a")]
    [switch]$All,
    [Parameter(Mandatory = $false)][Alias("l")]
    [switch]$List,
    [Parameter(Mandatory = $false)][Alias("fs")]
    [switch]$FileSystem,
    [Parameter(Mandatory = $false)][Alias("i")]
    [switch]$IncludeHealth,
    [Parameter(Mandatory = $false)][Alias("s")]
    [switch]$Size,
    [Parameter(Mandatory = $false)][Alias("h")]
    [switch]$Help
  );
  # Lazy import them after we've actually called the fn
  Import-Module "$powershell_scripts_dir\list_block\with_formatters.psm1";
  Import-Module "$powershell_scripts_dir\list_block\build_object.psm1";
  Import-Module "$powershell_scripts_dir\list_block\helpers.psm1";

  if ($Help) {
    Get-LsblkHelp;
    return;
  };

  $ShouldSplitIfNonListArgs = @($All, $FileSystem, $IncludeHealth, $Size);
  $ShouldSplitIfNonListArgsRef = [ref]$ShouldSplitIfNonListArgs;

  # Get all disks    # Get all partitions         # Get all volumes      # Get disk details from WMI
  $disks = Get-Disk; $partitions = Get-Partition; $volumes = Get-Volume; $wmiDisks = Get-WmiObject -Class Win32_DiskDrive;

  # Create a hashtable to store the results
  $results = @();
  $resultsBuffer = [ref]$results;

  # Build disk objects
  BuildDiskObject -ResultsBuffer $resultsBuffer `
    -Disks $disks `
    -Partitions $partitions `
    -Volumes $volumes `
    -WmiDisks $wmiDisks

  # ensure we have a valid results buffer
  if (-not $resultsBuffer.Value) {
    Write-Host "No disks found.";
    return;
  };
  # Retrieve the results from the buffer & assign to the results variable
  $results = $resultsBuffer.Value;

  $ResultsBufferRef = [ref]$results;
  $SizeRef = [ref]$Size;
  $AllRef = [ref]$All;
  $FileSystemRef = [ref]$FileSystem;
  $IncludeHealthRef = [ref]$IncludeHealth;


  # Format and display the results
  if ($List) {
    # List format (similar to lsblk -l)
    $flatList = @();
    $FlatListRef = [ref]$flatList;

    WithList -ResultsBufferRef $ResultsBufferRef `
      -FlatListRef $FlatListRef `
      -SizeRef $SizeRef `
      -AllRef $AllRef `
      -FileSystemRef $FileSystemRef `
      -IncludeHealthRef $IncludeHealthRef

    $flatList | Format-Table -AutoSize;
  } else {
    # Default to a 'tree' style output

    # $outputBuf = [string]::Empty
    # $OutputBufRef = [ref]$outputBuf
    WithTree -ResultsBufferRef $ResultsBufferRef `
      -SizeRef $SizeRef `
      -AllRef $AllRef `
      -FileSystemRef $FileSystemRef `
      -IncludeHealthRef $IncludeHealthRef `
      -ShouldSplitIfNonListArgs $ShouldSplitIfNonListArgsRef
    # Write-Host $outputBuf
  };
}
New-Alias -Name lsblk -Value ListBlockDevices -Force

  }
}
New-Alias -Name lsblk -Value ListBlockDevices -Force

