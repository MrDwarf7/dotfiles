#!/usr/bin/env fish
#

function is_linux --description 'True when DOT_OS is linux'
    test "$DOT_OS" = linux
end
