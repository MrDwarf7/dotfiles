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

function __dot_vcs --argument-names vcs
    # Set only locally
    set -l cmd_str
    switch $vcs
        case jj
            set cmd_str "jj log -n 10 --no-pager -r \"stack(@) | present(trunk())\""

        case git
            set cmd_str "git fetch ; printf \"\n\" ; git status ; printf \"\n\""

        case (test -z "$vcs")
            colorize red "Error: No valid version control system found. Please install 'jj' or 'git'.\n"
            return 1
    end
    printf "%s" $cmd_str
end

function __dot_vcs_files --argument-names vcs
    # Set only locally
    set -l cmd_str
    switch $vcs
        case jj
            set cmd_str "; printf \"\nFiles:\n\" ; jj log --no-graph -r @ -T 'if(empty, \"\", diff.summary())' ; printf \"\n\""

        case git
            set cmd_str "; git log -n 10 --oneline --graph --decorate --all ; printf \"\n\""

        case (test -z "$vcs")
            colorize red "Error: No valid version control system found. Please install 'jj' or 'git'.\n"
            return 1
    end
    printf "%s" $cmd_str
end

function dot --argument-names cmd --description 'Show latest changes in the dotfiles repo (uses jj if available, otherwise git)'
    argparse $k_help/help $k_files/files $k_pop/pop -- $cmd
    or return

    if set -q _flag_help
        dot_help && return $status
    end

    set -l vcs
    set --path previous_dir (pwd) # Save the current directory for return

    # If we're not in the dotfiles dir, move there
    99-pushd_var $DOT_DIR || cd $DOT_DIR || begin
        colorize red "Error: Failed to move to dotfiles directory '$DOT_DIR'!\n"
        return 1
    end

    if 00-valid_pacman jj || jj git root 2>&1
        set vcs jj
    else if 00-valid_pacman git
        set vcs git
    else
        colorize red "Error: Neither 'jj' nor 'git' is installed. Please install one of them to use this function.\n"
        return 1
    end

    set cmd_string (__dot_vcs $vcs) # Set vcs command
    set -q _flag_files; and set --append cmd_string (__dot_vcs_files $vcs) # if `-f` passed, append files command

    # finally; run the command
    eval $cmd_string || begin
        set -l stt (test -z "$status"; and echo 1; or echo $status)
        colorize red "Error: Failed to execute command '$cmd_string'!\nStatus: $stt\n"
        return 1
    end

    if set -q _flag_pop
        colorize yellow "\n<< popd\n"
        99-popd_var $previous_dir || pushd || begin
            set -l stt (test -z "$status"; and echo 1; or echo $status)
            colorize red "Error: Failed to return to previous directory '$previous_dir'!xx\nStatus: $stt\n"
            return 1
        end
    end

    return 0
end
