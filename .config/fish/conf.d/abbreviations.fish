#!/usr/bin/env fish
#

# abbr -

# for:
#
# _file_ $(command -v <prog>) - eg: `file $(command -v <nvim>) -> `file $(which nvim)` { sort of... can't use which without `head` which we don't need here }
# or
# _nvim_ $(command -v <prog>) - eg: `nvim $(command -v <nvim>) -> `nvim $(which nvim)` - edit the runnable file { if it's actually editable... Can't open elf things etc. }

# This is more or less the general shape of what we want so
# we can invoke `<foo>` as whatever program we need
# +
# `<bar>` as the target program we want to run `<foo>` on,
# and it will resolve to the correct path for `<bar>` at runtime.
#
# <foo> $(command -v <bar>)

# abbr -a _file_ 'file (command -v $argv[1])'
# abbr --regex
# abbr --set-cursor

# Pull the last command from history and use it as a function for abbreviation
function last_history_item
    echo $history[1]
end
# Expands to the previous command in history, regardless of position in the command line
abbr -a ^^ --position anywhere --function last_history_item

# Re-insert the last command with sudo prefixed, regardless of position in the command line
function sudo_last_command
    echo "sudo $history[1]"
end
abbr -a !! --position anywhere --function sudo_last_command

##
##
## Messy - see below TODO item.
##
##

function file_resolver_for_cmd
    echo "file (command -v !)"
end
abbr -a fe --position anywhere --set-cursor=! --function file_resolver_for_cmd

function nvim_resolver_for_cmd
    echo "nvim (command -v !)"
end
abbr -a ve --position anywhere --set-cursor=! --function nvim_resolver_for_cmd

function bat_resolver_for_cmd
    printf "bat (command -v !)"
end
abbr -a be --position anywhere --set-cursor=! --function bat_resolver_for_cmd

# TODO: We want to be able to do something like:
# We can do a couple things:
# We can see what's already on the cli at invok time,
# and we can also 'set a cursor' (to a position via the use of --set-cursor and usin the assign symbol ('%' in this case) to set the cursor position in the expansion of the abbreviation.
#
# This _SHOULD_ allow us to do:
# `re <prog> $(command -v <cursor>)`
# We MAY have to compromise and aim for something like:
# `<prog> re` => `<prog> $(command -v <cursor>)`
# and do so via the `--regex` flag on the abbreviation to match the `<prog>` and then use the `--set-cursor` to set the cursor position after the expansion of the abbreviation.
#
# We care about _what we'll use_ and can add the _on what_ after the expansion has happened.
#

# Generic entry point (the `--function` flag for abbr DOES NOT allow parsing arguments in so we have to do it based on a secondary arg
# found inside of the cli itself.
# function resolver_for_cmd
#     # close.
#     # we're getting:
#     # `nvim re` => `nvim nvim (command -v nvim)` - which is close, but not exactly what we want.
#     # set -l cmd (commandline -pc)
#     # set -l template "{prog} (command -v {cur})"
#     # string match -r '^\S+' $cmd | read -l prog
#     # echo (string replace -r '^\S+' $prog (string replace '{prog}' $prog (string replace '{cur}' '%' $template)))
#     # set -l cursor_pos (commandline --cursor)
#     # this gives us back for:
#     # `nvim re[space]` - the SPACE causes the expansion,
#     # and the 'cursor_pos' here is 8 (which IS the space itself).
#     # we basically want to cut the first word out,
#     # remove everything before we start expansions and such
#     # then insert that first word + expansions and what not.
#
#     # set -l cmd (commandline -c -B)
#     # set cmd (string trim $cmd)
#
#     set -l cmd (commandline -pc)
#     # set -l template "{prog} (command -v {cur})"
#     set -l template "(command -v {cur})"
#     string match -r '^\S+' $cmd | read -l prog
#     # This gets us:
#     # `nvim re` => `nvim re (command -v %)` so.... we don't actually need the 're' part in it, everythin else is perfect.
#     # set -l expansion (string replace '{prog}' $argv[1] (string replace '{cur}' '%' $template))
#
#     set -l expansion (string match -r '^\S+' $cmd) (string replace '{cur}' '%' $template)
#     # set extension (string replace 're' '' $expansion)
#
#     # This get us:
#     # `nvim re` => `nvim nvim (command -v %)` gettin further away from what we waant....
#     # set -l expansion (string replace '{prog}' $prog (string replace '{cur}' '%' $template))
#
#     # echo $expansion
#     printf "%s\n" "(command -v %)"
# end

function resolver_for_cmd
    # If we just.... don't clear the commandline then
    # we naturally ALREADY have whatever the leading program was before the expansion.
    # Potential issues though if trying to do something specific (or maybe also with the `%` and so on
    # if the '--set-cursor=<some other char>' is used,
    # but we can just use the default of `%` for now and see how it goes).

    printf "%s\n" "(command -v !)"
end

abbr -a re --position anywhere --set-cursor=! --function resolver_for_cmd

# This would be ideal cos then we don't have the overhead, but is kinda odd to do via string join shenanigans
# abbr -a re --position anywhere --set-cursor=! "$(string join ' ' -- "printf' '"%s\n"' '"(command -v !)"")"

function nvim_ripgrep
    # We _INTENTIONALLY_ don't close the second single quote here!
    printf "nvim %s" "(rgif '"!")"
end

abbr -a rv --position anywhere --set-cursor=! --function nvim_ripgrep
