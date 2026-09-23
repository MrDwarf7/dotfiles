#!/usr/bin/env fish
#

# This is used ONLY when multiple deps need to be checked and the
# caller wants to know which ones are missing.
# If you have only a single dep. use 00-valid_pacman instead.
#

function 99-check_dependencies_idxs --argument-names should_early_exit programs --description "Index variable version of 99-check_dependencies_names. THIS version returns `98` ON `should_early_exit`! Returns the indexes of missing dependencies instead of their names."
    set programs $argv[2..-1]
    test -z "$programs"; and return 0

    set programs (string split ' ' -- (string trim -- $programs))

    set mp (string split ' ' -- (99-check_dependencies_names $should_early_exit $programs))
    if test "$should_early_exit" = true
        test -z "$mp"; and return 0
        printf "Exiting early due to missing dependency: %s\n" "$mp"
        return 98
    end

    # test -z "$mp"; and return 0
    # indexes instead of names
    printf "%s\n" "$(string join ' ' (for i in (seq (count $programs)); if contains -- $programs[$i] $mp; echo $i; end; end))"
end
