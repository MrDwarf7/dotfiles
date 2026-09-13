#!/usr/bin/env fish
#

function is_macos --description 'True when DOT_OS is darwin'
    test "$DOT_OS" = darwin
end
