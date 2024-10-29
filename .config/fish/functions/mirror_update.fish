#!/usr/bin/env fish

function mirror_update
    if test -z "$PKG_MANAGER"
        echo "NOTE: PKG_MANAGER not set, defaulting to yay"
        set -l PKG_MANAGER "yay"
    end

    function ua_drop_caches
        sudo paccache -rk3
        $PKG_MANAGER -Sc --aur --noconfirm
    end

    set -l TMPFILE "$mktemp"
    sudo true
    rate-mirrors --save=$TMPFILE arch --max-delay=21600
    sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup
    sudo mv $TMPFILE /etc/pacman.d/mirrorlist
    ua_drop_caches
    $PKG_MANAGER -Syyu --noconfirm
end
