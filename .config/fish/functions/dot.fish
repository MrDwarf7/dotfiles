#!/usr/bin/env fish

function dot_help
    printf "Usage: dot [options]\n"
    printf "\n"
    printf "Options:\n"
    printf "  -h, --help        Show this help message and exit\n"
    printf "  -f, --files       Show changed files summary\n"
    printf "  -p, --pop         Pop back to the previous directory after execution\n"
    printf "\n"
    printf "Description:\n"
    printf "  Displays the latest changes in the dotfiles repository.\n"
    printf "  If 'jj' is installed and the repository is a 'jj' repo,\n"
    printf "  it will use 'jj' for logs.\n"
    printf "  Otherwise, it falls back to using 'git'.\n"
    printf "\n"
    printf "Examples:\n"
    printf "  dot                Show the latest changes in the dotfiles repo\n"
    printf "  dot -f             Show the latest changes along with a summary of changed files\n"
    printf "  dot -p             Show changes and return to the previous directory after execution\n"
    printf "  dot -f -p          Show changes, file summary, and return to previous directory\n"
    return 0
end

function dot --description 'Show latest changes in the dotfiles repo (uses jj if available, otherwise git)' --argument-names argv
    argparse h/help f/files p/pop -- $argv
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
        colorize yellow "popd\n"
        popd || return $status
    end
end
