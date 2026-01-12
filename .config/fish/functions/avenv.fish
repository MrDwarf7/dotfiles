#!/usr/bin/env fish
#

function avenv
    # @fish-lsp-disable-next-line 1004
    source ./.venv/bin/activate
    printf "Activated virtual environment\n"
end
