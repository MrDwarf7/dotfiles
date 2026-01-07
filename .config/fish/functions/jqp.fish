#!/usr/bin/env fish
#

function jqp --wraps=source --description 'Wraps the jqp command to use a custom config location'
    if not test -z "$JQP_CONFIG_HOME"
        set -gx JQP_CONFIG_HOME "$XDG_CONFIG_HOME/jqp"
    end
    if not test -z "$JQP_CONFIG_HOME_FILE"
        set -gx JQP_CONFIG_HOME_FILE "$JQP_CONFIG_HOME/.jqp.yaml"
    end
    command jqp --config "$JQP_CONFIG_HOME_FILE" $argv
end
