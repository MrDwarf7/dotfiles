#!/usr/bin/env fish
#

set k_help h
set k_check c

function __pc_cmp
    complete -c pc -s $k_help -l help -d 'Print help message and exit.'
    complete -c pc -s $k_check -l check -d 'Show the current value of PKG_MANAGER and exit.'
    return 0
end

function __pc_help
    if not 00valid_pacman qsv
        return 0
    end

    090help "\
Stands for '[p]ackage [c]heck. Runs PKG_MANAGER -Su or paru -Su if PKG_MANAGER is set.'
Likely to check 'pacman' and 'paru' (or 'yay') for updates.

Usage: pc

Calls the package manager to check for updates
using the environment variable PKG_MANAGER,
if set or paru/yay as a fallback.
" "
,,,,
,Short                  ,Long                           ,Description,
,,,,
,-$k_help               , --help                        ,# Show this help message and exit.,
,-$k_check              , --check                       ,# Show the current value of PKG_MANAGER and exit.,
" "
,,,,
,Command                                                ,Description,,
,,,,
,pc -$k_help | --help                                   ,# Show this help message and exit.,,
,pc -$k_check | --check                                 ,# Show the current value of PKG_MANAGER and exit.,,
,pc                                                     ,# Check for package updates using PKG_MANAGER or paru/yay.,,
"
    return 0
end

function run_check
    set -l cmd $argv
    printf "n\n" | eval $cmd
    return 0
end

function pc --description "Stands for '[p]ackage [c]heck. Runs PKG_MANAGER -Su or paru -Su if PKG_MANAGER is set.'"
    __pc_cmp

    argparse $k_help/help $k_check/check  -- $argv
    or return

    # If h/help - run help, return 0;
    if set -q _flag_help
        __pc_help
        return 0
    end

    # If c/check - spit out the value of $PKG_MANAGER, return 0;
    if set -q _flag_check
        if test -n "$PKG_MANAGER"
            printf "PKG_MANAGER is set to:\n%s\n" $PKG_MANAGER
        else
            printf "PKG_MANAGER is not set.\n"
        end
        return 0
    end

    if test -z "$PKG_MANAGER"
      # if 00valid_pacman paru
      #     set -q PKG_MANAGER
      #   end
      colorize red "Error: PKG_MANAGER environment variable is not set.\n" >&2
      return 1
    end

    # If the PKG_MANAGER command fails, try paru as a fallback
    run_check $PKG_MANAGER -Su || run_check paru -Su || run_check yay -Su || return 1
    return $status
end

#     set -l ht " "
#     printf "\
# Usage: pc
#
# Calls the package manager using the environment
# variable PKG_MANAGER. if set
# or paru/yay as a fallback, to check for updates.
#
# Options:
#
# $ht pc --help, -h    # Show this help message and exit.
# $ht pc --check, -c   # Show the current value of PKG_MANAGER and exit.
#
# Examples:
#
# $ht pc -h | --help   # Show this help message and exit.
# $ht pc -c | --check  # Show the current value of PKG_MANAGER and exit.
# $ht pc               # Check for package updates using PKG_MANAGER or paru/yay.
# "
#     return 0
