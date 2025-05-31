#!/usr/bin/env fish

function ff
    set -l example $argv[1]

    if test -z $example
    command fastfetch --config examples/13  # prev on load
    else
        command fastfetch --config examples/$example
    end
end
