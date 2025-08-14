#!/usr/bin/env fish
#

# Should almost always be: 
# /usr/local/bin/shellup

set -l bin_path (which shellup 2>/dev/null)

if test -n "$bin_path"
    shellup &
end
