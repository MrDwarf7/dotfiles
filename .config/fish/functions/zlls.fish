#!/usr/bin/env fish
#

function zlls --wraps=source --description 'zellij new/start'
    if not 00valid_pacman zellij
        printf "Error: zellij is not installed.\n" >&2
        return 1
    end

    command zellij list-sessions || return $status
    return $status
end
