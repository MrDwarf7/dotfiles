#!/usr/bin/env fish
#

function lt --description 'List files in a directory with tree view'
    argparse h/help d/depth= l/level= n/num= -- $argv
    or return

    # Show help if requested
    if set -q _flag_help
        printf "Usage: lt [OPTIONS] [DIRECTORY]\n"
        printf "List files in a directory with tree view.\n\n"
        printf "Options:\n"
        printf "  -h, --help         Show this help message and exit\n"
        printf "  -d, --depth LEVEL  Set the depth of the tree view (default: 2)\n"
        printf "  -l, --level LEVEL  Alias for --depth\n"
        printf "  -n, --num COUNT    Set the number of items to show per directory\n"
        return 0
    end

    # Check if LIST_CLIENT is set, set default if not
    if test -z "$LIST_CLIENT"
        printf "LIST_CLIENT is not set, using 'ls' as fallback\n" >&2
        set -gx LIST_CLIENT ls
    end

    # Set depth/level (--level is alias for --depth)
    set -l depth 2
    if set -q _flag_depth
        set depth $_flag_depth
    else if set -q _flag_level
        set depth $_flag_level
    end

    # Build command arguments based on LIST_CLIENT capabilities
    set -l cmd_args

    # Check if we're using exa/eza (which support tree view) or fallback ls
    if string match -q "*eza*" $LIST_CLIENT; or string match -q "*exa*" $LIST_CLIENT
        # exa/eza supports tree view and advanced options
        set cmd_args -a --tree --level=$depth --icons=always

        # Add num limit if specified (eza uses --limit, exa might use different syntax)
        if set -q _flag_num
            set -a cmd_args --limit=$_flag_num
        end
    else
        # Fallback to basic ls (no tree view available)
        # printf "\033[33mWarning:\033[0m Tree view not available with '%s', using basic listing\n" $LIST_CLIENT >&2
        colorize yellow "Warning: Tree view not available with '$LIST_CLIENT', using basic listing"
        set cmd_args -la --color=always
    end

    # Add remaining arguments (directories/files)
    if test (count $argv) -gt 0
        set -a cmd_args $argv
    end

    # Execute the command
    command $LIST_CLIENT $cmd_args
    return $status
end
