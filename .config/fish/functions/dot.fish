#!/usr/bin/env fish

function dot
    if test "$(pwd)" != "$HOME/dotfiles"
        printf "Moving to: %s\n" "$HOME/dotfiles"
        pushd ~/dotfiles || return $status
    end
    printf "Fetching... \n"
    command git fetch
    command git status
end
