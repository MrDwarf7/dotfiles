# docker compose Set-Alias

function DockerComposeUp {
    docker compose up $args
}
function DockeComposeBuild {
    docker compose build $args
}
function DockeComposeUpBuild {
    docker compose up --build $args
}
function DockeComposeUpBuildDetached {
    docker compose up -d --build $args
}
function DockeComposeExec {
    docker compose exec $args
}
function DockeComposePs {
    docker compose ps $args
}
function DockeComposeRestart {
    docker compose restart $args
}
function DockeComposeRm {
    docker compose rm $args
}
function DockeComposeRun {
    docker compose run $args
}
function DockeComposeStop {
    docker compose stop $args
}
function DockeComposeUpd {
    docker compose up -d $args
}
function DockeComposeDown {
    docker compose down $args
}
function DockeComposeLogs {
    docker compose logs $args
}
function DockeComposeLogsf {
    docker compose logs -f $args
}
function DockeComposePull {
    docker compose pull $args
}
function DockeComposeStart {
    docker compose start $args
}

# Set-Alias dco docker compose
# New-Alias -Name dcb -Value DockeComposeBuild -Force
# New-Alias -Name dcub -Value DockeComposeUpBuild -Force
# New-Alias -Name dcubd -Value DockeComposeUpBuildDetached -Force
# New-Alias -Name dce -Value DockeComposeExec -Force
# New-Alias -Name dcps -Value DockeComposePs -Force
# New-Alias -Name dcres -Value DockeComposeRestart -Force
# New-Alias -Name dcrm -Value DockeComposeRm -Force
# New-Alias -Name dcr -Value DockeComposeRun -Force
# New-Alias -Name dcstop -Value DockeComposeStop -Force
# New-Alias -Name dcu -Value DockerComposeUp -Force
# New-Alias -Name dcud -Value DockeComposeUpd -Force
# New-Alias -Name dcd -Value DockeComposeDown -Force
# New-Alias -Name dcl -Value DockeComposeLogs -Force
# New-Alias -Name dclf -Value DockeComposeLogsf -Force
# New-Alias -Name dcpl -Value DockeComposePull -Force
# New-Alias -Name dcstart -Value DockeComposeStart -Force


# PERF: Maybe even better way to do this??

$null = Invoke-Expression (
    [System.Text.StringBuilder]::new().
        Append("New-Alias -Name dcb -Value DockeComposeBuild -Force").
        Append("`n").
        Append("New-Alias -Name dcub -Value DockeComposeUpBuild -Force").
        Append("`n").
        Append("New-Alias -Name dcubd -Value DockeComposeUpBuildDetached -Force").
        Append("`n").
        Append("New-Alias -Name dce -Value DockeComposeExec -Force").
        Append("`n").
        Append("New-Alias -Name dcps -Value DockeComposePs -Force").
        Append("`n").
        Append("New-Alias -Name dcres -Value DockeComposeRestart -Force").
        Append("`n").
        Append("New-Alias -Name dcrm -Value DockeComposeRm -Force").
        Append("`n").
        Append("New-Alias -Name dcr -Value DockeComposeRun -Force").
        Append("`n").
        Append("New-Alias -Name dcstop -Value DockeComposeStop -Force").
        Append("`n").
        Append("New-Alias -Name dcu -Value DockerComposeUp -Force").
        Append("`n").
        Append("New-Alias -Name dcud -Value DockeComposeUpd -Force").
        Append("`n").
        Append("New-Alias -Name dcd -Value DockeComposeDown -Force").
        Append("`n").
        Append("New-Alias -Name dcl -Value DockeComposeLogs -Force").
        Append("`n").
        Append("New-Alias -Name dclf -Value DockeComposeLogsf -Force").
        Append("`n").
        Append("New-Alias -Name dcpl -Value DockeComposePull -Force").
        Append("`n").
        Append("New-Alias -Name dcstart -Value DockeComposeStart -Force").
    ToString()
) > $null;


