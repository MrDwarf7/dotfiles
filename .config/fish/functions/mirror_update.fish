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
    set -g TMPFILE (mktemp)
    set -g COUNTRY AUS
    set -g DISTRO arch

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
    # rate-mirrors --save=$TMPFILE arch --max-delay=21600
    write_mirrorlist $TMPFILE $COUNTRY $DISTRO || return $status

    # if test -z "$mirror_list_file"
    #     if test "$TMPFILE" -ef "$mirror_list_file"
    #         set -l TMPFILE $mirror_list_file
    #     end
    # end

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

# Runs the rate-mirrors command to write the mirrorlist to a file
# System Dependencies:
# 
# Arguments:
#   $argv[1] - mirror_listfile - The file to write the mirrorlist to
#   $argv[2] - country - The entry country to use for the mirrorlist (default: AUS)
#   $argv[3] - distro - The distro that the mirrorlist is for (default: arch)
function write_mirrorlist --description 'Write the current mirrorlist to a file'
    set mirror_list_file $argv[1]
    if not test -n "$mirror_list_file"
        printf "No mirror list file specified, using /tmp/mirrorlist\n"
        set -g TMPFILE $mirror_list_file
    end

    set -l entry_country $argv[2]
    if not test -n "$entry_country"
        printf "No entry country specified, using AUS\n"
        set -g COUNTRY AUS
    end

    set -l distro $argv[3] || set -l distro arch
    if not test -n "$distro"
        printf "No distro specified, using arch\n"
        set -g DISTRO arch
    end

    # 90_000ms -> 1.5 minutes (1min + 30 seconds)
    # 30_000ms -> 30 seconds

    command rate-mirrors --save=$mirror_list_file \
        --per-mirror-timeout 90000 \
        --entry-country $COUNTRY \
        --top-mirrors-number-to-retest 15 \
        --disable-comments-in-file $DISTRO \
        --max-delay=30000
    # --max-delay=21600

    return $status
end
