# BEGIN - Shell functions / Helpful functions
function cl
{
    Add-Type -Assembly PresentationCore
    $clipText = (get-location).ToString() | Out-String -Stream
    [Windows.Clipboard]::SetText($clipText)
}

function cx {
    param(
            [string]$command
         )
# Splitting
        $parts = $command -split '/', 2
        $functionName = $parts[0]
        $functionArgs = if ($parts.Count -gt 1) { $parts[1] } else { "" }
        $environment = if (checkEnvironment) { "work" } else { "home" }
        $holdError = ""

        # Top level switch finds the function name
        switch ($functionName) {
            # Requires full path after function part 
            # ie: dot/powershell
            # dot/powershell/Scripts
            #
            "dot" {
                $path = if ($functionArgs) { Join-Path $dotfiles_dir $functionArgs.Replace('/', '\') } else { $dotfiles_dir }
                Write-Host "From cx function call path variable is: ", $path
                Write-Host "From cx function call functionArgs variable is: ", $functionArgsost 
                Push-Location $path
            }
            # matches function then matches argument to a pre defined function
            # ie: dod/b -> $data_on_demand_backend function
            # dod/f -> $data_on_demand_frontend function
            #
            "dod" {
                switch ($functionArgs) {
                    "b" {Push-Location $data_on_demand_backend}
                    # "f" {Push-Location $data_on_demand_frontend}
                    "f" {Push-Location $data_on_demand_next}
                    default {Push-Location $data_on_demand}
                }
                Write-Host "Path variable is: ", $path
                    Push-Location $path
            }
            # matches function then matches argument to a pre defined extension, as a variable
            # ie: mgr/d -> $gitwork_projects or $home_GitHub/$docker_projects ( where $docker_projects = "Docker" as defined in a variable)
            # mgr/p -> $gitwork_projects or $home_GitHub/$python_projects ( where $python_projects = "Python" as defined in a variable)
            #
            "mgr" {
                $pathable = if ($environment -eq "work") { $gitwork_projects } else { $home_GitHub }

                $path = switch ($functionArgs) {
                    "data" { Join-Path $pathable $data_projects }
                    "d" {Join-Path $pathable $docker_projects}
                    "g" {Join-Path $pathable $go_projects}
                    "powershell" {Join-Path $pathable $powershell_projects}
                    "p" {Join-Path $pathable $python_projects}
                    "r" {Join-Path $pathable $rust_projects}
                    "web" {Join-Path $pathable $web_projects}
                    "t" {Join-Path $pathable $testing_projects}
                    default {Join-Path $pathable $functionArgs.Replace('/', '\')}
                }
                Write-Host "Pathable is: ", $pathable
                    Write-Host "Path variable is: ", $path
                    Push-Location $path
            }
            default {
                $holdError = "Function $functionName not recognized, or isn't a part of the switch handler { cx = Custom CD commands }"
            }
        }
    Get-ChildItem
        if ($holdError) {
            Write-Host
                Write-Host $holdError
        }
}


function lzgt
{
    lazygit $args
}

function lzdk
{
    lazydocker $args
}

function gitgo
{
    param(
        [string]$baseCommitMessage = "Bump"
    )
    if ($args)
    {
        $argumentsIn = $args
    }
    if (-not $args)
    {
        $argumentsIn = $baseCommitMessage
    }
    gst && gaa && gcam "$($argumentsIn)." && git push
    return
}

function scoopup
{
    scoop update && scoop update --all && scoop cleanup * && scoop cache rm *
}


function scpdir
{
    Push-Location "$env:USERPROFILE\scoop\"
    Get-ChildItem
}


function dot {
    param(
        $path
    )
    Write-Host "From dot function call path variable is: ", $path
    Write-Host "From dot function call literal args is: ", $args

    $path = if ($path) { Join-Path $dotfiles_dir $path.Replace('/', '\') } else { $dotfiles_dir }
    Push-Location "C:\" 
    Push-Location $path
    Get-ChildItem
    Write-Host "Fetching: "
    git fetch
    Write-Host "Status: "
    git status
    return
} 

# END - Shell functions / Helpful functions

function pro
{
    # Define the possible values for no-clear
    $possibleNoClear = "noclear", "no-clear", "no clear", "noclr", "no-clr", "no clr", "-", "c", "n", "nc", "cl", "ncl", "noc", "nocl", "noclr"

    # Check if noClear argument is one of the specified values
    if ($args.Count -gt 0 -and $possibleNoClear -contains $args[0].ToLower())
    {
        # Reload the profile without clearing the console
        . $PROFILE
    } else
    {
        # Reload the profile and clear the console
        . $PROFILE
        Clear-Host
    }
}


function .
{
    Start-Process .
}

function la
{
    param ($path = ".")
    Get-ChildItem $path -Force
}

function l
{
    param ($path = ".")
    Get-ChildItem $path -Force
}

function cd2
{
    Set-Location ../../
}

function touch
{
    New-Item $args
}

function zip
{
    param (
        [string]$ItemToCompress,
        [string]$OptionalDestination
    )
    $ItemName = (Get-Item $ItemToCompress).Name
    $ParentFolder = (Split-Path -Path $ItemToCompress -Parent)

    if ([String]::IsNullOrEmpty($OptionalDestination))
    {
        $DefaultLocation = Join-Path -Path $ParentFolder -ChildPath $ItemName

        Compress-Archive -Path $ItemToCompress -DestinationPath "$DefaultLocation.zip"
    } else
    {
        Compress-Archive -Path $ItemToCompress -DestinationPath "$OptionalDestination\$ItemName.zip"
    }
}

function uzip
{
    param (
        [string]$ItemToUnzip,
        [string]$OptionalDestination
    )
    $ItemName = (Get-Item $ItemToUnzip).Name
    $ParentFolder = (Split-Path -Path $ItemToUnzip -Parent)

    if ([String]::IsNullOrEmpty($OptionalDestination))
    {
        $DefaultLocation = Join-Path -Path $ParentFolder -ChildPath $ItemName

        Expand-Archive -Path $ItemToUnzip -DestinationPath "$DefaultLocation\$ItemName"
    } else
    {
        Expand-Archive -Path $ItemToUnzip -DestinationPath "$OptionalDestination\"
    }
}
# END - Linux Functions

function z
{
    zoxide $args
}

function c {
    param(
        [string]$command
    )
    # Splitting
    $parts = $command -split '/', $command.Length
    $functionName = $parts[0]
    $functionArgs = if ($parts.Count -gt 1) { $parts[1] } else { "" }
    $holdError = ""

    switch ($functionName) {
        "b" {
            cargo build $functionArgsbui
        }
        "r" {
            cargo run $functionArgs
        }
        "rq" {
            cargo run -q $functionArgs
        }
        "br" {
            cargo build --release $functionArgsbui
        }
        "rr" {
            cargo run --release $functionArgs
        }
        "t" {
            cargo test $functionArgs
        }
        "cc" {
            cargo check $functionArgs
        }
        "cl" {
            cargo clean $functionArgs
        }
        "u" {
            cargo update $functionArgs
        }
        "doc" {
            cargo doc $functionArgs
        }
        "up" {
            cargo upgrade $functionArgs
        }
        default {
            $holdError = "Function $functionName not recognized, or isn't a part of the switch handler { c = Cargo }"
        }
    }
    if ($holdError) {
        Write-Host
        Write-Host $holdError
    }
}




# Not currently working while function c is in place

 # function CargoBuild
 # {
 #     cargo build $args
 # }
 #
 # function CargoRun
 # {
 #     cargo run $args
 # }
 #
 # function CargoRunQuiet
 # {
 #     cargo run -q $args
 # }
 #
 # function CargoRunRelease
 # {
 #     cargo run --release $args
 # }
 #
 # function CargoBuildRelease
 # {
 #     cargo build --release $args
 # }
 #
 # function CargoTest
 # {
 #     cargo test $args
 # }
 #
 # function CargoCheck
 # {
 #     cargo check $args
 # }
 #
 # function CargoClean
 # {
 #     cargo clean $args
 # }
 #
 # function CargoDoc
 # {
 #     cargo doc $args
 # }
 #
 # function CargoUpdate
 # {
 #     cargo update $args
 # }
 #
 # function CargoUpgrade
 # {
 #     cargo upgrade $args
 # }
