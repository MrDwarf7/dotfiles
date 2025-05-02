# Helper ListBlockDevices
function BuildDiskObject {
    param(
        [Parameter(Mandatory = $true)]
        $ResultsBuffer,
        [Parameter(Mandatory = $true)]
        $Disks,
        [Parameter(Mandatory = $true)]
        $Partitions,
        [Parameter(Mandatory = $true)]
        $Volumes,
        [Parameter(Mandatory = $true)]
        $WmiDisks
    )

    foreach ($disk in $disks | Sort-Object Number) {
        $diskNumber = $disk.Number
        $wmiDisk = $wmiDisks | Where-Object { $_.DeviceID -eq "\\.\PHYSICALDRIVE$diskNumber" }
        
        # Create disk object
        $diskObj = [PSCustomObject]@{
            Name = "disk$diskNumber"
            Type = "disk"
            Vendor = $wmiDisk.Model -replace "^([A-Za-z]+).*", '$1'
            Model = $wmiDisk.Model
            Size = $disk."Total Size"
            SizeBytes = [math]::Round(($wmiDisks | Where-Object { $_.DeviceID -eq "\\.\PHYSICALDRIVE$diskNumber" }).Size)
            Serial = $disk."Serial Number"
            Health = $disk.HealthStatus
            Status = $disk.OperationalStatus
            Style = $disk."Partition Style"
            Children = @()
            Level = 0
        }

        # Get partitions for this disk
        $diskPartitions = $partitions | Where-Object { 
            $diskPath = $_.DiskPath
            if ($diskPath -match "disk&ven_(.+?)&prod_(.+?)#") {
                $vendor = $matches[1]
                $prod = $matches[2]
                
                # Handle special cases and normalize strings
                $vendorMatch = $false
                $prodMatch = $false
                
                # Normalize vendor names
                if ($vendor -eq "") {
                    if ($wmiDisk.Model -match "^([A-Za-z]+)") {
                        $vendorMatch = $true
                    }
                } elseif ($wmiDisk.Model -like "*$vendor*") {
                    $vendorMatch = $true
                }
                
                # Normalize product names
                $normalizedProd = $prod -replace "_", " "
                $normalizedModel = $wmiDisk.Model -replace " ", ""
                
                if ($wmiDisk.Model -like "*$normalizedProd*" -or $normalizedModel -like "*$($normalizedProd -replace ' ', '')*") {
                    $prodMatch = $true
                }
                
                return $vendorMatch -and $prodMatch
            }
            return $false
        }

        # Process each partition
        foreach ($partition in $diskPartitions) {
            $partitionNumber = $partition.PartitionNumber
            
            # Find the volume associated with this partition
            $volume = $volumes | Where-Object { $_.DriveLetter -eq $partition.DriveLetter }
            
            # Create partition object
            $partObj = [PSCustomObject]@{
                Name = if ($partition.DriveLetter) { "$($partition.DriveLetter):" } else { "part$partitionNumber" }
                Type = $partition.Type
                Size = $partition.Size
                SizeBytes = [math]::Round($partition.Size)
                FileSystem = if ($volume) { $volume.FileSystemType } else { "Unknown" }
                MountPoint = if ($partition.DriveLetter) { "$($partition.DriveLetter):\" } else { $null }
                DriveType = if ($volume) { $volume.DriveType } else { "Unknown" }
                FriendlyName = if ($volume) { $volume.FriendlyName } else { $null }
                Health = if ($volume) { $volume.HealthStatus } else { "Unknown" }
                Status = if ($volume) { $volume.OperationalStatus } else { "Unknown" }
                SizeRemaining = if ($volume) { $volume.SizeRemaining } else { 0 }
                Level = 1
                Parent = $diskObj.Name
            }
            
            # Add partition to disk's children
            $diskObj.Children += $partObj
        }
       
        # Add disk to results
        # $results += $diskObj
        $ResultsBuffer.Value += $diskObj
    }
}

Export-ModuleMember -Function BuildDiskObject
