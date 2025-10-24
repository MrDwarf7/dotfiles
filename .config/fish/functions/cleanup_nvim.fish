#!/usr/bin/env fish
#

set must_be_valid_envs XDG_CACHE_HOME XDG_CACHE_LOCAL_HOME XDG_DATA_HOME XDG_STATE_HOME
set exclude_args
# 0, 1, 2
# 0 - Yes
# 1 - No
# 2 is starting state.
set user_confirmed 2

function ensure_valid_envs
    for env_var in $must_be_valid_envs
        if not set -q $env_var
            printf "Error: %s is not set. Please set it to a valid directory.\n" $env_var
            return 1
        end
    end

    return 0
end

function construct_exclude
    set -l exclude_list $argv

    for item in $exclude_list
        # set exclude_args $exclude_args --exclude $item
        set -l escape_item (string escape -- $item)
        set -l wrapped_item
        if test (string match -r '^".*"$' $escape_item)
            set wrapped_item $escape_item
        else if test (string match -r "^\'.*\'\$" $escape_item)
            set wrapped_item $escape_item
        else
            set wrapped_item "\"$escape_item\""
        end
        set exclude_args $exclude_args --exclude $wrapped_item
    end
    set exclude_args (string trim -- (printf '%s ' $exclude_args))
    printf '%s' $exclude_args

    return 0
end

function construct_cmd
    set -l local_cmd_base $argv[1]
    set -l local_cmd_excl $argv[2]
    set -l local_cmd_target $argv[3]

    printf '%s %s %s' $local_cmd_base $local_cmd_excl $local_cmd_target

    return 0
end

function confirm_with_user

    while true
        read -l -P "Are you sure you want to proceed? (y/n): " user_input
        set user_input (string trim $user_input)
        set user_input (string lower $user_input)

        switch $user_input
            case y yes
                set user_confirmed 0
                break
            case n no
                set user_confirmed 1
                break
                # handle ctrl+c
            case ''
                printf "\nOperation cancelled by user. Exiting.\n"
                set user_confirmed 2
                return 1
            case '*'
                printf "Invalid input. Please enter 'y' or 'n'.\n"
        end
    end
    return 0
end

function cleanup
    if test -z "$exclude_args"
        set exclude_args ''
    end
    set -e exclude_args
    set exclude_args ''

    return 0
end

function cleanup_nvim --description "Clears out all nvim related directories in the .xdg/\$XDG_ spec'd folders"
    # fd --type directory --hidden --prune --absolute-path --exclude 'nvim_prev' 'nvim' # | xargs -I _ sh -c 'rm -rf _'

    # Actual settings
    set -l fd_type directory
    set -l fd_target nvim
    set -l fd_exclude nvim_prev

    # Generic exclude sets
    set -l fd_exclude_dot '\.*'
    set -l fd_exclude_underscores '_*'
    set -l fd_exclude_prevs '*_prev'
    set -l fd_exclude_backs '*_bak*' '*_backup*' '*_old*' '*_archive*'
    set -l fd_exclude_all $fd_exclude $fd_exclude_dot $fd_exclude_underscores $fd_exclude_prevs $fd_exclude_backs

    ensure_valid_envs
    if test $status -ne 0
        return 1
    end

    set -l base_dirs (for env_var in $must_be_valid_envs; echo (eval echo \$$env_var); end | grep -v '^$')
    printf "Clearing nvim directories in the following base directories:\n"
    printf '%s\n' $base_dirs

    set exclude_args (construct_exclude $fd_exclude_all)
    # printf "Exclude args: %s\n" $exclude_args

    set cmd_to_exec (construct_cmd "fd --type $fd_type --hidden --prune --absolute-path" "$exclude_args" "$fd_target") #| while read -l cmd; for dir in $base_dirs; if test -d $dir; eval $cmd $dir; end; end)
    printf '\nCommand to be executed: \n%s\n\n' $cmd_to_exec

    set target_dirs (for dir in $base_dirs; if test -d $dir; eval $cmd_to_exec $dir; end; end)
    printf "The following directories will be removed:\n"
    printf '%s\n' $target_dirs

    confirm_with_user

    if test $user_confirmed -eq 1
        colorize red "\nUser chose not to proceed. Exiting.\n"
    else if test $user_confirmed -eq 0
        colorize green "\nUser chose to proceed. Executing command.\n"
        printf '%s\n' $target_dirs | xargs -I _ sh -c 'rm -rf _'
    else
        colorize red "\nOperation cancelled by user. Exiting.\n"
        return 1
    end

    colorize blue "Function end."

    cleanup
end
