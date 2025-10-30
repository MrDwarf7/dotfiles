#!/usr/bin/env fish
#

function 099generic_cache_drop --description 'Drop package manager and AUR caches'
    # Drops the cache for the package manager and AUR
    # System Dependencies:
    #   sudo, paccache, false, yay/paru
    #
    # Globals Variables:
    #   PKG_MANAGER (yay/paru)
    #
    printf "Dropping caches\n"
    sudo true
    sudo paccache -rk2
    if not test $PKG_MANAGER
        printf "PKG_MANAGER not set, defaulting to paru if installed.\n"
        if 00valid_pacman paru
            set -gx PKG_MANAGER paru
        else if 00valid_pacman yay
            set -gx PKG_MANAGER yay
        else
            printf "No AUR helper found, skipping AUR cache drop.\n"
            return 0
        end
    end

    $PKG_MANAGER -Sc --aur --noconfirm
    return $status
end
