#!/usr/bin/env fish

function 01eval_if_pacman
    set -l program_one $argv[1]
    set -l expr $argv[2]

    # echo "1.0: Checking for $program_one"
    # echo "1.0: Evaluating $expr"

    if pacman -Qi "$program_one" &> /dev/null
        # echo "1.1: Evaluating $expr"
        source <(eval $expr | psub)
        return 0
    end
    return 1
end
