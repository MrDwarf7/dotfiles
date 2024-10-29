#!/usr/bin/env fish

function lg 
    set -gx lg lazygit $argv
    $lg
end
