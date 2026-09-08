#!/usr/bin/env fish
#

function vherm --description "Open the hermes config file in the default \$EDITOR" --argument-names editor_args
    test -n "$editor_args"; and set -l c ":$editor_args"; or set -l c ""
    $EDITOR "$(set -q HERMES_HOME; and echo "$HERMES_HOME"; or echo "$HOME/.hermes")/config.yaml$c"
end
