#!/usr/bin/env fish


function dot 
    pushd $DOTDIR
    git fetch --all
    git status
end
