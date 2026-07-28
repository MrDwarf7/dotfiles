#!/usr/bin/env fish
#

function zlkas --wraps=source --description 'zellij kill-all-sessions'
    if not 00-valid_pacman zellij
        printf "Error: zellij is not installed.\n" >&2
        return 1
    end

    set force 0
    if test (count $argv) -eq 1
        if test $argv[1] = -f
            set force 1
        end
    end

    if test $force -eq 1
        command zellij kill-all-sessions --yes || return $status
    else
        command zellij kill-all-sessions --yes || return $status
    end

    return $status
end
