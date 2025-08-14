#!/usr/bin/env fish
#

alias dc "docker compose"
alias dcu "docker compose up"
alias dcub "docker compose up --build"
alias dcd "docker compose down"
alias dcdf "docker compose down --force"

alias Db. "docker buildx build ."
alias Db.t "docker buildx build . -t"
