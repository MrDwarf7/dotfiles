#!/usr/bin/env fish
#

function cl --description 'Copy current working directory to clipboard'
    if command uname -r | tr -d '\n' | grep -iE "arch|cachyos" >/dev/null
        command pwd | tr -d '\n' | wl-copy
    else
        command pwd | win32yank.exe -i
    end
end
