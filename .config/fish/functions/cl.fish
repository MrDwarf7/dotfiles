#!/usr/bin/env fish

function cl 
    command pwd | win32yank.exe -i
end
