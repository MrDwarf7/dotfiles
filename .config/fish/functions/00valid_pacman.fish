#!/usr/bin/env fish

# Validates if a package is installed
#
# Parameters:
# $argv[1]: The package to check for
#
# Returns:
# 0 if the package is installed
# 1 if the package is not installed
function 00valid_pacman
    set -l to_test_prog $argv[1]

    # Check for both types of quotes and remove them if present
    # Allows the caller to be ambiguous about quotation(s)
    if string match -q '"*"' -- $to_test_prog
        set to_test_prog (string replace -r '^"|"$' '' -- $to_test_prog)
    end

    if string match -q "'*'" -- $to_test_prog
        set to_test_prog (string replace -r "^'|'" -- $to_test_prog)
    end

    # wayyyyyyyyy faster to check via command -<flags> call FIRST,
    # if that fails, ony then do we query via pacman -Qi (as it takes time for resolution)
    if command -sq "$to_test_prog"; and command -q "$to_test_prog"; and command -vq "$to_test_prog"
        return 0
    else if command pacman -Qi "$to_test_prog" &>/dev/null
        return 0
    end
    return 1
end
