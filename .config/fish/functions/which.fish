#!/usr/bin/env fish

function which --description 'better `which`'
    if abbr --query $argv
        # printf "%s is an abbreviation with definition\n" $argv
        # abbr --show | command grep "abbr -a -- $argv"
        # type --all $argv 2>/dev/null
        printf "%s" (abbr --show $argv | command sed 's/^\s*abbr -a -- //')
        type --all $argv
        return 0
    else
        type --all $argv
    end
end
