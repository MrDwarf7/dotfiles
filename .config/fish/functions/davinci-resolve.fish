#!/usr/bin/env fish
#

function davinci-resolve --wraps=source --description 'Launch DaVinci Resolve'
    # set -l qt_qpa_kv (env | grep ^QT_QPA_PLATFORM=)
    set -l qt_key_name QT_QPA_PLATFORM
    set -l qt_key_value xcb

    set -l davinci_exec /opt/resolve/bin/resolve

    # Handle the fact that DR uses python
    if 00valid_pacman mise
        mise deactivate
    end

    eval "$qt_key_name=$qt_key_value $davinci_exec &>/dev/null &; disown"
    commandline -f repaint
    01eval_if_pacman mise "mise activate fish | source"
    return 0
end
