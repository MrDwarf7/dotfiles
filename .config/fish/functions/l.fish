#!/usr/bin/env fish

function l 
    if test -z $LIST_CLIENT
        echo "LIST_CLIENT is not set"
        set -gx LIST_CLIENT "ls"
        return 1
    end
    $LIST_CLIENT -lah --color=always --level=1 $argv
end
