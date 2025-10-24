#!/usr/bin/env fish
#

# Sources a provided program by file path
# if the program is found in pacman
#
# Parameters:
# $argv[1]: The program to check for
# $argv[2]: The file to source
#
# Returns:
# 0 if the program is found
# 1 if the program is not found
function 06source_if_pacman
    set -l program_one $argv[1]
    set -l file $argv[2]

    # printf "6.0: Checking for %s\n" "$program_one"
    # printf "6.0: Sourcing %s\n" "$file"

    if 00valid_pacman "$program_one"
        # printf "6.1: Sourcing %s\n" "$file"
        source $file
        return 0
    end
    return 1
end
