#!/usr/bin/env fish

function cl 
    if command uname -r | tr -d '\n' | grep -i "arch" > /dev/null
        command pwd | tr -d '\n' | wl-copy
    else
        command pwd | win32yank.exe -i
    end
end
