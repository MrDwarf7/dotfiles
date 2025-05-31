#!/usr/bin/env fish

function dot
    pushd ~/dotfiles || return 1
    command git fetch --all
    command git status
end
