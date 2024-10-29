#!/usr/bin/env fish

function 06source_if_pacman
    set -l program_one $argv[1]
    set -l file $argv[2]

    # echo "6.0: Checking for $program_one"
    # echo "6.0: Sourcing $file"

    if 00valid_pacman $program_one
        # echo "6.1: Sourcing $file"
        source $file
        return 0
    end
    return 0
end
