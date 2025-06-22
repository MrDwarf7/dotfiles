#!/usr/bin/env fish

# Sources a provided program by file path
# if the program is found in pacman
#
# Parameters:
# $1: The program to check for
# $2: The file to source
#
# Returns:
# 0 if the program is found
# 1 if the program is not found
function 06source_if_pacman
    set -l program_one $argv[1]
    set -l file $argv[2]

    # echo "6.0: Checking for $program_one"
    # echo "6.0: Sourcing $file"

    if 00valid_pacman "$program_one"
        # echo "6.1: Sourcing $file"
        source $file
        return 0
    end
    return 0
end
