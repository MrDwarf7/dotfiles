#!/usr/bin/env fish

function dot
    pushd ~/dotfiles || return 1
    git fetch --all
    git status
end
