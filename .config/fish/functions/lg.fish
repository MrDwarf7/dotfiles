#!/usr/bin/env fish

function lg 
    if test -z $argv
        set -gx lg lazygit
        # $lg
        command lazygit $argv
    else
        command lazygit $argv
    end
end
