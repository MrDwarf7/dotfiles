#!/usr/bin/env fish
#

function __output_to_buf_pqiv --description "Outputs the result of `paru -Siv <pkg>` to `<buffer>` (provided)" --argument-names buffer
    set -l pkgs $argv[2..-1]
    paru -Siv $pkgs >$buffer 2>&1; or return $status
end

function pqiv --description "Queries paru for a pkg, then pipes it into `paru -Siv <pkg>`" --argument-names pkg
    # set pkg $argv[1]

    # alias pqi "command paru -Q | rg -i"
    set query_output (paru -Q | rg --ignore-case $pkg | awk '{print $1}')
    # pprint "Value of pkg: %s\nValue of query_output: %s\n" "$pkg" "$query_output"
    set -l buf (command mktemp)
    __output_to_buf_pqiv $buf $query_output; or return 2
    set -l buflen (string length -- $buf)
    cat $buf
    rm -f $buf

    # #####################################
    # if test $buflen -eq 0
    #     printf "No output from `paru -Siv <pkg>` for pkg: %s\n" "$pkg"
    #     return 1
    # end

    return $status
end
