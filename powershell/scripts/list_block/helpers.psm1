
# Helper function to process command-line arguments as a hashtable
function ProcessArguments {
  param (
    [Parameter(Mandatory = $true)]
    [HashTable]$ArgumentMap
  )
    
  foreach ($argKey in $ArgumentMap.Keys) {
    $arg = $ArgumentMap[$argKey]
    # Write-Host("argkey: $argKey")
    # Write-Host("after argumentmap extr: $($arg.Action)")
        
    if ($arg.Condition) {
      # Write-Host("condition call, used action: $($arg.Action)")
      & $arg.Action
    } elseif ($arg.ContainsKey('DefaultAction')) {
      & $arg.DefaultAction
    }
  }
}

# Helper function to format sizes
function Format-Size {
  param (
    [Parameter(Mandatory = $true)]
    [long]$Size
  )

  if ($Size -lt 1KB) {
    return "$Size B"
  } elseif ($Size -lt 1MB) {
    return "$([math]::Round($Size / 1KB, 2)) K"
  } elseif ($Size -lt 1GB) {
    return "$([math]::Round($Size / 1MB, 2)) M"
  } elseif ($Size -lt 1TB) {
    return "$([math]::Round($Size / 1GB, 2)) G"
  } else {
    return "$([math]::Round($Size / 1TB, 2)) T"
  }
}

# Add help information
function Get-LsblkHelp {
  Write-Host "ListBlockDevices - PowerShell implementation of Linux's lsblk command"
  Write-Host ""
  Write-Host "Usage: ListBlockDevices [-All] [-List] [-FileSystem] [-IncludeHealth] [-Size]"
  Write-Host ""
  Write-Host "Options:"
  Write-Host "  -All            Display all device information including vendor, model" #, and serial"
  Write-Host "  -List           Use list format instead of tree"
  Write-Host "  -FileSystem     Include filesystem information (similar to lsblk -f)"
  Write-Host "  -IncludeHealth  Show health status and operational status"
  Write-Host "  -Size           Show device sizes"
}

Export-ModuleMember -Function Get-LsblkHelp
Export-ModuleMember -Function Format-Size
Export-ModuleMember -Function ProcessArguments
