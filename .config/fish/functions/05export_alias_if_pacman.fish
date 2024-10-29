#!/usr/bin/env fish

function 05export_alias_if_pacman
    set -l program_one $argv[1]
    set -l alias_name $argv[2]
    set -l alias_value $argv[3]

    # echo "5.0: Checking for $program_one"
    # echo "5.0: Setting $alias_name"
    # echo "5.0: Falling back to $alias_value"

    if 00valid_pacman $program_one
        # echo "5.1: Setting $alias_name to $alias_value"
        alias $alias_name=$alias_value
        return 0
    end
    return 1
end
