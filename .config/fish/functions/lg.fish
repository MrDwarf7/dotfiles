#!/usr/bin/env fish

function lg 
    if test -z $argv
        set -gx lg lazygit $argv
        $lg
    else
        lazygit $argv
    end
end
