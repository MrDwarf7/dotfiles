#!/usr/bin/env fish
#
# mirror_update/write.fish
#
# Generates the mirrorlist to a temp file, then atomically installs it
# (backup -> replace -> re-secure perms). No globals leak.

function __mirror_write --description 'Generate and install the mirrorlist'
    if not command -q rate-mirrors
        colorize red "rate-mirrors not found; cannot update mirrors.\n"
        return 1
    end

    set -l tmp (mktemp)
    or begin
        colorize red "mktemp failed.\n"
        return 1
    end

    set -l args (__mirror_build_args $tmp)
    # printf '%s\n' $args | xargs
    rate-mirrors $args
    or begin
        colorize red "rate-mirrors failed.\n"
        rm -f $tmp
        return 1
    end

    sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup
    sudo mv $tmp /etc/pacman.d/mirrorlist
    sudo chown root:root /etc/pacman.d/mirrorlist
    sudo chmod 644 /etc/pacman.d/mirrorlist
end
