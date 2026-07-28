#!/usr/bin/env fish
#

function 99-pacman_update --description 'Uses `pacman` to update official packages. Ideally run prior to AUR updates. Wrapped with sudo "on" calls'
    if not 00-valid_pacman pacman
        colorize red "pacman command not found. This function requires pacman to update official packages.\n"
        return 1
    end

    sudo true
    command sudo pacman -Syu --needed --noconfirm || return $status
    sudo true
    return $status
end
