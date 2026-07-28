#!/usr/bin/env fish
#

set k_help h
set k_pretty p
set k_marker m

# function __mypath_cmp
#     complete -c mypath -f -s $k_help -l help -d 'Show help message and exit'
#     complete -c mypath -f -s $k_pretty -l pretty -d 'Pretty print the PATH variable (default)'
#     complete -c mypath -f -s $k_marker -l marker= -d 'Use the specified marker character at the end of each PATH entry'
#     complete -c mypath -f -f -a '":" "," ";" "|" "#" "!"'
# end

function __mypath_help
    if not 00-valid_pacman qsv
        return
    end

    90-help "\
Usage: mypath [OPTIONS]

Pretty print your current \$PATH variable.

-m/--marker requires a character argument to specify the marker character.
It's also an exclusive flag, and cannot be used with -p/--pretty.
" "
,,,,
,Short              ,Long               ,Description,
,,,,
,-$k_help           , --help            ,# Show this help message and exit,
,-$k_marker         , --marker CHAR     ,# Use the specified marker character at the end of each PATH entry,
,-$k_pretty         , --pretty          ,# Pretty print the PATH variable (default),
" "
,,,,
,Command                                ,Description,,
,,,,
,mypath -$k_help | --help               ,# Show this help message,,
,mypath -$k_marker ':'                  ,# Uses ':' as the marker character at the end of each PATH entry,,
,mypath -$k_pretty | --pretty           ,# Pretty print the PATH variable,,
"
    return 0

end

function marker_out
    set -l marker_char $argv[1]

    set -l v (printf "%s:" $PATH)

    # if it's not the default/already applied marker char
    # we swap it in-place with the user specified one
    if not string match -q ':' -- $marker_char
        colorize yellow "Using marker character: " $marker_char "\n" >&2
        set v (printf "%s" (printf "%s" $v | tr ':' "$marker_char"))
    end
    printf "%s\n" $v

    return 0
end

function pretty_out
    printf "Path variable:\n\n"
    printf "%s\n" $PATH
    return 0
end

function normal_out
    # set -l v (printf "%s:" $PATH)
    # printf "%s" $v | tr ':' '\n'
    printf "%s\n" $PATH
    return 0
end

function sanity_one
    set -l ar_opts $argv[1..-1]
    set ln_argv_opts (string split ' ' $ar_opts | count)

    colorize yellow "argv_opts[1]: $ar_opts[1]" >&2

    if string match -qr '(\\r|\\n)' -- $ar_opts[2]
        colorize yellow "argv_opts[2] is a newline or return character" >&2
    else
        colorize yellow "argv_opts[2]: $ar_opts[2]" >&2
    end
    colorize yellow "argv_opts:  $ar_opts" >&2
    colorize yellow "len argv_opts: $ln_argv_opts" >&2
end

function sanity_two
    set -l fm $argv[1]
    set -l ar_opts $argv[2..-1]

    set -l local_len (string length $_flag_marker)
    set -l opts_len (count $argv_opts)

    colorize green "MARKER DETECTED\n" >&2

    colorize red "argv_opts[1]: $ar_opts[1]" >&2
    if string match -qr '(\\r|\\n)' -- $ar_opts[2]
        colorize red "argv_opts[2] is a newline or return character" >&2
    else
        colorize red "argv_opts[2]: $ar_opts[2]" >&2
    end
    colorize red "local_len: $local_len" >&2
    colorize red "opts_len: $opts_len" >&2
end

# Weird caveat (need to learn why), but the $PATH var (I think?)
# is streamed in, so has some odd behaviour.
# 1. One of which is for each individual var,
# the printf calls, this
# outputs the equivialent of something like:
# printf "%s" ($PATH | tr ' ' ':' | tr ':' '\n'))
#
# 2. Storing in a variable is also kinda wonky for the same reason.
# 3. Function calls between printf vs. echo
# also behave differently.
function mypath --description 'Pretty print your current $path variable'
    # __mypath_cmp

    argparse -x m,h -x m,p h/help p/pretty m/marker= -- $argv
    or return 1

    # printf "argv_opts[1]: %s\n" $argv_opts[1] >&2
    # printf "argv_opts[2]: %s\n" $argv_opts[2] >&2

    # sanity_one $argv_opts

    # help => early return
    if set -q _flag_help
        __mypath_help
        return 0
    end

    if set -q _flag_marker
        # sanity_two _flag_marker $argv_opts

        # if `$argv_opts[2]` is empty, user didn't give a char
        set char $argv_opts[2]

        if test -z "$char"
            colorize yellow "Marker character must be at least 1 character long.\nUsing a default of ':'.\n" >&2
            set char ":"
        end
        marker_out $char
        return 0
    end

    if set -q _flag_pretty
        pretty_out
    else
        normal_out
    end

    return 0
end
#
#     set -l h " "
#     printf "\
# Usage: mypath [OPTIONS]
#
# Pretty print your current \$PATH variable.
#
# -m/--marker requires a character argument to specify the marker character.
# It's also an exclusive flag, and cannot be used with -p/--pretty.
#
# Options:
#
# $h -h, --help            # Show this help message and exit
# $h -m, --marker CHAR     # Use the specified marker character at the end of each PATH entry
# $h -p, --pretty          # Pretty print the PATH variable (default)
#
# Examples:
#
# $h mypath                # Pretty print the PATH variable
# $h mypath -h | --help    # Show this help message
# $h mypath -m ':'         # Uses ':' as the marker character at the end of each PATH entry
# $h mypath -p | --pretty  # Pretty print the PATH variable
# "
#     return 0
