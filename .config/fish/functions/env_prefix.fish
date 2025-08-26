#!/usr/bin/env fish
#

function env_prefix_help
    printf "Usage: env_prefix [OPTIONS] [PREFIX]\n"
    printf "\n"
    printf "Prints all environment variables with a specific prefix\n"
    printf "defaults to XDG_ if none given.\n"
    printf "\n"
    printf "Options:\n"
    printf "  -p, --prefix PREFIX   Specify the prefix to search for (default: XDG_)\n"
    printf "  -s, --sort           Sort the output alphabetically\n"
    printf "  -h, --help           Show this help message and exit\n"
    printf "\n"
    printf "Examples:\n"
    printf "  env_prefix            # Lists all environment variables starting with 'XDG_'\n"
    printf "  env_prefix -p HOME    # Lists all environment variables starting with 'HOME'\n"
    printf "  env_prefix --sort     # Lists all environment variables starting with 'XDG_' sorted alphabetically\n"
    printf "  env_prefix -p PATH --sort  # Lists all environment variables starting with 'PATH' sorted alphabetically\n"
    return 0
end

function env_prefix --description 'Prints all environment variables with a specific prefix, defaults to XDG_ if none given'
    argparse s/sort h/help p/prefix= -- $argv
    or return

    if set -q _flag_help
        env_prefix_help && return $status
    end

    set -l prefix
    set -l sorted 0

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

    # Have to wait till after the -z (zero length) test to do this
    if test (string match -q "$prefix" -- '^\*')
        set prefix ""
    end

    printf "Using prefix: '%s'\n" $prefix

    set -l buf (command mktemp)

    # Search for matching variables
    set -l found_vars
    for var_line in (set -x)
        set var_name (string split ' ' $var_line)[1]
        if string match -q "$prefix*" $var_name
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
    else
        printf "No environment variables with prefix '%s' could be found.\n" $prefix
        command rm $buf || return $status
        return 0
    end
    command rm $buf || return $status
    return 0
end
