#!/usr/bin/env fish
#
# sysup/plan.fish -- build the ordered step list, honoring --skip
#
# Reads the registry for the default order and for skip-letter mapping.
# No hardcoded step names here -- fully derived from sysup_steps.

function __sysup_plan --description 'Build the update step plan'
    argparse 's/skip=' -- $argv
    or return 1

    # default order = registry order
    set -l order
    for entry in $sysup_steps
        set -l parts (string split '|' $entry)
        set -a order $parts[1]
    end

    if set -q _flag_skip; and test -n "$_flag_skip"
        for c in (string split '' $_flag_skip)
            set -l matched false
            for entry in $sysup_steps
                set -l parts (string split '|' $entry)
                if test "$parts[2]" = "$c"
                    # drop this step name from the order list.
                    # plain `set`, not `set -l`: `order` is already local to
                    # this function; `set -l` here would shadow it and the
                    # change would be lost when the block ends.
                    set order (string match -v -- $parts[1] $order)
                    set matched true
                end
            end
            if not $matched
                colorize red "Invalid skip token: $c\n"
                return 1
            end
        end
    end

    for name in $order
        echo $name
    end
end
