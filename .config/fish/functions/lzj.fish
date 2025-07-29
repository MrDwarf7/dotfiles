#!/usr/bin/env fish

function lzj
    alias lzj jjui
    if not set -q argv[1]
        jjui -r 'all()'
    else
        jjui $argv
    end

    # command jjui -r 'all()' $argv
    # alias lzj lazyjj $argv
    # command lazyjj $argv
end
