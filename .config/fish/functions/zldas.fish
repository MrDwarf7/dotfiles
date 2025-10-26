#!/usr/bin/env fish
#

function zldas --description 'zellij delete-session'
    if not 00valid_pacman zellij
        printf "Error: zellij is not installed.\n" >&2
        return 1
    end

    set force 0

    if test (count $argv) -eq 1
        if test $argv[1] = -f
            set argv $argv[2..-1]
            set force 1
        end
    end

    if test $force -eq 1
        command zellij delete-all-sessions --force --yes || return $status
    else
        command zellij delete-all-sessions --yes || return $status
    end
    return $status
end
