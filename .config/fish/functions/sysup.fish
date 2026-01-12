#!/usr/bin/env fish
#


set k_help h
set k_skip s
set k_mirror m
set k_rustup r
set k_packages p
set k_shutdown d


function __sysup_cmp
    complete -c sysup -s $k_help -l help -d 'Show this help message and exit'
    complete -c sysup -s $k_skip -l skip -a "m r p" -d 'Skip certain parts of the update. Use with m (mirror), r (rustup), p (packages)'
    complete -c sysup -l skip -a "m r p" -d 'Skip certain parts of the update. Use with m (mirror), r (rustup), p (packages)'
    complete -c sysup -s $k_shutdown -l shutdown -d 'Shutdown the system after update completes. Only works if the update completes successfully.'
    return 0
end


# Renders help for the sysup function
#
# Parameters:
# None
#
# Returns:
# Returns 0 on success. (infallible)
function __sysup_help
    090help "\
Usage: sysup [FLAG] [SUB]

Runs a system update, with options to skip certain parts.

Includes:

- Mirror update
- Pacman package update
- AUR package update
- Rustup update
" "
,                    ,                           ,           ,
,Short               ,Long                       ,Description,
,                    ,                           ,           ,
,-$k_help            , --help                    ,# Show this help message and exit,
,-$k_skip            , --skip                    ,# Skip certain parts of the update. Use with m (mirror) | r (rustup) | p (packages),
,-$k_shutdown        , --shutdown                ,# Shutdown the system after update completes. Only works if the update completes successfully.,
" "
,                                       ,           ,,
,Command                                ,Description,,
,                                       ,           ,,
,sysup -$k_help                           ,# Show this help message and exit,,
,sysup -$k_skip                           ,# Use with (m; r; p) to skip certain parts of the update. For example: -s -r to skip rustup and mirror update.,,
,sysup -$k_skip -m                        ,# Use -m to skip mirror update,,
,sysup -$k_skip -r                        ,# Use -r to skip rustup update,,
,sysup -$k_skip -p                        ,# Use -p to skip package update,,
,sysup -$k_shutdown                       ,# Shutdown the system after successful update,,
"
    return 0
end

# Runs a system update, optionally skipping certain parts
#
# Parameters:
# Supports both `--skip` and `-s` flags to skip certain parts of the update.
# - `m` for mirror update
# - `r` for rustup update
#
# Usage:
# sysup --skip m
#
# Returns:
# Returns 0 on success, 1 on failure.
function sysup --description 'System update function'
    __sysup_cmp

    argparse --name=sysup $k_help/help $k_shutdown/shutdown $k_skip/skip= -- $argv
    or return

    if set -q _flag_help
        __sysup_help
        return 0
    end

    # Should skip 1 = true, 0 = false
    set -l skip_mirror false
    set -l skip_rustup false
    set -l skip_packages false

    set -l shutdown_waittime_mins 1
    set -l shutdown_waittime_secs (math "60 * $shutdown_waittime_mins")

    # Loop here allows for supporting additional items in the switch/case later if wanted
    if set -q _flag_skip
        for char in (string split '' $_flag_skip)
            switch $char
                case m
                    set skip_mirror true
                case r
                    set skip_rustup true
                case p
                    set skip_packages true
                case '*'
                    echo "Invalid skip value: $_flag_skip" >&2
                    return 1
            end
        end
    end

    set -l mise_exists (test (command -v mise); and echo 0; or echo 1)

    if test $mise_exists -eq 0
        colorize yellow "[SYSUP] Disabling mise...\n\n"
        mise deactivate 2>&1 >/dev/null
    else
        colorize yellow "[SYSUP] mise not found, skipping deactivation.\n\n"
    end

    colorize blue "[SYSUP] Starting system update...\n"

    if test $skip_mirror = true
        colorize yellow "[SYSUP] Skipping mirror update...\n"
        colorize yellow "[SYSUP] Running generic update only...\n"
        099pacman_update || return $status
        099aur_update || return $status
    else if test $skip_packages = true
        colorize yellow "[SYSUP] Skipping package update...\n"
        colorize yelloe "[SYSUP] Running mirror update only...\n"
        mirror_update || return $status
    else
        colorize yellow "[SYSUP] Running full update...\n"
        mirror_update
        099pacman_update || return $status
        099aur_update || return $status
        099generic_cache_drop || return $status
    end

    if test $skip_rustup != true
        colorize yellow "[SYSUP] Updating rustup...\n"
        command rustup update || return $status
    end

    if test $mise_exists -eq 0
        colorize yellow "[SYSUP] Re-enabling mise...\n"
        mise activate fish | source
        colorize yellow "[SYSUP] Running `mise up` to update tools\n"
        mise up || return $status
    else
        printf "mise not found, skipping re-activation.\n"
    end

    colorize green "[SYSUP] System update complete!\n"


    if set -q _flag_shutdown
        colorize yellow "[SYSUP] Shutting down system in $shutdown_waittime_mins minute(s). Press Ctrl-C to cancel.\n"

        while test $shutdown_waittime_secs -gt 0
            colorize yellow "[SYSUP] System will shutdown in $shutdown_waittime_secs seconds...\r"
            sleep 1
            set shutdown_waittime_secs (math $shutdown_waittime_secs - 1)
        end
        # colorize red "[SYSUP] THIS IS DEBUG MODE!!!!\n"
        sudo shutdown -h now
    end

    return $status
end

# mirror_update || return $status
# command rustup update
