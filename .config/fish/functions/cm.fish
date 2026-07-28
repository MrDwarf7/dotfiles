#!/usr/bin/env fish
#

# WHERE="$(command -v cal-com)" echo "$(dirname "$WHERE")

function cm --description 'Cd to a binary commands housing directory'
    if test (count $argv) -eq 0
        echo "Usage: cm <command>"
        return 1
    end

    set cmd (command -v $argv[1])
    if test -z "$cmd"
        echo "Command not found: $argv[1]"
        return 1
    end
    99-pushd_var (dirname "$cmd")
end
