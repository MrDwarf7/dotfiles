#!/usr/bin/env fish
#

function env_prefix --description 'Prints all environment variables with a specific prefix, defaults to XDG_ if none given'
    argparse p/prefix= -- $argv
    or return

    set -l prefix

    # Check if flag was used (either -p or --prefix)
    if set -q _flag_prefix
        set prefix $_flag_prefix
        # Check if positional argument was provided
    else if test (count $argv) -gt 0
        set prefix $argv[1]
    end

    # Use default if prefix is empty or not set
    if test -z "$prefix"
        set prefix XDG_
    end

    printf "Using prefix: '%s'\n" $prefix

    # Search for matching variables
    set -l found_vars
    for var_line in (set -x)
        set var_name (string split ' ' $var_line)[1]
        if string match -q "$prefix*" $var_name
            set var_value $$var_name
            set -a found_vars "$var_name = $var_value"
        end
    end

    # Output results or error message
    if test (count $found_vars) -gt 0
        echo "Environment variables starting with '$prefix':"
        echo
        for var in $found_vars
            echo $var
        end
    else
        printf "No environment variables with prefix '%s' could be found.\n" $prefix
    end
end

# function env_prefix --description 'Prints all environment variables with a specific prefix, defaults to $XDG_ if none given'
#     argparse p/prefix -- $argv
#     or return
#
#     set -l prefix
#     set -l rest
#
#     if set -q _flag_prefix && test (count $argv) -gt 1
#         set prefix $argv[1]
#         set rest $argv[2..-1]
#     else
#         # User can _also_ supply just 'VAR', without the -p or --prefix flags and we will accept it, and `set flag` to it
#         if test (count $argv[2..-1]) -gt 0
#             set prefix $argv[1]
#             set rest $argv[2..-1]
#         else
#             set prefix $argv[1]
#             set rest $argv[1..-1]
#         end
#     end
#
#     echo "prefix: $prefix"
#     echo "rest: $rest"
#
#     # If nothing, then we set defaults
#     if test -z "$prefix" || test -z "$rest"
#         set prefix XDG_
#         set rest XDG_
#         echo "No prefix or rest provided, using defaults: $prefix and $rest"
#     end
#
#     # Get all exported environment variables and filter by prefix
#     for var_line in (set -x)
#         # Extract just the variable name (before the first space)
#         set var_name (string split ' ' $var_line)[1]
#
#         # Check if variable name starts with our prefix
#         if string match -q "$prefix*" $var_name
#             # Get the actual value of the variable
#             set var_value $$var_name
#             echo "$var_name = $var_value"
#         end
#     end
#
# end
