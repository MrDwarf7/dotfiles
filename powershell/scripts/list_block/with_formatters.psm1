function WithList {
  param(
    [Parameter(Mandatory = $true)]
    [ref]$ResultsBufferRef,

    [Parameter(Mandatory = $true)]
    [ref]$FlatListRef,

    [Parameter(Mandatory = $true)]
    [ref]$SizeRef,

    [Parameter(Mandatory = $true)]
    [ref]$AllRef,

    [Parameter(Mandatory = $true)]
    [ref]$FileSystemRef,

    [Parameter(Mandatory = $true)]
    [ref]$IncludeHealthRef
  )

  ### START DISK loop
  foreach ($disk in $ResultsBufferRef.Value) {
    $diskProps = @{
      NAME = $disk.Name
      TYPE = $disk.Type
    }

    # Define argument handlers for disk in list format
    $argumentMap = @{
      Size = @{
        Condition = $true # Always on basically
        # Condition = $Size
        Action = { $diskProps["SIZE"] = Format-Size $disk.Size }
      }
      All = @{
        Condition = $AllRef.Value
        Action = {
          $diskProps["MODEL"] = $disk.Model
          $diskProps["VENDOR"] = $disk.Vendor
          # $diskProps["SERIAL"] = $disk.Serial
        }
      }
      FileSystem = @{
        Condition = $FileSystemRef.Value
        Action = {
          $diskProps["FSTYPE"] = ""
          $diskProps["MOUNTPOINT"] = ""
        }
      }
      IncludeHealth = @{
        Condition = $IncludeHealthRef.Value
        Action = {
          $diskProps["HEALTH"] = $disk.Health
          $diskProps["STATUS"] = $disk.Status
        }
      }
    }

    # Process arguments for disk
    ProcessArguments -ArgumentMap $argumentMap

    $FlatListRef.Value += [PSCustomObject]$diskProps

    ### START PARTITION loop
    foreach ($partition in $disk.Children) {
      $partProps = @{
        NAME = $partition.Name
        TYPE = $partition.Type
      }

      # Define argument handlers for partition in list format
      $argumentMap = @{
        Size = @{
          Condition = $true
          Action = { $partProps["SIZE"] = Format-Size $partition.Size }
        }
        All = @{
          Condition = $AllRef.Value
          Action = {
            $partProps["MODEL"] = ""
            $partProps["VENDOR"] = ""
            # $partProps["SERIAL"] = ""
          }
        }
        FileSystem = @{
          Condition = $FileSystemRef.Value
          Action = {
            $partProps["FSTYPE"] = $partition.FileSystem
            $partProps["MOUNTPOINT"] = $partition.MountPoint
          }
        }
        IncludeHealth = @{
          Condition = $IncludeHealthRef.Value
          Action = {
            $partProps["HEALTH"] = $partition.Health
            $partProps["STATUS"] = $partition.Status
          }
        }
      }

      # Process arguments for partition
      ProcessArguments -ArgumentMap $argumentMap

      $FlatListRef.Value += [PSCustomObject]$partProps
    }
    ### END PARTITION loop
  }
  ### END DISK loop
}

function WithTree {
  param(
    [Parameter(Mandatory = $true)]
    [ref]$ResultsBufferRef,
    # [Parameter(Mandatory = $true)]
    # [ref]$OutputBufRef,
    [Parameter(Mandatory = $true)]
    [ref]$SizeRef,
    [Parameter(Mandatory = $true)]
    [ref]$AllRef,
    [Parameter(Mandatory = $true)]
    [ref]$FileSystemRef,
    [Parameter(Mandatory = $true)]
    [ref]$IncludeHealthRef,
    [Parameter(Mandatory = $true)]
    [ref]$ShouldSplitIfNonListArgs
  )

  foreach ($disk in $ResultsBufferRef.Value) {
    $diskLine = "$($disk.Name) "
    $diskSizeF = Format-Size $disk.Size

    $split = $null;
    foreach ($arg in $ShouldSplitIfNonListArgs.Value) {
      if ($arg) {
        $split = $true
        break
      }
    }
    if ($split) {
      # On 'default' with no args, we want a condensed view, only if we pass something should we split line sets
      Write-Host("")
    }

    # If user passed both, we only need to show once via All in arg map
    # if ($Size -and $All) {
    #     $Size = $false
    # }
    #
    # if ($IncludeHealth -and $All) {
    #     $IncludeHealth = $false
    # }

    # Define argument handlers for disk in tree format
    $argumentMap = @{
      Size = @{
        Condition = $SizeRef.Value
        # Action = { ($diskLine += "[$(Format-Size $disk.Size)] ") }
        Action = {
          ( $diskLine += "[$($diskSizeF)] " ) 
        }
      }
      All = @{
        Condition = $AllRef.Value
        Action = { 
          ( $diskLine += "[$($($diskSizeF))] MODEL='$($disk.Model)' VENDOR='$($disk.Vendor)' HEALTH='$($disk.Health)' STATUS='$($disk.Status)' " ) 
        }
      }
      IncludeHealth = @{
        Condition = $IncludeHealthRef.Value
        Action = {
          ( $diskLine += "HEALTH='$($disk.Health)' STATUS='$($disk.Status)' " ) 
        }
      }
    }

    # Process arguments for disk
    ProcessArguments -ArgumentMap $argumentMap

    Write-Host $diskLine

    foreach ($partition in $disk.Children) {
      $indent = "└─"
      $tabbed = "  " # basically just 2 spaces lol?
      $partLine = "$tabbed$indent$($partition.Name) "

      $partSize = Format-Size $partition.Size

      # Define argument handlers for partition in tree format
      $argumentMap = @{
        Size = @{
          Condition = $SizeRef.Value
          Action = { ($partLine += "[$($partSize)] ") }
        }
        FileSystem = @{
          Condition = $FileSystemRef.Value
          Action = {
            $partLine += "FSTYPE='$($partition.FileSystem)' "
            if ($partition.MountPoint) {
              $partLine += "MOUNTPOINT='$($partition.MountPoint)' "
            }
          }
        }
        IncludeHealth = @{
          Condition = $IncludeHealthRef.Value
          Action = { $partLine += "HEALTH='$($partition.Health)' STATUS='$($partition.Status)' " }
        }
      }

      # Process arguments for partition
      ProcessArguments -ArgumentMap $argumentMap

      Write-Host $partLine

      # Write-Host $partLine | Out-String -OutBuffer $OutputBufRef.Value
      # Write-Host $partLine | Out-String -Stream | $OutputBufRef.Value += $_
      # $OutputBufRef.Value += $partLine
    }
  }
}

Export-ModuleMember -Function WithTree
Export-ModuleMember -Function WithList
