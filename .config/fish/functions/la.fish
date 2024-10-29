#!/usr/bin/env fish

function la
    if test -z $LIST_CLIENT
        echo "LIST_CLIENT is not set"
        set -gx LIST_CLIENT "ls"

        return 1
    end
    $LIST_CLIENT -a --tree --level=1 --icons=always $argv
end
