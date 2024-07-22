$env:HOME_PROFILE = $true
# BEGIN - Navigation functions

$home_GitHub = "E:\GitHub"
$home_gitwork_projects = "$home_GitHub\GitWork_Projects"


$data_on_demand = "$home_gitwork_projects\Data-On-Demand"

$data_on_demand_backend = "$data_on_demand\Data-On-Demand-Backend"
$data_on_demand_next = "$data_on_demand\data-on-demand-next"
$data_on_demand_frontend = "$home_gitwork_projects\Data-On-Demand-Frontend"

$c_temp_folder = "C:\temp"


function mgr {
    param(
        [string]$path = $home_GitHub

    )
    Push-Location $path
    Get-ChildItem
}

function wgr {
    param(
        [string]$path = $home_gitwork_projects
    )
    Push-Location $path
    Get-ChildItem
}

function dod {
    param(
        [string]$path = $data_on_demand
    )
    Push-Location $path
    Get-ChildItem
}

function dodb {
    param(
        [string]$path = $data_on_demand_backend
    )
    Push-Location $path
    Get-ChildItem
}

function dodn {
    param(
        [string]$path = $data_on_demand_next
    )
    Push-Location $path
    Get-ChildItem
}

function dodf {
    param(
        [string]$path = $data_on_demand_frontend
    )
    Push-Location $path
    Get-ChildItem
}




function ctemp {
    $c_temp_folder = "c:\temp"
    push-location $c_temp_folder
    get-childitem
}

new-alias -name ctmp -value ctemp  -force
