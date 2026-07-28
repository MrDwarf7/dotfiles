#!/usr/bin/env fish
#
# sysup/pacman.fish -- step: update official repo packages
#
# Single responsibility, guard up front.

function sysup_pacman --description 'Step: update official packages'
    if not 00-valid_pacman pacman
        colorize red "pacman not found; cannot update official packages.\n"
        return 1
    end
    sudo true
    # -Syyu (double-y) forces a mirror DB refresh. Needed because the mirror
    # step may have swapped the active mirrorlist; without it we can pull
    # from a stale cached DB.
    command sudo pacman -Syyu --needed --noconfirm
end
