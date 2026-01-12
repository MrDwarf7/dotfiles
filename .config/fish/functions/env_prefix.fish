#!/usr/bin/env fish
#

set k_help h
set k_sort s
set k_prefix p
set k_case_sense c

function __env_prefix_cmp
    complete -c env_prefix -s $k_help -l help -d 'Show this help message and exit'
    complete -c env_prefix -s $k_prefix -l prefix= -d 'Specify the prefix to search for (default: XDG_)'
    complete -c env_prefix -s $k_sort -l sort -d 'Sort the output alphabetically'
    complete -c env_prefix -s $k_case_sense -l case_sensitive -d 'Use case sensitive sorting (Default is case insensitive)'
    return 0
end

function __env_prefix_help
    if not 00valid_pacman qsv
        colorize red "qsv is not installed. Please install qsv to use the help function.\n"
        return
    end

    090help "\
Usage: env_prefix [OPTIONS] [PREFIX]

Prints all environment variables with a specific prefix
defaults to XDG_ if none given.
" "
,                           ,                           ,           ,
,Short                      ,Long                       ,Description,
,                           ,                           ,           ,
,-$k_help                   , --help                    ,# Show this help message and exit,
,-$k_prefix                 , --prefix PREFIX           ,# Specify the prefix to search for (default: XDG_),
,-$k_sort                   , --sort                    ,# Sort the output alphabetically,
,-$k_case_sense              , --case_sensitive          ,# Use case sensitive sorting (Default is case insensitive),
" "
,                                       ,           ,,
,Command                                ,Description,,
,                                       ,           ,,
,env_prefix                             ,# Lists all environment variables starting with 'XDG_',,
,env_prefix -$k_prefix HOME             ,# Lists all environment variables starting with 'HOME',,
,env_prefix -$k_sort                    ,# Lists all environment variables starting with 'XDG_' sorted alphabetically,,
,env_prefix -$k_prefix PATH $k_sort     ,# Lists all environment variables starting with 'PATH' sorted alphabetically,,
"

    return 0
end

function env_prefix --description 'Prints all environment variables with a specific prefix, defaults to XDG_ if none given'
    __env_prefix_cmp

    argparse $k_help/help $k_sort/sort $k_case_sense/case_sensitive $k_prefix/prefix= -- $argv
    or return

    if set -q _flag_help
        __env_prefix_help && return $status
    end

    set -l prefix
    set -l sorted 0
    set -l flags -q

    # Check if flag was used (either -p or --prefix)
    if set -q _flag_prefix
        set prefix $_flag_prefix
        # Check if positional argument was provided
    else if test (count $argv) -gt 0
        set prefix $argv[1]
    end

    if set -q _flag_sort
        set sorted 1
    end

    # Use default if prefix is empty or not set
    if test -z "$prefix"
        set prefix XDG_
    end

    if test (not set -q _flag_case_sensitive)
        set flags $flags -i
    end

    # Have to wait till after the -z (zero length) test to do this
    if test (string match $flags "$prefix" -- '^\*')
        set prefix ""
    end

    printf "Using prefix: '%s'\n" $prefix

    set -l buf (command mktemp)

    # Search for matching variables
    set -l found_vars
    for var_line in (set -x)
        set var_name (string split ' ' $var_line)[1]
        if string match {$flags} "$prefix*" $var_name
            set var_value $$var_name
            set -a found_vars "$var_name = $var_value"
            printf "%s = %s\n" $var_name $var_value >>$buf
        end
    end

    # Output results or error message

    if test (count $found_vars) -gt 0
        # set -l buf (command mktemp)
        printf "Environment variables starting with '%s':" $prefix
        printf "\n"
        switch $sorted
            case 1
                command cat $buf | sort
            case '*'
                command cat $buf
        end
        command rm $buf || return $status
        return 0
    else # else handles fall-through case(s), which shouldn't really happen anyway
        printf "No environment variables with prefix '%s' could be found.\n" $prefix
        command rm $buf || return $status
        return 0
    end
end

#     set -l ht " "
#     printf "\
# Usage: env_prefix [OPTIONS] [PREFIX]
#
# Prints all environment variables with a specific prefix
# defaults to XDG_ if none given.
#
# Options:
#
# $ht -h | --help                # Show this help message and exit
# $ht -p | --prefix PREFIX       # Specify the prefix to search for (default: XDG_)
# $ht -s | --sort                # Sort the output alphabetically
#
# Examples:
#
# $ht env_prefix                 # Lists all environment variables starting with 'XDG_'
# $ht env_prefix -p HOME         # Lists all environment variables starting with 'HOME'
# $ht env_prefix --sort          # Lists all environment variables starting with 'XDG_' sorted alphabetically
# $ht env_prefix -p PATH --sort  # Lists all environment variables starting with 'PATH' sorted alphabetically
# "
#     return 0
