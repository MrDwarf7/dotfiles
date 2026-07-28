#!/usr/bin/env fish
#
# mirror_update/detect_distro.fish
#
# Pure helper: no globals. Echoes the distro name rate-mirrors expects.
# Resolution order:
#   1. $RATE_MIRRORS_DISTRO env override
#   2. lsb_release -si (lowercased, spaces stripped)
#   3. parse NAME= from /etc/os-release
#   4. fallback: arch

function __mirror_detect_distro --description 'Detect distro for rate-mirrors'
    if test -n "$RATE_MIRRORS_DISTRO"
        echo $RATE_MIRRORS_DISTRO
        return 0
    end

    if command -q lsb_release
        lsb_release -si | tr '[:upper:]' '[:lower:]' | string replace -r ' ' ''
        return 0
    end

    if test -f /etc/os-release
        set -l name (grep -E '^NAME=' /etc/os-release \
            | sed -E 's/NAME="?([a-zA-Z]+).*/\L\1/')
        if test -n "$name"
            echo $name
            return 0
        end
    end

    echo arch
end
