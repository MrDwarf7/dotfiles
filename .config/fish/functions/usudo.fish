#!/usr/bin/env fish

# This function is a wrapper for sudo that preserves the environment variables.
# This is useful for when you need to run a command as root that requires environment variables.
#
# Paramaters:
#   $argv: The command to run as root
#
# System Dependencies:
#   sudo
# 
# Returns: 
#   The status code of the command that was run by the sudo command
#
function usudo
    env SHELL=(which fish) sudo -E $argv
    return $status
end
