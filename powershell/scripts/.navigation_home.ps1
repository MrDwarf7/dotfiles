$env:HOME_PROFILE = $true
# BEGIN - Navigation functions

$home_GitHub = "E:\GitHub"
$home_gitwork_projects = "$home_GitHub\GitWork_Projects"

$data_on_demand = "$home_gitwork_projects\Data-On-Demand"

$data_on_demand_backend = "$data_on_demand\Data-On-Demand-Backend"
$data_on_demand_next = "$data_on_demand\data-on-demand-next"
$data_on_demand_frontend = "$home_gitwork_projects\Data-On-Demand-Frontend"

$c_temp_folder = "C:\temp"

# New-Alias -Name __ -Value _________________ -Force
# New-Alias -Name __ -Value _________________ -Force
# New-Alias -Name __ -Value _________________ -Force
# New-Alias -Name __ -Value _________________ -Force
# New-Alias -Name __ -Value _________________ -Force
# New-Alias -Name __ -Value _________________ -Force
# New-Alias -Name __ -Value _________________ -Force

# function GenericMoveTo {
#     param(
#         [string]$path = $args,
#         $pipe = $_
#
#     )
#     Write-Host("Args: $args, pipeline: $pipe")
#     Push-Location $path
#     la
# }


function mgr {
    param(
        [string]$path = $home_GitHub

    )
    Push-Location $path
    la
}

function wgr {
    param(
        [string]$path = $home_gitwork_projects
    )
    Push-Location $path
    la
}

function dod {
    param(
        [string]$path = $data_on_demand
    )
    Push-Location $path
    la
}

function dodb {
    param(
        [string]$path = $data_on_demand_backend
    )
    Push-Location $path
    la
}

function dodn {
    param(
        [string]$path = $data_on_demand_next
    )
    Push-Location $path
    la
}

function dodf {
    param(
        [string]$path = $data_on_demand_frontend
    )
    Push-Location $path
    la
}
