#!/usr/bin/env fish
#

function 90-table --argument-names data padding delimiter use_stdin --description "Prints a table from a string or stdin using qsv"
    if not 00-valid_pacman qsv
        colorize red "qsv is not installed. Please install qsv to use this function."
        return 1
    end

    # set -l data $argv[1] # string
    # set -l padding $argv[2] # int
    # set -l delimiter $argv[3] # single char
    # set -l use_stdin $argv[4] # boolean

    # validation for input argv

    not test (math $padding) -ge 0; and set padding (math 1)

    # if not test (math $padding) -ge 0
    #     set padding (math 1)
    # end

    test (string length -- $delimiter) -ne 1; and set delimiter ","

    # if test (string length -- $delimiter) -ne 1
    #     set delimiter ","
    # end

    test -z "$use_stdin" -o -z "$data"; and set use_stdin false
    # if test -z "$use_stdin" -o -z "$data"
    #     set use_stdin false
    # end
    test "$use_stdin" = true; and qsv table --pad (math $padding) --delimiter "$delimiter" --align Left -o -; and return 0

    # if test "$use_stdin" = true
    #     qsv table --pad (math $padding) --delimiter "$delimiter" --align Left -o -
    # else
    printf "%s\n" $data |
        qsv table --pad (math $padding) --delimiter "$delimiter" --align Left -o -
    # end
end
