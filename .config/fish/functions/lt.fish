#!/usr/bin/env fish
#

# TODO: [common_list_client] : Move the 'base' cmd to either an env var, or a func call or something

set k_help h
set k_depth d
set k_level l
set k_num n

function __lt_help
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

    argparse $k_help/help $k_depth/depth= $k_level/level= $k_num/num= -- $argv
    or return

    # Show help if requested
    if set -q _flag_help
        __lt_help
        return 0
    end

    # set --append __base "-laho $argv"
    # eval $__base

    # Check if LIST_CLIENT is set, set default if not

    # Set depth/level (--level is alias for --depth)
    set -l depth 2
    if set -q _flag_depth
        set depth $_flag_depth
    else if set -q _flag_level
        set depth $_flag_level
    end

    if string match -q ls $LIST_CLIENT; or string match -q /usr/bin/ls $LIST_CLIENT
        colorize yellow "Warning: Tree view not available with '$LIST_CLIENT', using tree instead"
        if 00valid_pacman tree
            set -l args "-L $depth -a -C --dirsfirst -l"
            command tree $args $argv
            return $status
        end
        colorize red "Error: 'tree' command not found. Please install 'tree' to use tree view with '$LIST_CLIENT'."
        return 1
    end

    set __base $(099listing_cmd_base)

    # Check if we're using exa/eza (which support tree view) or fallback ls
    set --append __base "--tree --level=$depth -a"

    if set -q _flag_num
        set --append __base --limit=$_flag_num
    end

    set --append __base $argv
    eval $__base

    return $status
end
