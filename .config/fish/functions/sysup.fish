#!/usr/bin/env fish
#

# Renders help for the sysup function
#
# Parameters:
# None
#
# Returns:
# Returns 0 on success. (infallible)
function sysup_help --description 'Display help for sysup function'
    set -l ht " "
    printf "\
Usage: sysup [OPTIONS]

Updates the system, with options to skip certain parts.
Passing -s | --skip with no arguments will run a full update.
See the 'Sub' section for options to skip certain parts.

Options:

$ht --skip, -s <SUB>  # Skip certain parts of the update.
$ht --help, -h        # Show this help message.

Sub options for --skip / -s:

$ht m                 # Skip mirror update
$ht p                 # Skip package update
$ht r                 # Skip rustup update

Examples:

$ht m                 # Skip mirror update
$ht p                 # Skip package update
$ht r                 # Skip rustup update

Examples:

$ht sysup --skip m    # Skip mirror update
$ht sysup -s rp       # Skip rustup and package update
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
    argparse --name=sysup 's/skip=' h/help -- $argv
    or return

    if set -q _flag_help
        sysup_help
        return 0
    end

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
        mirror_update
        099generic_update
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
