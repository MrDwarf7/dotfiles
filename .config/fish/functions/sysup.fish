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

    # Loop here allows for supporting additional items in the switch/case later if wanted
    if set -q _flag_skip 
        for char in (string split '' $_flag_skip)
            switch $char
            case m
                set skip_mirror true
            case r
                set skip_rustup true
            case '*'
                echo "Invalid skip value: $_flag_skip" >&2 
                return 1
            end
        end
    end

    printf "Disabling mise...\n"
    command mise deactivate > /dev/null

    if test $skip_mirror = true
        _generic_update || return $status
    else
        mirror_update || return $status
        _generic_update || return $status
    end

    if test $skip_rustup != true
        command rustup update || return $status
    end

    printf "Re-enabling mise...\n"
    command mise activate > /dev/null

    return $status
end

# mirror_update || return $status
# command rustup update
