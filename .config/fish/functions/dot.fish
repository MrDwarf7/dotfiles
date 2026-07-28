#!/usr/bin/env fish
#

set k_help h
set k_files f
set k_pop p

function dot_help
    if not 00-valid_pacman qsv
        colorize red "qsv is not installed. Please install qsv to use the help function.\n"
        return
    end

    90-help "\
Usage: dot [OPTIONS]

Displays the latest changes in the dotfiles
repository.
If 'jj' is installed and the repository is
a 'jj' repo, it will use 'jj' for logs.

Otherwise, it falls back to using 'git'.
" "
,                    ,                           ,           ,
,Short               ,Long                       ,Description,
,                    ,                           ,           ,
,-h                  , --help                    ,# Show this help message and exit,
,-f                  , --files                   ,# Show changed files summary,
,-p                  , --pop                     ,# Pop back to the previous directory after execution,
" "
,                                       ,           ,,
,Command                                ,Description,,
,                                       ,           ,,
,dot -h | --help                        ,# Show this help message and exit,,
,dot                                    ,# Show the latest changes in the dotfiles repo,,
,dot -f                                 ,# Show the latest changes along with a summary of changed files,,
,dot -p                                 ,# Show changes and return to the previous directory after execution,,
,dot -f -p                              ,# Show changes; file summary; and return to previous directory,,
"
    return 0

end

function dot --description 'Show latest changes in the dotfiles repo (uses jj if available, otherwise git)' --argument-names argv
    argparse $k_help/help $k_files/files $k_pop/pop -- $argv
    or return

    if set -q _flag_help
        dot_help && return $status
    end

    set -l file_flag 0
    set -l pop_flag 0

    if set -q _flag_files
        set file_flag 1
    end

    if set -q _flag_pop
        set pop_flag 1
    end

    if test "$(pwd)" != "$DOT_DIR"
        # If we're not in the dotfiles dir, move there
        # printf "Moving to: %s\n" "$DOT_DIR"
        pushd $DOT_DIR || return $status
    end

    # Make an assumption - if we can run this, clearly jj is installed
    if test (command jj git root)
        # We have a valid 'jj' repo, use jj for output(s)
        jj log -n 10 --no-pager -r "stack(@) | present(trunk())" # Get's the log output/ledger

        if test $file_flag -eq 1
            printf "\nFiles:\n"
            jj log --no-graph -r @ -T 'if(empty, "", diff.summary())' # Prints a file summary of changes (by file/filepath)
            printf "\n"
        end
    else
        printf "Using 'git' for fetching and log display...\n"
        command git fetch
        printf "\n"
        if test $file_flag -eq 1
            command git log -n 10 --oneline --graph --decorate --all
            printf "\n"
        end
        command git status
        printf "\n"
    end

    # no args, we're done, ret 0
    if not test $pop_flag -eq 1
        return 0
    end

    if test $pop_flag -eq 1
        colorize yellow "\n<< popd\n"
        popd || return $status
    end
    return 0
end

#     set -l ht " "
#     printf "\
# Usage: dot [OPTIONS]
#
# Displays the latest changes in the dotfiles
# repository.
# If 'jj' is installed and the repository is
# a 'jj' repo, it will use 'jj' for logs.
#
# Otherwise, it falls back to using 'git'.
#
# Options:
#
# $ht -h, --help       # Show this help message and exit
# $ht -f, --files      # Show changed files summary
# $ht -p, --pop        # Pop back to the previous directory after execution
#
# Examples:
#
# $ht dot -h | --help  # Show this help message and exit
# $ht dot              # Show the latest changes in the dotfiles repo
# $ht dot -f           # Show the latest changes along with a summary of changed files
# $ht dot -p           # Show changes and return to the previous directory after execution
# $ht dot -f -p        # Show changes, file summary, and return to previous directory
# "
#     return 0
