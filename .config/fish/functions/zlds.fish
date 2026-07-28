#!/usr/bin/env fish
#

function zlds --wraps=source --description 'zellij delete-session'
    if not 00-valid_pacman zellij
        printf "Error: zellij is not installed.\n" >&2
        return 1
    end

    if test (count $argv) -gt 2 -o (count $argv) -eq 0
        printf "Usage: %s <session-name>\n" (status filename | sed 's/.*\/\(.*\)\.fish/\1/') >&2
        return 1
    end

    # if the first arg is '-f', pull it off, and store it.
    set force_delete 0
    if test $argv[1] = -f
        set argv $argv[2..-1]
        set force_delete 1
    end

    if zellij ls -s | grep -qE "^$argv[1]\s?"
        if test $force_delete -eq 1
            command zellij delete-session --force $argv[1] || return $status
            return 0
        end
        command zellij delete-session $argv[1] || return $status
        return 0
    else
        printf "Error: Session '%s' does not exist.\n" "$argv[1]" >&2
        return 1
    end

    return $status
end
