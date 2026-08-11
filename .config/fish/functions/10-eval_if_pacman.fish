#!/usr/bin/env fish
#

function 10-eval_if_pacman --argument-names program_one expr --description "If a provided program is available via pacman, evaluates a provided expression"
    # Checks to make sure a program is installed before evaluating an expression
    # Used for instances where the item must be called as:
    #
    # `source <(eval $expr)`
    # OR
    # `$expr | source`
    # OR
    # `eval $expr | source`
    #
    # Parameters:
    # $argv[1]: The program to check for
    # $argv[2]: The expression to evaluate
    #
    # Returns:
    # 0 if the program is installed
    # 1 if the program is not installed
    # set -l program_one $argv[1]
    # set -l expr $argv[2]
    00-valid_pacman "$program_one"; and eval $expr | source; and return 0
    or return 1

    # printf "1.0: Checking for %s\n" "$program_one"
    # printf "1.0: Evaluating %s\n" "$expr"

    # printf "1.1: Evaluating %s\n" "$expr"
    # source <(eval $expr | psub) ## previous way
    #     eval $expr | source
    #     return 0
    # end
    # or return 1
end
