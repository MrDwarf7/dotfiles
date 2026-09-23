#!/usr/bin/env fish
#

# This is used ONLY when multiple deps need to be checked and the
# caller wants to know which ones are missing.
# If you have only a single dep. use 00-valid_pacman instead.
#

function 99-check_dependencies_names --argument-names should_early_exit programs --description "Checks an array of programs for dependencies. If any are missing, it will return a non-zero exit code. If should_early_exit is true, it will exit on the first missing dependency with an EC of 99."
    set -l should_early_exit $argv[1]
    set -l programs $argv[2..-1]
    test -z "$programs"; and return 0

    set programs (string split ' ' -- (string trim $programs))
    set missing_progs

    # set -l length (count $programs)

    # for i in (seq 1 $length)
    for i in (seq (count $programs)) #                                  ### will give actual index's from 1..
        # for i in $programs                                            ### will give names
        set -l prog (string trim -- $programs[$i])
        if not 00-valid_pacman $prog
            if test "$should_early_exit" = true
                printf "Exiting early due to missing dependency: %s\n" "$prog"
                return 99
            end

            set -a missing_progs $prog
        end
    end

    # exit with 0 if no missing dependencies
    test -z "$missing_progs"; and return 0

    printf "%s\n" "$missing_progs" # return the VALUES of missing
end
