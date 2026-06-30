#!/usr/bin/env fish
#

function 00valid_pacman --description "Validates if a package is installed. (First via command -v; then via pacman -Qi)"
    # Validates if a package is installed
    #
    # Parameters:
    # $argv[1]: The package to check for
    #
    # Returns:
    # 0 if the package is installed
    # 1 if the package is not installed
    set -l to_test_prog $argv[1]

    # Check for both types of quotes and remove them if present
    # Allows the caller to be ambiguous about quotation(s)
    if string match -q '"*"' -- $to_test_prog
        set to_test_prog (string replace -r '^"|"$' '' -- $to_test_prog)
    end

    if string match -q "'*'" -- $to_test_prog
        set to_test_prog (string replace -r "^'|'" -- $to_test_prog)
    end

    # TEST: I belive we also tried 

    # wayyyyyyyyy faster to check via command -<flags> call FIRST,
    # if that fails, only then do we query via pacman -Qi (as it takes more time to resolve)
    if command -q "$to_test_prog"; and command -sq "$to_test_prog"; and command -vq "$to_test_prog"
        return 0
    else if command pacman -Qi "$to_test_prog" &>/dev/null
        return 0
    end
    return 1
end
