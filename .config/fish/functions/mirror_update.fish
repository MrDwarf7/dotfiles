#!/usr/bin/env fish
#

function __mirror_update_cmp
    complete -c mirror_update -s h -l help -d 'Print help message and exit.'
end

function __write_mirrorlist --description 'Write the current mirrorlist to a file'
    # Runs the rate-mirrors command to write the mirrorlist to a file
    # System Dependencies:
    #
    # Arguments:
    #   $argv[1] - mirror_listfile - The file to write the mirrorlist to
    #   $argv[2] - country - The entry country to use for the mirrorlist (default: AUS)
    #   $argv[3] - distro - The distro that the mirrorlist is for (default: arch)
    set mirror_list_file $argv[1]
    if not test -n "$mirror_list_file" || test -z "$mirror_list_file"
        printf "No mirror list file specified, using default: /tmp/mirrorlist\n"
        set -g TMPFILE /tmp/mirrorlist
    else
        set -g TMPFILE $mirror_list_file
        printf "Using mirror list file: %s\n" $mirror_list_file
    end

    set -l entry_country $argv[2]
    if not test -n "$entry_country" || test -z "$entry_country"
        printf "No entry country specified, using AUS\n"
        set -g COUNTRY AUS
    else
        set -g COUNTRY $entry_country
        printf "Using entry country: %s\n" $COUNTRY
    end

    set -l distro $argv[3] || set -l distro arch
    if not test -n "$distro"
        printf "No distro specified, using arch\n"
        set -l extract ""
        if test (command lsb_release)
            set extract (lsb_release -si | tr '[:upper:]' '[:lower:]' | tr -d '\r\n') # Last `| tr is` isn't really required, but keeps same pattern
        else
            # We tried a short-hand; R.I.P - have to use grep->sed regex lol
            #                    Read file          |     pull out NAME="Arch Linux"         "Arch Linux" / first part 'arch', lower | remove newlines
            set extract (command cat /etc/os-release | grep -E '^NAME=("\w+(\s\w+)?")+' | sed -z -E 's/(NAME\=)"(\w+)(\s+\w+)"/\L\2/' | tr -d '\r\n')
        end

        if test -z "$extract" # we failed (somehow) for both lsb_release and catting the /etc/os-release file (Despite argv[3] -> default arch)
            printf "Failed to extract distro from /etc/os-release, using arch\n"
            set -g DISTRO arch
        else
            printf "Extracted distro from /etc/os-release: %s\n" $extract
            set -g DISTRO $extract
        end
    end

    # If we want to try 'caching' against already tested mirrors at some stage (ie: ones already in the mirrorlist)
    # Would need to combine with writing to a file and probs diffing etc. (and using grep over rg for compat.)
    # cat /etc/pacman.d/mirrorlist | rg --pcre2 -o -e 'http[s]?\:\/\/(\w+[.-])+(\w+)?\/?(archlinux)?' | rate-mirrors stdin

    # 90_000ms -> 1.5 minutes (1min + 30 seconds)
    # 30_000ms -> 30 seconds

    # Ideally we move these to a string builder via a loop pattern at some point
    # can then also handle printing in the loop

    set -l per_mirror_timeout 90000
    set -l top_retest 15
    # set -l fetch_mirror_timeout 30000 ## default
    set -l fetch_mirror_timeout 90000
    set -l max_delay 21600

    set -l mirror_list_file $TMPFILE
    set -l TMPFILE $mirror_list_file

    set -l nn "\n\n"

    printf "Running rate-mirrors with the following parameters:$nn"
    printf "  mirror_list_file: %s\n" $TMPFILE
    printf "  per_mirror_timeout: $per_mirror_timeout ms\n"
    printf "  entry_country: %s\n" $COUNTRY
    printf "  top_retest: %d\n" $top_retest
    printf "  distro: %s\n" $distro
    printf "  fetch_mirror_timeout: $fetch_mirror_timeout ms$nn"

    rate-mirrors --save $TMPFILE \
        --per-mirror-timeout $per_mirror_timeout \
        --entry-country $COUNTRY \
        --top-mirrors-number-to-retest $top_retest \
        --disable-comments-in-file \
        $DISTRO \
        --max-delay $max_delay \
        --fetch-mirrors-timeout $fetch_mirror_timeout \
        || return $status

    return $status
end

function mirror_update --description 'Update the mirrorlist using rate-mirrors'
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
    if test -z "$PKG_MANAGER"
        colorize yellow "NOTE: PKG_MANAGER not set, defaulting to paru if installed.\n"
        if 00-valid_pacman paru
            colorize yellow "PKG_MANAGER not set, defaulting to paru."
            set -gx PKG_MANAGER paru
        end
        colorize yellow "PKG_MANAGER not set, defaulting to yay."
        set -gx PKG_MANAGER yay
        printf "Using PKG_MANAGER: %s\n" $PKG_MANAGER
    end

    sudo true
    # cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup

    colorize blue "Creating temporary file\n"
    set -g TMPFILE (mktemp)

    if test $status -ne 0
        if test -z "$TMPFILE"
            printf "Failed to create temporary file\n"
            printf "mktemp failed with status %d\n" $status
            return 1
        end
        printf "mktemp failed with status %d\n" $status
        return $status
    end

    set -g COUNTRY AUS
    set -g DISTRO arch
    printf "Temporary file created: %s\n" $TMPFILE

    printf "Updating mirrors\n"
    # rate-mirrors --save=$TMPFILE arch --max-delay=21600
    __write_mirrorlist $TMPFILE $COUNTRY $DISTRO || return $status

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
