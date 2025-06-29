#!/usr/bin/env fish

function lg 
    if test -z $argv
        alias lg lazygit $argv
        command lazygit $argv
    else
        command lazygit $argv
    end
end
