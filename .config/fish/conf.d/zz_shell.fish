#!/usr/bin/env fish
#

# Should almost always be:
# /usr/local/bin/shellup

# Only run once we're actually using a terminal (Otherwise it runs on ly starting)
if status is-interactive # && not set -q TMUX ## may need to turn it off when auto-starting tmux, maybe
    set -l bin_path (which shellup 2>/dev/null)

    if test -n "$bin_path"
        shellup &
    end
    return 0
end
