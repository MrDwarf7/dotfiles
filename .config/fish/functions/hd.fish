#!/usr/bin/env fish
#

function hd --wraps=source --description 'Wrapper around `hunk diff` for jj'
    if not 00-valid_pacman jj
        colorize red "Error: jj is not installed or not in PATH."
    end
    if not 00-valid_pacman hunk
        colorize red "Error: hunk is not installed or not in PATH."
    end

    hunk diff $argv
    return $status
end
