#!/usr/bin/env fish

# Drops the cache for the package manager and AUR
# System Dependencies:
#   sudo, paccache, false, yay/paru
#
# Globals Variables:
#   PKG_MANAGER (yay/paru)
#
function 099generic_cache_drop --description 'Drop package manager and AUR caches'
    printf "Dropping caches\n"
    sudo true
    sudo paccache -rk2
    $PKG_MANAGER -Sc --aur --noconfirm
end
