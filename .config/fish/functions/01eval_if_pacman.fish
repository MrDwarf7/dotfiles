#!/usr/bin/env fish

# Checks to make sure a program is installed before evaluating an expression
# Used for instances where the item must be called as source <(eval $expr)
#
# Parameters:
# $argv[1]: The program to check for
# $argv[2]: The expression to evaluate
#
# Returns:
# 0 if the program is installed
# 1 if the program is not installed
function 01eval_if_pacman
    set -l program_one $argv[1]
    set -l expr $argv[2]

    # printf "1.0: Checking for %s\n" "$program_one"
    # printf "1.0: Evaluating %s\n" "$expr"

    # command pacman -Qi "$program_one" &> /dev/null
    if 00valid_pacman "$program_one"
        # printf "1.1: Evaluating %s\n" "$expr"
        source <(eval $expr | psub)
        return 0
    end
    return 1
end
