#!/usr/bin/env fish
#

function 099aur_update --description 'Uses the PKG_MANAGER to update AUR packages. Wrapped with sudo "on" calls'
    if test -z "$PKG_MANAGER"
        # printf "NOTE: PKG_MANAGER not set\nNo default set!"
        colorize red "PKG_MANAGER environment variable not set. Cannot update AUR packages.\n"
        return 1
    end

    sudo true
    command $PKG_MANAGER -Syu --devel --needed --noconfirm
    sudo true

    return $status
end
