#!/usr/bin/env fish
#

function cl --description 'Copy current working directory to clipboard'
    if not set -q CLIP_COPY
        colorize red "CLIP_COPY is unset; conf.d/00-os.fish did not run\n"
        return 1
    end
    command pwd | tr -d '\n' | $CLIP_COPY
end
