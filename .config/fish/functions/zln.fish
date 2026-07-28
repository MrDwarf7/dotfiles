#!/usr/bin/env fish
#

function zln --wraps=source --description 'zellij new/start'
    if not 00-valid_pacman zellij
        printf "Error: zellij is not installed.\n" >&2
        return 1
    end

    # only `zln`
    if test -z "$argv"
        command zellij --session $(tr -dc a-z0-9 </dev/urandom | head -c 3 ; printf "\n") || return $status
        return 0
    end

    # we need to check if it exists first, if it does, attach,
    # otherwise use -s <name> to create a new session

    if zellij ls -s | grep -qE "^$argv[1]\s?"
        command zellij a $argv[1] || return $status
    else
        command zellij --session $argv[1] || return $status
    end

    return $status
end
