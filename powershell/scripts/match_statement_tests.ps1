$data_projects = "Data-Sets"
$downloaded = "Downloads"
$docker_projects = "Docker"
$go_projects = "Go"
$powershell_projects = "PowerShell"
$python_projects = "Python"
$rust_projects = "Rust"
$web_projects = "Web"
$testing_projects = "Testing"


function cx {
    param(
        [string]$command
    )
    # Splitting
    $parts = $command -split '/', 2
    $functionName = $parts[0]
    $functionArgs = if ($parts.Count -gt 1) {
        $parts[1]
    } else {
        ""
    }
    $environment = if (checkEnvironment) {
        "work"
    } else {
        "home"
    }
    $holdError = ""

    # Top level switch finds the function name
    switch ($functionName) {
        # Requires full path after function part
        # ie: dot/powershell
        # dot/powershell/Scripts
        #
        "dot" {
            $path = if ($functionArgs) {
                Join-Path $dotfiles_dir $functionArgs.Replace('/', '\')
            } else {
                $dotfiles_dir
            }
            # Write-Host "From cx function call path variable is: ", $path
            # Write-Host "From cx function call functionArgs variable is: ", $functionArgsost
            Push-Location $path
        }
        "dotfiles" {
            $path = if ($functionArgs) {
                Join-Path $dotfiles_dir $functionArgs.Replace('/', '\')
            } else {
                $dotfiles_dir
            }
            # Write-Host "From cx function call path variable is: ", $path
            # Write-Host "From cx function call functionArgs variable is: ", $functionArgsost
            Push-Location $path
        }
        # matches function then matches argument to a pre defined function
        # ie: dod/b -> $data_on_demand_backend function
        # dod/f -> $data_on_demand_frontend function
        #
        "dod" {
            switch ($functionArgs) {
                "b" {
                    Push-Location $data_on_demand_backend
                }
                # "f" {Push-Location $data_on_demand_frontend}
                "f" {
                    Push-Location $data_on_demand_next
                }
                "n" {
                    Push-Location $data_on_demand_next
                }
                default {
                    Push-Location $data_on_demand
                }
            }
            Write-Host "Path variable is: ", $path
            Push-Location $path
        }
        # matches function then matches argument to a pre defined extension, as a variable
        # ie: mgr/d -> $gitwork_projects or $home_GitHub/$docker_projects ( where $docker_projects = "Docker" as defined in a variable)
        # mgr/p -> $gitwork_projects or $home_GitHub/$python_projects ( where $python_projects = "Python" as defined in a variable)
        #
        "mgr" {
            $pathable = if ($environment -eq "work") {
                $git_projects
            } else {
                $home_GitHub
            }
            Write-Host "Pathable just after the env check is: ", $pathablet
            Write-Host "Env variable as: ", $environment

            $path = switch ($functionArgs) {
                "data" {
                    Join-Path $pathable $data_projects
                }
                "dl" {
                    Join-Path $pathable $downloaded
                }
                "d" {
                    Join-Path $pathable $docker_projects
                }
                "g" {
                    Join-Path $pathable $go_projects
                }
                "powershell" {
                    Join-Path $pathable $powershell_projects
                }
                "p" {
                    Join-Path $pathable $python_projects
                }
                "r" {
                    Join-Path $pathable $rust_projects
                }
                "w" {
                    Join-Path $pathable $web_projects
                }
                "t" {
                    Join-Path $pathable $testing_projects
                }
                default {
                    Join-Path $pathable $functionArgs.Replace('/', '\')
                }
            }
            Write-Host "Pathable is: ", $pathable
            Write-Host "Path variable is: ", $path
            Push-Location $path
        }

        "wgr" {
            $pathable = if ($environment -eq "work") {
                $gitwork_projects
            } else {
                $home_gitwork_projects
            }
            Write-Host "Pathable just after the env check is: ", $pathable
            Write-Host "Env variable as: ", $environment

            $path = switch ($functionArgs) {
                "data" {
                    Join-Path $pathable $data_projects
                }
                "dl" {
                    Join-Path $pathable $downloaded
                }
                "d" {
                    Join-Path $pathable $docker_projects
                }
                "g" {
                    Join-Path $pathable $go_projects
                }
                "powershell" {
                    Join-Path $pathable $powershell_projects
                }
                "p" {
                    Join-Path $pathable $python_projects
                }
                "r" {
                    Join-Path $pathable $rust_projects
                }
                "w" {
                    Join-Path $pathable $web_projects
                }
                "t" {
                    Join-Path $pathable $testing_projects
                }
                default {
                    Join-Path $pathable $functionArgs.Replace('/', '\')
                }
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


function c {
    param(
        [string]$command
    )
    # Splitting
    $parts = $command -split '/', $command.Length
    $functionName = $parts[0]
    $functionArgs = if ($parts.Count -gt 1) {
        $parts[1]
    } else {
        ""
    }
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
