#!/usr/bin/env fish
#

function spot --description 'Ncspot spotify client TUI'
    if 00-valid_pacman ncspot
        ncspot $argv || return $status
        return 0
    end
    return 1
end
