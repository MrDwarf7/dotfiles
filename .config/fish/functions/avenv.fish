#!/usr/bin/env fish
#

function avenv
    # @fish-lsp-disable-next-line 1004
    source ./.venv/bin/activate; and printf "Activated virtual environment\n"; and return 0
    printf "Failed to activate virtual environment\n"; and return 1
end
