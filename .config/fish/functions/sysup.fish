#!/usr/bin/env fish

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
    argparse --name=sysup 's/skip=' -- $argv
    or return

    # Should skip 1 = true, 0 = false
    set -l skip_mirror false
    set -l skip_rustup false
    set -l skip_packages false

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
        printf "Disabling mise...\n"
        mise deactivate 2>&1 >/dev/null
    else
        printf "mise not found, skipping deactivation.\n"
    end

    colorize blue "\n\nStarting system update...\n"

    if test $skip_mirror = true
        colorize yellow "Skipping mirror update...\nRunning generic update only...\n"
        099generic_update || return $status
    else if test $skip_packages = true
        colorize yellow "Skipping package update...\nRunning mirror update only...\n"
        mirror_update || return $status
    else
        colorize yellow "Running full update...\n"
        mirror_update || return $status
        099generic_update || return $status
        099generic_cache_drop || return $status
    end

    if test $skip_rustup != true
        colorize yellow "Updating rustup...\n"
        command rustup update || return $status
    end

    if test $mise_exists -eq 0
        printf "Re-enabling mise...\n"
        mise activate fish | source
    else
        printf "mise not found, skipping re-activation.\n"
    end

    colorize green "System update complete!\n"

    return $status
end

# mirror_update || return $status
# command rustup update
