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
        printf "NOTE: PKG_MANAGER not set, defaulting to yay\n"
        set -l PKG_MANAGER "yay"
    end

    sudo true
    # cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup

    printf "Creating temporary file\n"
    set -l TMPFILE (mktemp)
    printf "Temporary file created: %s\n" $TMPFILE

    printf "Updating mirrors\n"
    rate-mirrors --save=$TMPFILE arch --max-delay=21600

    printf "Moving mirrorlist from %s to /etc/pacman.d/mirrorlist\n" $TMPFILE
    sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup || return 1
    sudo mv $TMPFILE /etc/pacman.d/mirrorlist || return 1
    sudo chown root:root /etc/pacman.d/mirrorlist                                   # Re-secure the mirrorlist file before leaving sudo
    # Make it readable by everyone
    sudo chmod 644 /etc/pacman.d/mirrorlist


    ua_drop_caches
    $PKG_MANAGER -Syyu --noconfirm || return $status

    # rate-mirrors --save=$TMPFILE arch --max-delay=21600
    # sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup
    # sudo mv $TMPFILE /etc/pacman.d/mirrorlist
    # ua_drop_caches
    # $PKG_MANAGER -Syyu --noconfirm

    set -l func_status $status

    if test $status -ne 0
        printf "Mirrorlist update failed\n"
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
    printf "Dropping caches\n"
    sudo true
    sudo paccache -rk3
    $PKG_MANAGER -Sc --aur --noconfirm
end
