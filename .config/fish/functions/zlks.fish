#!/usr/bin/env fish
#

function zlks --wraps=source --description 'zellij kill-session'
    if not 00valid_pacman zellij
        printf "Error: zellij is not installed.\n" >&2
        return 1
    end

    if test (count $argv) -ne 1
        printf "Usage: %s <session-name>\n" (status filename | sed 's/.*\/\(.*\)\.fish/\1/') >&2
        return 1
    end

    if zellij ls -s | grep -qE "^$argv[1]\s?"
        command zellij kill-session $argv[1] || return $status
    else
        printf "args were: %s\n" "$argv"
        printf "Error: Session '%s' does not exist.\n" "$argv[1]" >&2
        return 1
    end

    return $status
end
