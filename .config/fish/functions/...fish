#!/usr/bin/env fish

function .. --wraps=source --description 'alias ..=cd ..'
    # echo "argv 1 : $argv[1]"
    # echo "argv 2 : $argv[2]"
    # echo "argv 3 : $argv[3]"
    # echo "count val : $(count $argv)"

    pushd .. 
    if test (count $argv) -gt 0
        .. $argv[2..-1]
    end
end
