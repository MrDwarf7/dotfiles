#!/usr/bin/env fish
#

function hdn --wraps=source --description 'Wrapper around `diffnav` for jj'
    if not 00valid_pacman jj
        colorize red "Error: jj is not installed or not in PATH."
    end
    if not 00valid_pacman diffnav
        colorize red "Error: hunk is not installed or not in PATH."
    end

    jj diff --git | diffnav
    return $status
end
