#!/usr/bin/env fish

function spot --description 'Ncspot spotify client TUI'
    if command pacman -Qi "ncspot" &>/dev/null
        ncspot $argv || return $status
        return 0
    end
    return 1
end
