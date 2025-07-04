#!/usr/bin/env fish

function tldr_x --description "Picks a random tldr page and displays it"
    if ! test -z "$argv[1..-1]"
        printf "Oops! This special command wrapper does not accept any arguments.\n"
        return 1
    end
    command tldr --list | shuf --head-count 1 | xargs tldr
    return $status
end
