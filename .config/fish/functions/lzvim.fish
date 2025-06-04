#!/usr/bin/env fish

function lzvim 
    set -gx ORIG $NVIM_APPNAME || set -gx ORIG 'nvim'
    set -gx NVIM_APPNAME 'lazyvim'
    nvim $argv
    set -gx NVIM_APPNAME $ORIG
    # set -e ORIG
end
