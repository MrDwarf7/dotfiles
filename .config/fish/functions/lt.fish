#!/usr/bin/env fish
#

function lt --description 'List files in a directory with tree view'
    argparse h/help d/depth l/level n/num -- $argv
    or return

    # Dummy variable to hold the location parsed in by user.
    set -l rest

    if test -z $LIST_CLIENT
        printf "LIST_CLIENT is not set\n"
        set -gx LIST_CLIENT ls
        return 1
    end

    if set -q _flag_help
        printf "Usage: lt [OPTIONS] [DIRECTORY]\n"
        printf "List files in a directory with tree view.\n\n"
        printf "Options:\n"
        printf "  -h, --help      Show this help message and exit\n"
        printf "  -d, --depth     Set the depth of the tree view (default: 2)\n"
        printf "  -l, --level     Set the level of the tree view (default: 2)\n"
        printf "  -n, --num       Set the number of items to show per directory (default: all)\n"
        return 0
    end

    if set -q _flag_depth
        set depth $argv[1]
        set rest $argv[2..-1]
    else if set -q _flag_level
        set depth $argv[1]
        set rest $argv[2..-1]
    else if set -q _flag_num
        set depth $argv[1]
        set rest $argv[2..-1]
    else # Nothing, so we use a default, and from the first elem onwards
        set depth 2
        set rest $argv[1..-1]
    end

    command $LIST_CLIENT -a --tree --level=$depth --icons=always $rest
    return $status
end
