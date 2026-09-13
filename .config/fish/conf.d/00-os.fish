#!/usr/bin/env fish
#
# OS SSoT. Must sort before every other conf.d file (00-os < 01-env).
# Consult var: DOT_OS (lowercased uname -s: linux | darwin | ...).
# CLIP_COPY / CLIP_PASTE / OPEN_CMD are set here once; consumers read the names.

set -gx DOT_OS (string lower -- (uname -s))

switch $DOT_OS
    case darwin
        set -gx CLIP_COPY pbcopy
        set -gx CLIP_PASTE pbpaste
        set -gx OPEN_CMD open
        if test -x /opt/homebrew/bin/brew
            /opt/homebrew/bin/brew shellenv fish | source
        else if test -x /usr/local/bin/brew
            /usr/local/bin/brew shellenv fish | source
        end
    case linux
        set -gx CLIP_COPY wl-copy
        set -gx CLIP_PASTE wl-paste
        set -gx OPEN_CMD xdg-open
end
