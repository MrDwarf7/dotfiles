#!/usr/bin/env fish
#

set k_help h
set k_sort s
# set k_prefix p
# set k_case_sense c

function __envprefix_cmp
    complete -c env_prefix -s $k_help -l help -d 'Show this help message and exit'
    complete -c env_prefix -s $k_sort -l sort -d 'Sort the output alphabetically'
    # complete -c env_prefix -s $k_prefix -l prefix= -d 'Specify the prefix to search for (default: XDG_)'
    # complete -c env_prefix -s $k_case_sense -l case_sensitive -d 'Use case sensitive sorting (Default is case insensitive)'
end

function __envprefix_help
    if not 00-valid_pacman qsv
        colorize red "qsv is not installed. Please install qsv to use the help function.\n"
        return
    end

    # ,-$k_case_sense              , --case_sensitive          ,# Use case sensitive sorting (Default is case insensitive),
    # ,envprefix -$k_prefix PATH $k_sort     ,# Lists all environment variables starting with 'PATH' sorted alphabetically,,
    # ,-$k_prefix                 , --prefix PREFIX           ,# Specify the prefix to search for (default: XDG_),
    # ,envprefix -$k_prefix HOME             ,# Lists all environment variables starting with 'HOME',,
    90-help "\
Usage: envprefix [OPTIONS] [PREFIX]

Prints all environment variables with a specific prefix
defaults to XDG_ if none given.
" "
,                           ,                           ,           ,
,Short                      ,Long                       ,Description,
,                           ,                           ,           ,
,-$k_help                   , --help                    ,# Show this help message and exit,
,-$k_sort                   , --sort                    ,# Sort the output alphabetically,
" "
,                                       ,           ,,
,Command                                ,Description,,
,                                       ,           ,,
,envprefix                             ,# Lists all environment variables starting with 'XDG_',,
,envprefix -$k_sort                    ,# Lists all environment variables starting with 'XDG_' sorted alphabetically,,
"

    return 0
end

function __output_to_buf -a buffer pattern
    set -l value (env | string match -er "$pattern.*")
    printf "%s\n" $value >$buffer
end

function envprefix --description "Prints all environment variables with a specific prefix, defaults to XDG_ if none given"
    __envprefix_cmp

    # argparse $k_help/help $k_sort/sort $k_case_sense/case_sensitive $k_prefix/prefix= -- $argv
    argparse $k_help/help $k_sort/sort -- $argv
    or return

    if set -q _flag_help
        __envprefix_help && return $status
    end

    # if it's empty
    if test (count $argv) -eq 0
        set argv[1] ".*"
    end

    set -g buf (command mktemp)
    __output_to_buf $buf $argv[1]
    set data (cat $buf)
    rm $buf && set -e buf

    set data (string replace -r '^PATH=.*$' '' $data)

    # remove the PATH line from the output as it's often very noisy
    # set data (sed -i '/^PATH=/d' $data)
    # set data (string replace -r '^PATH=.*' '' $data)

    if test $_flag_sort
        set data (printf "%s\n" $data | sort -bfh)
    end

    printf "%s\n" $data
    return 0
end
