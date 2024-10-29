#!/usr/bin/env fish

function 00valid_pacman 
    set -l to_test_prog $argv[1]

    if pacman -Qi $to_test_prog &> /dev/null
        return 0
    else
        return 1
    end
    return 1
end

