#!/usr/bin/env fish

# Checks to make sure a program is installed before evaluating an expression
# Used for instances where the item must be called as source <(eval $expr)
#
# Parameters:
# $1: The program to check for
# $2: The expression to evaluate
#
# Returns:
# 0 if the program is installed
# 1 if the program is not installed
function 01eval_if_pacman
    set -l program_one $argv[1]
    set -l expr $argv[2]

    # echo "1.0: Checking for $program_one"
    # echo "1.0: Evaluating $expr"

    if command pacman -Qi "$program_one" &> /dev/null
        # echo "1.1: Evaluating $expr"
        source <(eval $expr | psub)
        return 0
    end
    return 1
end
