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

    set -l skip_mirror 1
    set -l skip_rustup 1

    # Loop here allows for supporting additional items in the switch/case later if wanted
    if set -q _flag_skip 
        for char in (string split '' $_flag_skip)
            switch $char
            case m
                set skip_mirror 0
            case r
                set skip_rustup 0
            case '*'
                echo "Invalid skip value: $_flag_skip" >&2 
                return 1
            end
        end
    end

    if test $skip_mirror -eq 1
        mirror_update || return $status
        _generic_update || return $status
    end

    if test $skip_rustup -eq 1
        command rustup update
    end

    return $status
end

# mirror_update || return $status
# command rustup update
