#!/usr/bin/env fish

function lt
    if test -z $LIST_CLIENT
        echo "LIST_CLIENT is not set"
        set -gx LIST_CLIENT "ls"

        return 1
    end
    $LIST_CLIENT -a --tree --level=2 --icons=always $argv
end
