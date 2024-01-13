# docker compose Set-Alias

function DockerComposeUp {
    docker compose up $args
}
function DockeComposeBuild {
    docker compose build
}
function DockeComposeUpBuild {
    docker compose up --build
}
function DockeComposeExec {
    docker compose exec $args
}
function DockeComposePs {
    docker compose ps $args
}
function DockeComposeRestart {
    docker compose restart
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
    docker compose up -d
}
function DockeComposeDown {
    docker compose down
}
function DockeComposeLogs {
    docker compose logs
}
function DockeComposeLogsf {
    docker compose logs -f
}
function DockeComposePull {
    docker compose pull
}
function DockeComposeStart {
    docker compose start
}
# Set-Alias dco docker compose
Set-Alias dcb DockeComposeBuild
Set-Alias dcub DockeComposeUpBuild
Set-Alias dce DockeComposeExec
Set-Alias dcps DockeComposePs
Set-Alias dcres DockeComposeRestart
Set-Alias dcrm DockeComposeRm
Set-Alias dcr DockeComposeRun
Set-Alias dcstop DockeComposeStop
Set-Alias dcu DockerComposeUp
Set-Alias dcud DockeComposeUpd
Set-Alias dcd DockeComposeDown
Set-Alias dcl DockeComposeLogs
Set-Alias dclf DockeComposeLogsf
Set-Alias dcpl DockeComposePull
Set-Alias dcstart DockeComposeStart


