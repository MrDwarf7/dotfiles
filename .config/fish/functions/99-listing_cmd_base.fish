#!/usr/bin/env fish
#

# ## ca.fish, l.fish, la.fish
# command $LIST_CLIENT --color=always --follow-symlinks --icons=always --group-directories-first --git                              -laho
#
# ## lf.fish
# command $LIST_CLIENT --color=always --follow-symlinks --icons=always --group-directories-first --git                              -lahfo
# ## lt.fish
# command $LIST_CLIENT --color=always --follow-symlinks --icons=always --group-directories-first --git --tree --level=$depth        -a
#
# ## ls.fish
# command $LIST_CLIENT --color=always --follow-symlinks                --group-directories-first --git                              -ah

## Question here is whether we:
## 1) Take args to append flags
##    and either
##    1.a) Execute HERE (which would require params for flags
##    1.b) Print/return the base cmd WITHOUT flags (and let caller decide)
##    1.c) Hae THIS function generate a base cmd, and use another to call THIS+appender ( 099listing_cmd_append { 099listing_cmd_base => +args } )
##    1.d) Print/return the base cmd WITH argument flags attaced
##
## 2) Returning we can either:
##    2.a) Print RAW - 'as is' (as a 'return capture' type thing)
##    2.b) Wrap the cmd part ( `set <var> <cmd>` ) in a string (single vs. double ??) and print that, so it can be eval'd by the caller
##
##

function 99-listing_cmd_base --description 'Base listing cmd to remove duplications in other funcitons or aliases'
    set __base_cmd ""

    # ~'caching'~
    set -q LIST_CLIENT_BASE_CMD; and printf "%s\n" "$LIST_CLIENT_BASE_CMD"; and return 0

    # if set -q LIST_CLIENT_BASE_CMD
    #     printf "%s\n" "$LIST_CLIENT_BASE_CMD"
    #     return 0
    # end

    if test -z "$LIST_CLIENT"
        printf "LIST_CLIENT is not set\n"
        set -gx LIST_CLIENT ls
        # set -gx LIST_CLIENT_BASE_CMD "$LIST_CLIENT --color=always --group-directories-first"
        # return 1

        set __base_cmd "$LIST_CLIENT --color=auto --group-directories-first"
    else
        set __base_cmd "$LIST_CLIENT --color=auto --follow-symlinks --icons=auto --group-directories-first --git"
    end

    # set -gx LIST_CLIENT_BASE_CMD "$__base_cmd"
    # printf "%s\n" "$LIST_CLIENT_BASE_CMD"

    printf "%s\n" "$__base_cmd"
    return 0
end
