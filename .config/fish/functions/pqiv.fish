#!/usr/bin/env fish
#

# set -g DEBUG_MODE 0
# function pprint
#     if test $DEBUG_MODE -eq 1
#         printf $argv
#     end
# end

function __output_to_buf_pqiv
    set -l buffer $argv[1]
    set -l pkgs $argv[2..-1]

    paru -Siv $pkgs >$buffer 2>&1
end

function pqiv --description "Queries paru for a pkg, then pipes it into `paru -Siv <pkg>`"
    set pkg $argv[1]

    # alias pqi "command paru -Q | rg -i"
    set query_output (paru -Q | rg -i $pkg | awk '{print $1}')
    # pprint "Value of pkg: %s\nValue of query_output: %s\n" "$pkg" "$query_output"
    set -l buf (command mktemp)
    # pprint "Created temporary buffer at: %s\n" "$buf"
    __output_to_buf_pqiv $buf $query_output

    cat $buf
    rm -f $buf
    return 0
end
