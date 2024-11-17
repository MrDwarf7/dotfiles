#!/usr/bin/env fish

# Updates the mirrorlist via rate-mirrors
# Output to a temp file, then copies the mirrorlist to a backup and replaces it with the new one
#
# Dependencies:
#   rate-mirrors
# System Dependencies:
#   sudo, mktemp, mv, cp, pacman, yay/paru, chown, echo, paccache
#
# Globals Variables:
#   PKG_MANAGER (yay/paru)
#
# Calls: 
#   ua_drop_caches
#
# Returns:
#   $status ($status != 0, otherwise 0)
function mirror_update
    if test -z "$PKG_MANAGER"
        echo "NOTE: PKG_MANAGER not set, defaulting to yay"
        set -l PKG_MANAGER "yay"
    end

    sudo true
    # cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup

    echo "Creating temporary file"
    set -l TMPFILE (mktemp)
    echo "Temporary file is " $TMPFILE

    echo "Updating mirrors"
    rate-mirrors --save=$TMPFILE arch --max-delay=21600

    echo "Moving mirrorlist from " $TMPFILE " to /etc/pacman.d/mirrorlist"
    sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup
    sudo mv $TMPFILE /etc/pacman.d/mirrorlist
    sudo chown root:root /etc/pacman.d/mirrorlist # Re-secure the mirrorlist file before leaving sudo


    ua_drop_caches
    $PKG_MANAGER -Syyu --noconfirm

    # rate-mirrors --save=$TMPFILE arch --max-delay=21600
    # sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup
    # sudo mv $TMPFILE /etc/pacman.d/mirrorlist
    # ua_drop_caches
    # $PKG_MANAGER -Syyu --noconfirm

    set -l func_status $status

    if test $status -ne 0
        echo "Mirrorlist update failed"
        return $func_status
    end
    return 0
end


# Drops the cache for the package manager and AUR
# System Dependencies:
#   sudo, paccache, false, yay/paru
#
# Globals Variables:
#   PKG_MANAGER (yay/paru)
#
function ua_drop_caches
    echo "Dropping caches"
    sudo true
    sudo paccache -rk3
    $PKG_MANAGER -Sc --aur --noconfirm
end
