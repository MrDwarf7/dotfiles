#!/usr/bin/env fish
#

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

function mypath_help
    printf "Usage: mypath [OPTIONS]\n"
    printf "\n"
    printf "Pretty print your current \$PATH variable.\n"
    printf "\n"
    printf "-m/--marker requires a character argument to specify the marker character.\n"
    printf "It's also an exclusive flag, and cannot be used with -p/--pretty.\n"
    printf "\n"
    printf "Options:\n"
    printf "  -h, --help               Show this help message and exit\n"
    printf "  -m, --marker CHAR        Use the specified marker character at the end of each PATH entry\n"
    printf "  -p, --pretty             Pretty print the PATH variable (default)\n"
    printf "\n"
    printf "Examples:\n"
    printf "  mypath                   # Pretty print the PATH variable\n"
    printf "  mypath -h | --help       # Show this help message\n"
    printf "  mypath -m ':'            # Uses ':' as the marker character at the end of each PATH entry\n"
    printf "  mypath -p | --pretty     # Pretty print the PATH variable\n"
    return 1
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
    argparse -x m,h -x m,p h/help p/pretty m/marker= -- $argv
    or return 1

    # printf "argv_opts[1]: %s\n" $argv_opts[1] >&2
    # printf "argv_opts[2]: %s\n" $argv_opts[2] >&2

    # sanity_one $argv_opts

    # help => early return
    if set -q _flag_help
        mypath_help
        return 0
    end

    if set -q _flag_marker
        # sanity_two _flag_marker $argv_opts

        # if `$argv_opts[2]` is empty, user didn't give a char
        set char $argv_opts[2]

        if test -z $char
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
