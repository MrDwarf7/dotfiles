#!/usr/bin/env fish
#

# Primitive for other commands to call into.
# Easier to maintain because a single command wrapper exists for all other commands to call into.
# - Also prevents multi-stacked calls to 00-valid_pacman

function h --wraps=herdr --description "Shorthand alias for 'herdr'"
    not 00-valid_pacman herdr; and return 0
    # if not 00-valid_pacman herdr
    #     return 0
    # end
    command herdr $argv
end
