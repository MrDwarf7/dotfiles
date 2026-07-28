#!/usr/bin/env fish
#

function 90-table
    if not 00-valid_pacman qsv
        colorize red "qsv is not installed. Please install qsv to use this function."
        return 1
    end

    set -l data $argv[1] # string
    set -l padding $argv[2] # int
    set -l delimiter $argv[3] # single char
    set -l use_stdin $argv[4] # boolean

    # validation for input argv

    if not test (math $padding) -ge 0
        set padding (math 1)
    end

    if test (string length -- $delimiter) -ne 1
        set delimiter ","
    end

    if test -z "$use_stdin" -o -z "$data"
        set use_stdin false
    end

    if test "$use_stdin" = true
        qsv table --pad (math $padding) --delimiter "$delimiter" --align Left -o -
    else
        printf "%s\n" $data |
            qsv table --pad (math $padding) --delimiter "$delimiter" --align Left -o -
    end
end
