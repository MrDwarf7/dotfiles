#!/usr/bin/env fish
#

# Helper function to handled repeated code
function 090test_path
    set path $argv[1]

    if not test -f $path
        printf "File does not exist: %s\n" $path
        return 1
    end
    return 0
end
