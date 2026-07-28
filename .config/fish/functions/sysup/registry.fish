#!/usr/bin/env fish
#
# sysup/registry.fish -- SINGLE SOURCE OF TRUTH for update steps
#
# Format per entry:  name|skip-letter|description
#   - name        : the step id; must match a function sysup_<name>
#   - skip-letter : single char for --skip, or '-' if not skippable
#   - description : shown in help
#
# To add a step: append one line + create sysup/<name>.fish.
# Nothing else needs editing. The orchestrator reads this list for the
# step order, the skip parser, the help text, and the dispatch call.

##################################################
### !!! THESE ARE ORDERED! DON'T SORT THEM !!! ###
##################################################
set -g sysup_steps \
    'mirror |m  |Update pacman mirrorlist via rate-mirrors' \
    'pacman |p  |Update official repository packages' \
    'aur    |a  |Update AUR packages' \
    'cache  |c  |Drop package caches' \
    'rustup |r  |Update rustup toolchains' \
    'neovim |n  |Update neovim headless via Lazy' \
    'ya     |y  |Update yazi packages' \
    'hermes |h  |Update hermes-agent harness'

function __split_entry --description 'Split a registry entry into parts'
    set -l parts (string split '|' $argv[1] | string trim)
    printf "%s" $parts
end

function __sysup_is_step --description 'True if NAME is a registered step'
    for entry in $sysup_steps
        set -l parts (__split_entry $entry)
        if test "$parts[1]" = "$argv[1]"
            return 0
        end
    end
    return 1
end

function __sysup_step_letter --description 'Skip-letter for a step name (empty if none)'
    for entry in $sysup_steps
        set -l parts (__split_entry $entry)
        if test "$parts[1]" = "$argv[1]"
            echo $parts[2]
            return 0
        end
    end
    return 1
end

function __sysup_step_letters --description 'All skip-letters joined (for argparse/help)'
    set -l letters
    for entry in $sysup_steps
        set -l parts (__split_entry $entry)
        if test "$parts[2]" != -
            # @fish-lsp-disable-next-line 4004
            set -a letters $parts[2]
        end
    end
    echo (string join '' $letters)
end
