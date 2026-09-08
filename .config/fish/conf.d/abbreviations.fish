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

function file_resolver_for_cmd
    echo "file (command -v !)"
end
abbr -a fe --position anywhere --set-cursor=! --function file_resolver_for_cmd

function nvim_resolver_for_cmd --description "Resolve a command to its path and open it in nvim"
    echo "nvim (command -v !)"
end
abbr -a vc --position anywhere --set-cursor=! --function nvim_resolver_for_cmd

function bat_resolver_for_cmd
    printf "bat (command -v !)"
end
abbr -a be --position anywhere --set-cursor=! --function bat_resolver_for_cmd

function resolver_for_cmd
    printf "%s\n" "(command -v !)"
end

abbr -a ie --position anywhere --set-cursor=! --function resolver_for_cmd

# This would be ideal cos then we don't have the overhead, but is kinda odd to do via string join shenanigans
# abbr -a re --position anywhere --set-cursor=! "$(string join ' ' -- "printf' '"%s\n"' '"(command -v !)"")"

function nvim_ripgrep
    # We _INTENTIONALLY_ don't close the second single quote here!
    printf "nvim %s" "(rgif '"!")"
end

abbr -a rv --position anywhere --set-cursor=! --function nvim_ripgrep
