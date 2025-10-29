#!/usr/bin/env fish
#

function dyncpu --description 'Watches CPU MHz in real-time'
    # Could also technically use $argv[start..end] if you have a reason to
    command watch -n1 'grep "^cpu MHz" /proc/cpuinfo | sort -nrk4'
    return $status # returns the status of the last command executed
end
