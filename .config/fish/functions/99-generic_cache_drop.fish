#!/usr/bin/env fish
#

function 99-generic_cache_drop --description 'Drop package manager and AUR caches'
    # Drops the cache for the package manager and AUR
    # System Dependencies:
    #   sudo, paccache, yes, yay/paru
    #
    # Globals Variables:
    #   PKG_MANAGER (yay/paru)
    #
    printf "Dropping caches\n"
    sudo true
    if 00-valid_pacman paccache
        colorize blue "Dropping pacman cache (keeping 2 versions)..."
        sudo paccache --remove --keep 2
    else
        colorize red "paccache not found, skipping pacman cache drop."
        return 0
    end
    set -l flags -Scccddd

    colorize blue "Dropping ALL pacman cached packages (full clean)..."
    yes | tr '[:lower:]' '[:upper:]' | sudo pacman "$flags"

    if not test $PKG_MANAGER
        colorize yellow "PKG_MANAGER not set, defaulting to paru if installed."
        if 00-valid_pacman paru
            set -gx PKG_MANAGER paru
        else if 00-valid_pacman yay
            set -gx PKG_MANAGER yay
        else
            colorize red "No AUR helper found, skipping AUR cache drop."
            return 0
        end
    end

    yes | tr '[:lower:]' '[:upper:]' | $PKG_MANAGER "$flags"
    return $status
end
