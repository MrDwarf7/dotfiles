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
function mirror_update --description 'Update the mirrorlist using rate-mirrors'
    if test -z "$PKG_MANAGER"
        printf "NOTE: PKG_MANAGER not set, defaulting to yay\n"
        set -l PKG_MANAGER yay
    end

    sudo true
    # cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup

    printf "Creating temporary file\n"
    set -l TMPFILE (mktemp)

    if test $status -ne 0
        if test -z "$TMPFILE"
            printf "Failed to create temporary file\n"
            printf "mktemp failed with status %d\n" $status
            return 1
        end
        printf "mktemp failed with status %d\n" $status
        return $status
    end

    printf "Temporary file created: %s\n" $TMPFILE

    printf "Updating mirrors\n"
    rate-mirrors --save=$TMPFILE arch --max-delay=21600

    if test $status -ne 0
        printf "rate-mirrors failed with status %d\n" $status
        return $status
    end

    printf "Moving mirrorlist from %s to /etc/pacman.d/mirrorlist\n" $TMPFILE
    sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup || return 1
    sudo mv $TMPFILE /etc/pacman.d/mirrorlist || return 2
    sudo chown root:root /etc/pacman.d/mirrorlist || return 3 # Re-secure the mirrorlist file before leaving sudo
    # Make it readable by everyone
    sudo chmod 644 /etc/pacman.d/mirrorlist || return 4

    ua_drop_caches

    # _generic_update || return $status
    # $PKG_MANAGER -Syyu --noconfirm || return $status

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
function ua_drop_caches --description 'Drop package manager and AUR caches'
    printf "Dropping caches\n"
    sudo true
    sudo paccache -rk3
    $PKG_MANAGER -Sc --aur --noconfirm
end
