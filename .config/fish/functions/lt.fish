#!/usr/bin/env fish
#

set k_help h
set k_depth d
set k_level l
set k_num n

function lt_cmp
    complete -c lt -s $k_help -l help -d 'Show help message and exit'
    complete -c lt -s $k_depth -l depth= -d 'Set the depth of the tree view (default: 2)'
    complete -c lt -s $k_level -l level= -d 'Alias for --depth'
    complete -c lt -s $k_num -l num= -d 'Set the number of items to show per directory'
    return 0
end

function lt_help
    if not 00valid_pacman qsv
        colorize red "qsv is not installed. Please install qsv to use the help function.\n"
        return
    end

    090help "\
Usage: lt [OPTIONS] [DIRECTORY]

List files in a directory with tree view.
" "
,                    ,                           ,           ,
,Short               ,Long                       ,Description,
,                    ,                           ,           ,
,-$k_help            , --help                    ,# Show this help message and exit,
,-$k_depth           , --depth LEVEL             ,# Set the depth of the tree view (default: 2),
,-$k_level           , --level LEVEL             ,# Alias for --depth,
,-$k_num             , --num COUNT               ,# Set the number of items to show per directory,
" "
,                                       ,           ,,
,Command                                ,Description,,
,                                       ,           ,,
,lt -$k_help | --help                   ,# Show this help message and exit,,
,lt -$k_depth 3 ./my_directory          ,# List files in ./my_directory with tree view up to depth 3,,
,lt -$k_num 5                           ,# List files in current directory with tree view; showing 5 items per directory,,
"
    return 0
end

function lt --description 'List files in a directory with tree view'
    lt_cmp

    argparse $k_help/help $k_depth/depth= $k_level/level= $k_num/num= -- $argv
    or return

    # Show help if requested
    if set -q _flag_help
        lt_help
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

#     set -l h " "
#     printf "\
# Usage: lt [OPTIONS] [DIRECTORY]
#
# List files in a directory with tree view.
#
# Options:
# $h -h, --help         Show this help message and exit
# $h -d, --depth LEVEL  Set the depth of the tree view (default: 2)
# $h -l, --level LEVEL  Alias for --depth
# $h -n, --num COUNT    Set the number of items to show per directory
#
# Examples:
# $h lt -h | --help                   # Show this help message and exit
# $h lt -d 3 ./my_directory          # List files in ./my_directory with tree view up to depth 3
# $h lt -n 5                       # List files in current directory with tree view, showing 5 items per directory
# "
#     return 0
