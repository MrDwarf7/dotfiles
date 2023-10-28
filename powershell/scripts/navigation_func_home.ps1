$env:HOME_PROFILE = $true
# BEGIN - Navigation functions

if ($env:HOMEPROFILE -eq $false)
{
    return
} else
{
    $home_GitHub = "E:\GitHub"


    $gitwork_projects = "$home_GitHub\GitWork_Projects"

    $data_on_demand = "$home_GitHub\Data-On-Demand"
    $data_on_demand_backend = "$data_on_demand\Data-On-Demand-Backend"
    $data_on_demand_frontend = "$data_on_demand\Data-On-Demand-Frontend"

    function mgr
    {
        param(
            [string]$path = "$home_GitHub"
        )
        Push-Location $path
        Get-ChildItem
    }

    function wgr
    {
        param(
            [string]$path = "$gitwork_projects"
        )
        Push-Location $path
        Get-ChildItem
    }

    function dod
    {
        param(
            [string]$path = "$data_on_demand"
        )
        Push-Location $path
        Get-ChildItem
    }

    function dodb
    {
        param(
            [string]$path = "$data_on_demand_backend"
        )
        Push-Location $path
        Get-ChildItem
    }

    function dodf
    {
        param(
            [string]$path = "$data_on_demand_frontend"
        )
        Push-Location $path
        Get-ChildItem
    }
}



