#!/usr/bin/env fish

# Validates if a package is installed
#
# Parameters:
# $1: The package to check for
#
# Returns:
# 0 if the package is installed 
# 1 if the package is not installed
function 00valid_pacman 
    set -l to_test_prog $argv[1]

    if pacman -Qi $to_test_prog &> /dev/null
        return 0
    else
        return 1
    end
    return 1
end

