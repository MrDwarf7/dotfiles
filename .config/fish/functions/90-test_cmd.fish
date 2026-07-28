#!/usr/bin/env fish
#

# Helper function to handlerepeated code
function 90-test_cmd
    set cmd $argv[1]

    if not command -v $cmd >/dev/null
        printf "%s is not installed\n" $cmd
        return 1
    end

    return 0
end
