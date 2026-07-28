#!/usr/bin/env fish
#

function hdn --wraps=source --description 'Wrapper around `diffnav` for jj'
    not 00-valid_pacman jj; and not 00-valid_pacman diffnav; and return 1

    # if not 00-valid_pacman jj
    #     colorize red "Error: jj is not installed or not in PATH."
    #     return 1
    # end
    # if not 00-valid_pacman diffnav
    #     colorize red "Error: hunk is not installed or not in PATH."
    #     return 1
    # end

    jj diff --git -f 'trunk()' | diffnav
    return $status
end
